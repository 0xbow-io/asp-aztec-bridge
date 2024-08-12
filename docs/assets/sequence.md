# Sequence Diagram
``` mermaid
sequenceDiagram
    autonumber
    actor User
    box Blue Layer 1
    participant Portal
    participant Inbox (L1)
    participant Outbox (L1)
    participant Validating Light Node (L1)
    end
    box Green Layer 2
    participant Rollup Contract
    participant Outbox (L2)
    participant Inbox (L2)
    participant Portal (L2 sister contract)
    end
    User->>User: Connects wallet
    User->>User: Inputs 10 USDC and clicks transfer
    User->>Portal: Deposits 10 USDC to the portal
    Portal->>Inbox (L1): Send 'mint' msg to L2 (aztec)
    Inbox (L1)->>Inbox (L1): Populate msg values
    Note right of Inbox (L1): Think of inbox/outbox as trees
    Inbox (L1)->>Inbox (L1): Update state (msg inserted into inbox)
    Note right of Inbox (L1): inbox inserts messages into message tree
    Portal (L2 sister contract)->>Outbox (L2): Consume msg initiated to read the msg from L1
    Outbox (L2)->>Outbox (L2): Consumes msg
    Note left of Outbox (L2): During consumption, it checks for the corresponding message in the message tree
    Outbox (L2)->>Outbox (L2): Validates msg 
    Outbox (L2)->>Outbox (L2): Update state (nullify)
    Portal (L2 sister contract)->>Inbox (L2): Add msg
    Inbox (L2)->>Inbox (L2): Populate msg values
    Inbox (L2)->>Inbox (L2): Update state (insert)
    Rollup Contract->>Inbox (L2): Consume msg
    Inbox (L2)->>Inbox (L2): Update state (delete)
    Rollup Contract->>Outbox (L2): Insert msg
    Outbox (L2)->>Outbox (L2): Update state (insert)
    Rollup Contract->>Validating Light Node (L1): Block (Proof + Data)
    Validating Light Node (L1)->>Validating Light Node (L1): Verify proof
    Validating Light Node (L1)->>Validating Light Node (L1): Update state
    Validating Light Node (L1)->>Inbox (L1): Consume l1Tol2 msgs from L1
    Inbox (L1)->>Inbox (L1): Update state (next tree)
    Validating Light Node (L1)->>Outbox (L1): Insert messages from L2
    Outbox (L1)->>Outbox (L1): Update state (insert root)
    Portal->>Outbox (L1): Consume msg
    Outbox (L1)->>Outbox (L1): Validate msg
    Outbox (L1)->>Outbox (L1): Update state (nullify)


```

1. User initiates transaction
2. Clicks transfer
3. The tokens are deposited to the Portal. This holds the tokens in the Portal 
4. Portal contract (L1) wants to send a message to L2. In our scenario, we want to mint tokens on Aztec. To set this up look at points 5,6.
5. The L1 inbox populates the message with information of the sender. The <kbd>sendL2Message()</kbd>  is used to send the message.
6. The L1 inbox contract inserts the message into its tree
7. On the L2, as part of a L2 block, a transaction consumes a message from the L2 outbox
8. Consumes the L1 -> L2 message and emits the nullifier. 
9. The L2 outbox ensures that the message is included, and that the caller is the recipient and knows the secret to spend. (This is done by the application circuit)
10. The nullifier of the message is emitted to privately spend the message (This is done by the application circuit)
11. The L2 contract sends a message to L1 (specifying a recipient)
12. The L2 inbox populates the message with sender information
13. The L2 inbox inserts the message into its storage
14. The rollup circuit starts consuming the messages from the inbox
15. The L2 inbox deletes the messages from its storage
16. The L2 block includes messages from the L1 inbox that are to be inserted into the L2 outbox
17. The L2 outbox state is updated to include the messages
18. The L2 block is submitted to L1
19. The state transitioner receives the block and verifies the proof + validates constraints on block
20. The state transitioner updates it's state to the ending state of the block
21. The state transitioner consumes the messages from the L1 inbox that was specified in the block. They have been inserted into the L2 outbox, ensuring atomicity.
22. The L1 inbox updates it local state by marking the message tree messages as consumed
23. The state transitioner inserts the messages tree root into the L1 Outbox. They have been consumed from the L2 inbox, ensuring atomicity.
24. The L1 outbox updates it local state by inserting the message root and height
25. The portal later consumes a message from the L1 outbox
26. The L1 outbox validates that the message exists and that the caller is indeed the recipient
27. The L1 outbox updates it local state by nullifying the message
