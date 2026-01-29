1. Deploy `BridgeToken.sol` on both Chain A and Chain B.
2. Deploy `Bridge.sol` on both chains, passing the token address.
3. On both chains, call `grantRole(BRIDGE_ROLE, bridgeContractAddress)` on the Token contract.
4. An off-chain script must listen for `BridgeRequest` on Chain A and call `releaseTokens` on Chain B.
