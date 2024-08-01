// Minimal implementation of the token bridge that can move funds between L1 <> L2.
// The bridge has a corresponding Portal contract on L1 that it is attached to
// And corresponds to a Token on L2 that uses the `AuthWit` accounts pattern.
// Bridge has to be set as a minter on the token before it can be used

contract TokenBridge {
    use dep::aztec::prelude::{FunctionSelector, AztecAddress, EthAddress, PublicMutable, SharedImmutable};

    use dep::token_portal_content_hash_lib::{get_mint_public_content_hash, get_mint_private_content_hash, get_withdraw_content_hash};

    use dep::token::Token;

    // Storage structure, containing all storage, and specifying what slots they use.
    #[aztec(storage)]
    struct Storage {
        token: PublicMutable<AztecAddress>,
        portal_address: SharedImmutable<EthAddress>,
    }

    // Initializer function, this runs first to initialize variables in the storage
    #[aztec(public)]
    #[aztec(initializer)]
    fn constructor(token: AztecAddress, portal_address: EthAddress) {
        storage.token.write(token);
        storage.portal_address.initialize(portal_address);
    }

    // Consumes a L1->L2 message and calls the token contract to mint the appropriate amount publicly
    #[aztec(public)]
    fn claim_public(to: AztecAddress, amount: Field, secret: Field, message_leaf_index: Field) {
        // Recomputes the L1->L2 message. Similar with TokenPortal.sol's deposit function for the content_hash
        // Important: to and amount is included here. If attackers input their own address, the content hash will be different 
        // to what the token portal had calculated on L1.
        let content_hash = get_mint_public_content_hash(to, amount);

        // Consume message and emit nullifier
        context.consume_l1_to_l2_message(
            content_hash, //The content - which is reconstructed in the get_mint_public_content_hash()
            secret, //The secret used for consumption, often 0 for public messages
            storage.portal_address.read_public(), //Who on L1 sent the message. Which should match the stored portal_address in our case as we only want to allow messages from a specific sender.
            message_leaf_index //The index in the message tree of the message.
        );

        // Mint tokens
        Token::at(storage.token.read()).mint_public(to, amount).call(&mut context);
    }

    // Consumes a L1->L2 message and calls the token contract to mint the appropriate amount in private assets
    // User needs to call token.redeem_shield() to get the private assets
    #[aztec(private)]
    fn claim_private(
        secret_hash_for_redeeming_minted_notes: Field, // secret hash used to redeem minted notes at a later time. This enables anyone to call this function and mint tokens to a user on their behalf
        amount: Field,
        secret_for_L1_to_L2_message_consumption: Field // secret used to consume the L1 to L2 message
    ) {
        // Consume L1 to L2 message and emit nullifier
        let content_hash = get_mint_private_content_hash(secret_hash_for_redeeming_minted_notes, amount);
        context.consume_l1_to_l2_message(
            content_hash,
            secret_for_L1_to_L2_message_consumption,
            storage.portal_address.read_private()
        );

        // Mint tokens on L2
        // `mint_private` on token is public. So we call an internal public function
        // which then calls the public method on the token contract.
        // Since the secret_hash is passed, no secret is leaked.
        TokenBridge::at(context.this_address())._call_mint_on_token(amount, secret_hash_for_redeeming_minted_notes).enqueue(&mut context);
    }

    // This is a public call as we need to read from public storage.
    // Also, note that user hashes their secret in private and only sends the hash in public
    // meaning only user can `redeem_shield` at a later time with their secret.
    #[aztec(public)]
    #[aztec(internal)]
    fn _call_mint_on_token(amount: Field, secret_hash: Field) {
        Token::at(storage.token.read()).mint_private(amount, secret_hash).call(&mut context);
    }

    // Withdrawing from L1
    // Burns the appropriate amount of tokens and creates a L2 to L1 withdraw message publicly
    // Requires `msg.sender` to give approval to the bridge to burn tokens on their behalf using witness signatures
    #[aztec(public)]
    fn exit_to_l1_public(
        recipient: EthAddress, // ethereum address to withdraw to
        amount: Field,
        caller_on_l1: EthAddress, // ethereum address that can call this function on the L1 portal (0x0 if anyone can call)
        nonce: Field // nonce used in the approval message by `msg.sender` to let bridge burn their tokens on L2
    ) {
        // Send an L2 to L1 message
        let content = get_withdraw_content_hash(recipient, amount, caller_on_l1);
        // *Passes this content to the kernel circuit which creates the proof for the transaction
        // *Takes the recipient and content as input, and will insert a message into the outbox. We set the recipient to be the portal address read from storage of the contract.
        context.message_portal(storage.portal_address.read_public(), content);

        // Burn tokens on L2: We burn the tokens from the msg_sender(). Otherwise, a malicious user could burn someone else’s tokens and mint tokens on L1 to themselves. 
        // One could add another approval flow on the bridge but that might make it complex for other applications to call the bridge.
        Token::at(storage.token.read()).burn_public(context.msg_sender(), amount, nonce).call(&mut context);
    }

    // Burns the appropriate amount of tokens and creates a L2 to L1 withdraw message privately (similar to the public version but instead its burning/nullify the users private notes)
    // Requires `msg.sender` (caller of the method) to give approval to the bridge to burn tokens on their behalf using witness signatures
    #[aztec(private)]
    fn exit_to_l1_private(
        token: AztecAddress, //note, since its a private function, we dont have access to storage. To circumvent this, define as a param and pass it down to the internal public function and ensure the address is the same as the storage
        recipient: EthAddress, // ethereum address to withdraw to
        amount: Field,
        caller_on_l1: EthAddress, // ethereum address that can call this function on the L1 portal (0x0 if anyone can call)
        nonce: Field // nonce used in the approval message by `msg.sender` to let bridge burn their tokens on L2
    ) {
        // Send an L2 to L1 message
        let content = get_withdraw_content_hash(recipient, amount, caller_on_l1);
        context.message_portal(storage.portal_address.read_private(), content);

        // Assert that user provided token address is same as seen in storage.
        TokenBridge::at(context.this_address())._assert_token_is_same(token).enqueue(&mut context);

        // Burn tokens
        Token::at(token).burn(context.msg_sender(), amount, nonce).call(&mut context);
    }

    #[aztec(public)]
    #[aztec(internal)]
    fn _assert_token_is_same(token: AztecAddress) {
        assert(storage.token.read().eq(token), "Token address is not the same as seen in storage");
    }

    #[aztec(public)]
    #[aztec(view)]
    fn get_token() -> AztecAddress {
        storage.token.read()
    }
}