# Sequence Diagram

## Logical Execution Flow
The sequence diagram illustrates the cross-chain token transfer process between Layer 1 and Layer 2 in the Aztec network, showing the complete cycle of depositing tokens from L1 to L2, and withdrawing them back to L1, including necessary message passing and verifications. 
> [!NOTE]
> The L2 inbox only exists conceptually and its functionality is handled by the kernel and the rollup circuits.
``` mermaid
sequenceDiagram
    autonumber
    actor User
    box Blue Layer 1
    participant L1 Token
    participant TokenPortal
    participant L1 Inbox
    participant L1 Outbox
    participant Validating Light Node
    end
    box Green Layer 2
    participant Rollup Contract
    participant L2 Bridge
    participant L2 Token
    participant L2 Outbox
    participant L2 Inbox
    end
    User->>User: Generate claim secrets
    User->>TokenPortal: Deposit tokens
    TokenPortal->>L1 Token: Transfer tokens from User
    TokenPortal->>L1 Inbox: Send 'mint' message to L2
    L1 Inbox->>L1 Inbox: Insert message into tree
    Note over L1 Inbox,L2 Bridge: Wait for message to be consumable
    L2 Bridge->>L2 Outbox: Consume L1->L2 message
    L2 Bridge->>L2 Token: Mint tokens on L2
    User->>L2 Token: Redeem/claim minted tokens
    Note over User,L2 Token: User now has tokens on L2
    User->>L2 Bridge: Create auth witness for token burn
    User->>L2 Bridge: Initiate withdrawal to L1
    L2 Bridge->>L2 Token: Burn tokens
    L2 Bridge->>L2 Inbox: Add withdrawal message
    Rollup Contract->>L2 Inbox: Consume message
    Rollup Contract->>L2 Outbox: Insert withdrawal message
    Rollup Contract->>Validating Light Node: Submit L2 block (Proof + Data)
    Validating Light Node->>Validating Light Node: Verify proof and update state
    Validating Light Node->>L1 Outbox: Insert withdrawal message from L2
    User->>TokenPortal: Request withdrawal on L1
    TokenPortal->>L1 Outbox: Verify withdrawal message
    L1 Outbox->>L1 Outbox: Consume withdrawal message
    TokenPortal->>L1 Token: Transfer tokens to User
    Note over User,L1 Token: User has received tokens on L1




```
The sequence diagram above is numbered to show the logical flow of the cross-chain communication process. The steps are as follows:
1. User generates claim secrets: The user creates secret values needed for secure cross-chain transfers.
2. User deposits tokens to TokenPortal: The user sends tokens to the TokenPortal contract on L1.
3. TokenPortal transfers tokens from User: The TokenPortal contract moves the deposited tokens from the user's account to itself.
4. TokenPortal sends 'mint' message to L2: The TokenPortal initiates a cross-chain message to L2 via the L1 Inbox.
5. L1 Inbox inserts message into tree: The message is added to the L1 Inbox's data structure for cross-chain communication.
6. L2 Bridge consumes L1->L2 message: The L2 Bridge processes the incoming message from L1.
7. L2 Bridge mints tokens on L2: Equivalent tokens are created on L2 based on the L1 deposit.
8. User redeems/claims minted tokens: The user claims the newly minted tokens on L2.
9. User creates auth witness for token burn: The user prepares authorization for burning tokens on L2.
10. User initiates withdrawal to L1: The user starts the process to move tokens back to L1.
11. L2 Bridge burns tokens: The specified amount of tokens is destroyed on L2.
12. L2 Bridge adds withdrawal message: A message about the withdrawal is added to the L2 Inbox.
13. Rollup Contract consumes message: The L2 Rollup Contract processes the withdrawal message.
14. Rollup Contract inserts withdrawal message: The processed message is added to the L2 Outbox.
15. Rollup Contract submits L2 block: The L2 block, including the withdrawal info, is sent to L1.
16. Validating Light Node verifies proof: The L1 node checks the validity of the L2 block and its data.
17. Validating Light Node inserts withdrawal message: The verified withdrawal info is added to the L1 Outbox.
18. User requests withdrawal on L1: The user initiates the final step to receive tokens on L1.
19. TokenPortal verifies withdrawal message: The L1 TokenPortal checks the withdrawal request against the L1 Outbox data.
20. L1 Outbox consumes withdrawal message: The L1 Outbox marks the withdrawal message as processed.
21. TokenPortal transfers tokens to User: The original tokens are released back to the user on L1.