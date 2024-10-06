pragma solidity >=0.8.18;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

// Messaging
import {IRegistry} from "@aztec/l1-contracts/src/core/interfaces/messagebridge/IRegistry.sol";
import {IInbox} from "@aztec/l1-contracts/src/core/interfaces/messagebridge/IInbox.sol";
import {IOutbox} from "@aztec/l1-contracts/src/core/interfaces/messagebridge/IOutbox.sol";
import {DataStructures} from "@aztec/l1-contracts/src/core/libraries/DataStructures.sol";
import {Hash} from "@aztec/l1-contracts/src/core/libraries/Hash.sol";

contract TokenPortal {

    using SafeERC20 for IERC20;

    IRegistry public registry; //rollup registry address (that stores the current rollup, inbox and outbox contract addresses)
    IERC20 public underlying; //ERC20 token the portal corresponds to
    bytes32 public l2Bridge; //address of the sister contract on Aztec to where the token will send messages to (deposit or withdraw)

    function initialize(address _registry, address _underlying, bytes32 _l2Bridge) external {

        registry = IRegistry(_registry);
        underlying = IERC20(_underlying);
        l2Bridge = _l2Bridge;
    }

    /**
    Used to deposit funds on L1 that a user may have into an Aztec portal and send a message to the Aztec rollup to mint tokens publicly on Aztec.

    * @notice Deposit funds into the portal and adds an L2 message which can only be consumed publicly on Aztec
    * @param _to - The aztec address of the recipient
    * @param _amount - The amount to deposit
    * @param _secretHash - The hash of the secret consumable message. The hash should be 254 bits (so it can fit in a Field element)
    * @return The key of the entry in the Inbox
    */
    function depositToAztecPublic(bytes32 _to, uint256 _amount, bytes32 _secretHash) external returns (bytes32) {

        // Ask the registry for the inbox contract address (to which we need to send messages to)
        IInbox inbox = registry.getInbox();
        // Defining the Actor here, DataStructures.L2Actor(addressOfActor, version(aztec instance is on));
        DataStructures.L2Actor memory actor = DataStructures.L2Actor(l2Bridge, 1);

        // Hash the message content to be reconstructed in the receiving contract
        // Here we are encoding the the message mint_public function call to specify the exact intentions and parameters we want to execute on L2.
        // Good practice to include the parameters as well i.e. to, amount
        bytes32 contentHash = Hash.sha256ToField(abi.encodeWithSignature("mint_public(bytes32,uint256)", _to, _amount));

        // transfers tokens from the user to the portal. This holds the tokens in the portal 
        underlying.safeTransferFrom(msg.sender, address(this), _amount);

        // Send message to rollup
        // Here we are sending the message to the inbox contract
        return inbox.sendL2Message(actor, contentHash, _secretHash);
    }

    /**
    * @notice Deposit funds into the portal and adds an L2 message which can only be consumed privately on Aztec
    * @param _secretHashForRedeemingMintedNotes - The hash of the secret to redeem minted notes privately on Aztec. The hash should be 254 bits (so it can fit in a Field element)
    * @param _amount - The amount to deposit
    * @param _secretHashForL2MessageConsumption - The hash of the secret consumable L1 to L2 message. The hash should be 254 bits (so it can fit in a Field element)
    * @return The key of the entry in the Inbox
    */
    function depositToAztecPrivate( bytes32 _secretHashForRedeemingMintedNotes, uint256 _amount, bytes32 _secretHashForL2MessageConsumption) external returns (bytes32) {
        // Preamble
        IInbox inbox = registry.getInbox();
        DataStructures.L2Actor memory actor = DataStructures.L2Actor(l2Bridge, 1);

        // Hash the message content to be reconstructed in the receiving contract
        bytes32 contentHash = Hash.sha256ToField(
            abi.encodeWithSignature(
            //mint_private is different from the public deposit function above but also similar at the same time.
            //*Use different name to seperate concerns and if the same then an attacker can could consume the a private message publicly
            //*since we want to mint tokens privately, we should include a 'to' field (compared to the public one above). Instead we use _secretHashForRedeemingMintedNote
    
            "mint_private(bytes32,uint256)", _secretHashForRedeemingMintedNotes, _amount 
            )
        );

        // Hold the tokens in the portal
        underlying.safeTransferFrom(msg.sender, address(this), _amount);

        // Send message to rollup
        return inbox.sendL2Message(actor, contentHash, _secretHashForL2MessageConsumption);
    }

    /**
    Withdrawing on L1: After the transaction is completed on L2, the portal must call the outbox to successfully transfer funds to the user on L1. 
    * @notice Withdraw funds from the portal
    * @dev Second part of withdraw, must be initiated from L2 first as it will consume a message from outbox
    * @param _recipient - The address to send the funds to
    * @param _amount - The amount to withdraw
    * @param _withCaller - Flag to use `msg.sender` as caller, otherwise address(0)
    * @param _l2BlockNumber - The address to send the funds to
    * @param _leafIndex - The amount to withdraw
    * @param _path - Flag to use `msg.sender` as caller, otherwise address(0)
    * Must match the caller of the message (specified from L2) to consume it.
    */
    function withdraw(address _recipient, uint256 _amount, bool _withCaller, uint256 _l2BlockNumber, uint256 _leafIndex, bytes32[] calldata _path) external {
        // Reconstruct the L2 to L1 message and check that this message exists on the outbox
        DataStructures.L2ToL1Msg memory message = DataStructures.L2ToL1Msg({
            sender: DataStructures.L2Actor(l2Bridge, 1),
            recipient: DataStructures.L1Actor(address(this), block.chainid),
            content: Hash.sha256ToField(
            abi.encodeWithSignature(
                "withdraw(address,uint256,address)",
                _recipient,
                _amount,
                //determines the appropriate party that can execute this function on behalf of the recipient.
                _withCaller ? msg.sender : address(0) 
            )
            )
        });
        // If exists we consume it and transfer the funds to the recipient
        IOutbox outbox = registry.getOutbox();

        outbox.consume(message, _l2BlockNumber, _leafIndex, _path);

        underlying.transfer(_recipient, _amount);
    }
}
