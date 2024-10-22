# ASP Aztec Bridge
Cross-chain token utilizing portals.

## Current Version

v0.1.0-alpha

## Overview
This project is the basis of the ASP Aztec Bridge. The program demonstrates how a token can be bridged to and from Aztec.

## What is a portal?
A portal in the Aztec ecosystem is a crucial interface that facilitates communication between Layer 1 (L1) and a specific contract on Aztec's Layer 2 (L2). It serves as a dedicated bridge, enabling bidirectional message passing between these two layers.

## Main Components
* **Token Portal** is a solidity contract on L1
* **Token Bridge** is a aztec-nr contract on L2
* **TypeScript** application that can call the methods on the contracts and communicate with the sandbox
* **Noir circuits** are zero knowledge circuits that can be used to prove certain properties about the transactions

### Directory Structure
```
.
├── docs  // Contains the documentation for the project
└──  packages 
      ├── aztec-contracts  // Contains the Aztec L2 contracts
      ├── src  // Contains the TS application
      ├── l1-contracts  // Contains the Ethereum L1 contracts
      └── circuits  // Contains the Noir circuits

```

## 1. Development

### 1.1. Setup

Ensure you have the following installed:

- [ ] [Node v20 (install this version via 'nvm')](https://github.com/tj/n)
- [ ] [Docker](https://docs.docker.com/)
- [ ] Aztec Sandbox

> [!NOTE]
> Have docker installed and running first before starting the sandbox

To install the sandbox, run the below command:
```bash
bash -i <(curl -s install.aztec.network)
```
To start the sandbox, run:
```bash
aztec start --sandbox
```

### 1.2. Update

Update the sandbox to the latest version (0.47.1 is the latest) via  `aztec-up`:

```bash
aztec-up
```

or

```bash
VERSION=0.47.1 aztec-up
```

### 1.3. Dependencies

Install dependencies for l1-contracts:
```bash
cd l1-contracts
yarn install
```

Install dependencies for the TS application in packages/src:
```bash
cd packages/src
yarn install
```

### 1.4. Compile Contracts

#### Aztec contracts (L2)

```bash
cd packages/aztec-contracts/token_bridge
aztec-nargo compile
aztec codegen target -o ../../src/test/fixtures
```

#### L1 contracts

```bash
cd packages/l1-contracts
npx hardhat compile
```

### 1.5. Run

Run the sandbox if you havent already

```bash
aztec start --sandbox
```

Run the tests

> [!NOTE]
> When the tests are being run, there should be logs being produced on the Sandbox. If no logs are being produced, restart docker.

```bash
cd packages/src
DEBUG='aztec:e2e_uniswap' yarn test
```