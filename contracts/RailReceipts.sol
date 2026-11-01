// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RailReceipts {
    struct Receipt {
        address user;
        string fromChain;
        string toChain;
        uint256 amount;
        bytes32 burnTxHash;
        uint64 timestamp;
    }

    Receipt[] public receipts;
    mapping(address => uint256) public countOf;

    event BridgeRecorded(
        uint256 indexed id,
        address indexed user,
        string fromChain,
        string toChain,
        uint256 amount,
        bytes32 burnTxHash
    );

    function record(
        string calldata fromChain,
        string calldata toChain,
        uint256 amount,
        bytes32 burnTxHash
    ) external returns (uint256 id) {
        id = receipts.length;
        receipts.push(Receipt(msg.sender, fromChain, toChain, amount, burnTxHash, uint64(block.timestamp)));
        countOf[msg.sender]++;
        emit BridgeRecorded(id, msg.sender, fromChain, toChain, amount, burnTxHash);
    }

    function total() external view returns (uint256) {
        return receipts.length;
    }
}
