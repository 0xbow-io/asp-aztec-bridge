``` mermaid
sequenceDiagram
    autonumber
    actor User
    box Blue Layer 1
    participant Portal
    participant Inbox L1
    participant Outbox L1
    end
    box Green Layer 2
    participant Rollup Contract
    participant Outbox L2
    participant Inbox L2
    end
    User->>User: Connects wallet
    User->>User: Inputs 10 USDC and clicks transfer
    User->>Portal: 10 USDC is sent to the portal and held
    Portal->>Inbox L1: Send msg to L2 (aztec)
    Inbox L1->>Inbox L1: Populate msg values
    Inbox L1->>Inbox L1: Update state (msg inserted into inbox)
    Note right of Inbox L1: inbox inserts messages into message tree
    Outbox L2->>Outbox L2: Consumes msg
    Note left of Outbox L2: During consumption, it checks for the corresponding message in the message tree
    Outbox L2->>Outbox L2: Validates msg 
    Outbox L2->>Outbox L2: Update state (nullify)



    
```