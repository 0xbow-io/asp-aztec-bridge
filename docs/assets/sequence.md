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
The sequence diagram above is numbered to show the logical flow of the deposit process:
1. User initiates a deposit request to the L1 PP Token Portal.
2. The ASP Watcher detects the deposit event via a state change.
3. The ASP Record Generator creates a cryptographic record of the state transition. The Record is then classified and categorized. After categorization, a 256-bit category bitmap is generated.
4. The category bitmap and the associated record are stored on-chain in the Public Registry contract.
5. The L1 PP Token Portal queries the Public Registry for the record hashes.
6. The ASP returns a subset of the record hashes.
7. The L1 PP Token Portal requests a compliance proof for the set of returned records.
8. The ASP ZKP Generator computes the proof to confirm compliance.
9. If the proof is non-compliant, the L1 PP Token Portal reverts the deposit request.
10. If the proof is compliant, the User generates claim secrets
11. Users Tokens are then deposited to the L1 PP Token Portal.
12. The L1 PP Token Portal sends a 'mint' message to the L2 TokenBridge.
13. The L1 Inbox inserts the message into the message tree.

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

The sequence diagram above is numbered to show the logical flow of the withdrawal process:
1. User initiates a withdrawal request from L2 to L1.
2. The ASP Watcher detects the withdrawal event via a state change.
3. The ASP Record Generator creates a cryptographic record of the state transition. The Record is then classified and categorized. After categorization, a 256-bit category bitmap is generated.
4. The category bitmap and the associated record are stored on-chain in the Public Registry contract.
5. The L1 PP Token Portal queries the Public Registry for the record hashes.
6. The ASP returns a subset of the record hashes.
7. The L1 PP Token Portal requests a compliance proof for the set of returned records.
8. The ASP ZKP Generator computes the proof to confirm compliance.
9. If the proof is non-compliant, the L1 PP Token Portal cancels the withdrawal request.
10. If the proof is compliant, the User creates an auth witness for token burn.
11. The withdrawal initiation process is then continued for the user to receive the tokens on L1.