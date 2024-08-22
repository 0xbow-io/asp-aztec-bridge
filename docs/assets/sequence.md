# Sequence Diagram

## Logical Execution Flow
The sequence diagram illustrates how the ASP and Privacy Pool contracts interact with Aztec in ensuring compliance.

### Deposit Flow
``` mermaid
sequenceDiagram
    autonumber
    actor User
    box Blue 0xBow
    participant L1 PP Token Portal
    participant ASP
    end
    
    box Green Aztec
    participant L1 Inbox
    
    end
    User->>L1 PP Token Portal: Deposit Request
    ASP->>L1 PP Token Portal: Detects deposit event
    ASP->>ASP: Record generation and classification
    ASP->>ASP: On-chain storage (Public Registry) is updated
    L1 PP Token Portal->>ASP: Query public registry
    ASP->>L1 PP Token Portal: Returns subset of record hashes
    L1 PP Token Portal->>ASP: Request compliance proof for the set of returned records
    ASP->>ASP: ZKP Generator computes the proof to confirm compliance
    alt Non Compliant
        L1 PP Token Portal->>User: Revert deposit request
    end
    alt Compliant
        User->>User: Generate claim secrets
        User->>L1 PP Token Portal: Deposit tokens to PP Token Portal
        L1 PP Token Portal->>L1 Inbox: Send 'mint' message to L2
        L1 Inbox->>L1 Inbox: Insert message into tree
        Note over L1 Inbox: Wait for message to be consumable
        
    end

```
The sequence diagram above is numbered to show the logical flow of deposit process:
1. User initiates a deposit request to the L1 PP Token Portal.
2. ...
### Withdrawal Flow

``` mermaid
sequenceDiagram
    autonumber
    actor User
    box Blue 0xBow
    participant L1 PP Token Portal
    participant ASP
    end
    box Purple Aztec L2
    participant L2 TokenBridge
    end
        User->>L1 PP Token Portal: Initiates withdrawal from L2
        ASP->>L1 PP Token Portal: Detects withdrawal event
        ASP->>ASP: Record generation and classification
        ASP->>ASP: On-chain storage (Public Registry) is updated
        L1 PP Token Portal->>ASP: Query public registry
        ASP->>L1 PP Token Portal: Returns subset of record hashes
        L1 PP Token Portal->>ASP: Request compliance proof for the set of returned records
        ASP->>ASP: ZKP Generator computes the proof to confirm compliance
    alt Non Compliant
        L1 PP Token Portal->>User: Cancel withdrawal request
    end
    alt Compliant
        User->>L2 TokenBridge: Create auth witness for token burn
        User->>L2 TokenBridge: Initiate withdrawal to L1...
        Note over L2 TokenBridge: Rest of the flow for the withdrawal
    end
```