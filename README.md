# Cross-Chain Bridge Core

This repository contains the smart contract architecture for a bidirectional token bridge. It follows the "Burn-and-Mint" pattern, which is standard for maintaining a fixed total supply across multiple networks.

## Architecture


1. **Lock/Burn:** Users send tokens to the Bridge contract on Chain A. The tokens are burned or locked.
2. **Validation:** An off-chain relayer (or oracle) detects the event.
3. **Mint/Unlock:** The Bridge contract on Chain B mints an equivalent amount to the user's address.

## Security Features
- **Role-Based Access:** Only the designated "Bridge Role" can mint tokens on the destination chain.
- **Transaction Tracking:** Prevents double-spending via unique transaction hashes.
