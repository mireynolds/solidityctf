## Level 2 Notes
While the test deployed at [0x7D0E14BbBf62E3f0Cc0999Cc16f25b9460D89f96](https://goerli.etherscan.io/address/0x7D0E14BbBf62E3f0Cc0999Cc16f25b9460D89f96) provides a score for gas usage based on returning a non-random solution only. It then makes a second call to check that the solution contract can return a random solution correctly.

However, it is **not random**, as the test contract seems to use the opcodes `DIFFICULTY`, `TIMESTAMP`, and `CALLER` as a pseudo-random seed. Since `CALLER` is just the CTF contract calling the test, we're left with `TIMESTAMP` and `DIFFICULTY`, which will be constant provided you are in the same block.

So, all you need to do is create a contract that calculates the random solution correctly (as inefficiently as you like), stores this in some way on chain (as inefficiently as you like)... and provided you do all this in one block, you can immediately provide the 'random' solution in a submission transaction in that block.

The contract `level2funsolution.yul` is an example of this strategy. Assume you have deployed it, and used `level2funsolution_helper.sol` to calculate its `address1`, and the contract address it will create next on its first `CREATE` opcode `address2` . You then just need to submit the following transactions in the **same block**, in this order:

 1. Submit solution for level 2 at `address1`.
 2. Submit solution for level 2 at `address2` (you will need to override the gas limit to 200,000 or something as this contract doesn't exist yet).

A successful implementation can be seen in an example second submission transaction here:
[0xebb8a6b71abedef76e55b04df2f722aa1797687099056170079a55167d02ea8a](https://goerli.etherscan.io/vmtrace?txhash=0xebb8a6b71abedef76e55b04df2f722aa1797687099056170079a55167d02ea8a&type=parity)

Note how the gas used to provide the fixed solution is 110 (action [3]), and that the gas used to provide the 'random' solution is less at 109 (action [4]). Fortunately.. this exploit of sorts has no material benefit for the CTF since the score for gas is determined entirely by providing the fixed solution. This strategy doesn't work for level 1 as the calls in the test are set to static.. and even then, there are better solutions to level 1. ;-)
