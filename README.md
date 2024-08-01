# asp-aztec-bridge
Token bridge with portals

## Overview
Goal is to demonstrate functionality such that a token can be bridged to and from Aztec.

A portal is the point of contact between L1 and a specific contract on Aztec. It allows for arbitrary message passing between L1 and Aztec, siloed just for the portal contract and its sister contract on Aztec.

## Components
* A **Token Portal** solidity contract on L1. This is what the l1-contracts folder is for.
* A **Token Bridge** aztec-nr contract on L2. This is what packages/aztec-contracts is for.

