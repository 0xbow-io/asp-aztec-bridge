# Sequence Diagram

## Logical Execution Flow
This flow demonstrates the full cycle of cross-chain communication, including the deposit from L1 to L2, operations on L2, and the withdrawal back to L1, showcasing how messages and tokens move between layers through the Portal and Token Bridge system. For this demonstration, the user simply deposits 10 USDC to L2 and then withdraws the same amount back to L1.
> [!NOTE]
> The L2 inbox only exists conceptually and its functionality is handled by the kernel and the rollup circuits.
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
    participant Token Bridge (L2)
    end
    User->>User: Connects wallet
    User->>User: Inputs 10 USDC and clicks transfer
    User->>Portal: Deposits 10 USDC to the portal
    Portal->>Inbox (L1): Send 'mint' msg to L2 (aztec)
    Inbox (L1)->>Inbox (L1): Populate msg values
    Inbox (L1)->>Inbox (L1): Update state (msg inserted into inbox)
    loop block in chain
        Token Bridge (L2)->>Outbox (L2): Consume msg initiated to read the msg from L1
        Outbox (L2)->>Outbox (L2): Consumes and validates msg
        Outbox (L2)->>Outbox (L2): Update state (nullify)
        Token Bridge (L2)->>Token Bridge (L2): Mint 10 USDC on L2
        User->>Token Bridge (L2): Request withdrawal of 10 USDC
        Token Bridge (L2)->>Token Bridge (L2): Burn 10 USDC on L2
        Token Bridge (L2)->>Inbox (L2): Add withdrawal msg
        Inbox (L2)->>Inbox (L2): Populate msg values and update state
        Rollup Contract->>Inbox (L2): Consume msg
        Rollup Contract->>Outbox (L2): Insert withdrawal msg
        Rollup Contract->>Validating Light Node (L1): Block (Proof + Data)
        Validating Light Node (L1)->>Validating Light Node (L1): Verify proof and update state
        Validating Light Node (L1)->>Outbox (L1): Insert withdrawal message from L2
        Outbox (L1)->>Outbox (L1): Update state (insert root)
    end
    User->>Portal: Request withdrawal of 10 USDC
    Portal->>Outbox (L1): Consume withdrawal msg
    Outbox (L1)->>Outbox (L1): Validate msg and update state (nullify)
    Portal->>User: Transfer 10 USDC back to user


```
The sequence diagram above is numbered to show the logical flow of the cross-chain communication process. The steps are as follows:
1. User connects their wallet to the system.
2. User inputs 10 USDC and initiates a transfer to L2.
3. User deposits 10 USDC to the Portal contract on L1, which holds the tokens.
4. Portal contract on L1 sends a 'mint' message to L2 (Aztec) via the L1 Inbox.
5. L1 Inbox populates the message with sender information using sendL2Message().
6. L1 Inbox updates its state by inserting the message into its tree.
7. Token Bridge on L2 initiates consumption of the message from L2 Outbox.
8. L2 Outbox consumes the message and validates it.
9. L2 Outbox updates its state by nullifying the consumed message.
10. Token Bridge mints 10 USDC on L2, corresponding to the deposited amount.
11. User requests withdrawal of 10 USDC on L2.
12. Token Bridge burns 10 USDC on L2 to initiate the withdrawal.
13. Token Bridge adds a withdrawal message to the L2 Inbox.
14. L2 Inbox populates the message with sender information and updates its state.
15. Rollup Contract consumes the message from L2 Inbox.
16. Rollup Contract inserts the withdrawal message into L2 Outbox.
17. Rollup Contract submits the L2 block (including Proof + Data) to the Validating Light Node on L1.
18. Validating Light Node verifies the proof and updates its state.
19. Validating Light Node inserts the withdrawal message from L2 into L1 Outbox.
20. L1 Outbox updates its state by inserting the message root.
21. User requests withdrawal of 10 USDC from the Portal on L1.
22. Portal consumes the withdrawal message from L1 Outbox.
23. L1 Outbox validates the message and updates its state by nullifying it.
24. Portal transfers 10 USDC back to the user, completing the cross-chain withdrawal.
