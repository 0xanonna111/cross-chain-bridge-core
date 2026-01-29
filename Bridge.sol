// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {BridgeToken} from "./BridgeToken.sol";

contract Bridge {
    BridgeToken public token;
    address public validator;
    mapping(bytes32 => bool) public processedTransactions;

    event BridgeRequest(address indexed user, uint256 amount, uint256 timestamp, bytes32 indexed txHash);
    event TokensReleased(address indexed user, uint256 amount, bytes32 indexed txHash);

    constructor(address _token, address _validator) {
        token = BridgeToken(_token);
        validator = _validator;
    }

    // Called on Source Chain
    function requestBridge(uint256 amount) external {
        bytes32 txHash = keccak256(abi.encodePacked(msg.sender, amount, block.timestamp));
        token.burn(msg.sender, amount);
        emit BridgeRequest(msg.sender, amount, block.timestamp, txHash);
    }

    // Called on Destination Chain by Validator/Relayer
    function releaseTokens(address user, uint256 amount, bytes32 txHash) external {
        require(msg.sender == validator, "Only validator can release");
        require(!processedTransactions[txHash], "Transaction already processed");

        processedTransactions[txHash] = true;
        token.mint(user, amount);
        emit TokensReleased(user, amount, txHash);
    }
}
