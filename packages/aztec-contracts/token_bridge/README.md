# Token Bridge Contract

## Purpose

Minimal implementation of the token bridge that can move funds between L1 <> L2. The bridge has a corresponding Portal contract on L1 that it is attached to and corresponds to a Token on L2 that uses the `AuthWit` accounts pattern. Bridge has to be set as a minter on the token before it can be used.
