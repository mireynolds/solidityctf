# Some Solutions to Encode Club Expert Solidity CTF (Feb '23 Cohort)
CTF frontend: https://www.solidityctf.xyz/
CTF Goerli contract: [0x3256a635372b4510595eab7219c470ce2143ea4e](https://goerli.etherscan.io/address/0x3256a635372b4510595eab7219c470ce2143ea4e)

For each level, the goal is to use the least gas whilst passing the checks of the level.

Descriptions of each level are given below, you can find some solutions in their respective folder.

levelTest.sol in the tests folder enables you to fuzz test a deployed solution contract on Goerli with [Foundry](https://github.com/foundry-rs/foundry) by using the command `forge test --[GOERLI RPC URL]`.

## Level 0 - Return 42 (tutorial)
This level is really simple. Use the interface bellow to write a smart contract. Your contract should contain a function called solution that returns a **uint8**. In this case the function body logic is very simply as the answer is always **42**.

**Interface:**
```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

interface Isolution {

  function solution() external pure returns (uint8);
  
}
```
Level 0 test contract: [0x43AE454F698D2efD4477Ec84f4158439b7dbC1C9](https://goerli.etherscan.io/address/0x43AE454F698D2efD4477Ec84f4158439b7dbC1C9)

## Level 1 - Matrix Addition

Write a function that adds two matrices returns the result. To keep things simple the array sizes will be fixed sizes of 2x2 (**uint256[2]**). Take a look at  [Wikipedia](https://en.wikipedia.org/wiki/Matrix_addition)  if you need help understanding matrix addition. Your solution should implement the following interface:
```solidity
interface Isolution {

  function solution(uint256[2] calldata firstArray, uint256[2] calldata secondArray) external returns (uint256[2] calldata finalArray);

}
```
Level 1 test contract: [0x99eAc0b3E6369aa3836d0462342592981b0F34A2](https://goerli.etherscan.io/address/0x99eAc0b3E6369aa3836d0462342592981b0F34A2)

## Level 2 - Sorting an Array

Write a function that sorts an array in ascending order and returns the result. The array will be a fixed of 10 but the contents random. Your solution should implement the following interface:
```solidity
interface Isolution2 {

  function solution(uint256[10] calldata unsortedArray) external returns (uint256[10] memory sortedArray);

}
```
Level 2 test contract: [0x7D0E14BbBf62E3f0Cc0999Cc16f25b9460D89f96](https://goerli.etherscan.io/address/0x7D0E14BbBf62E3f0Cc0999Cc16f25b9460D89f96)

## Level 3 - codeSize

Using the Isolution3 interface write a function that takes an address and returns the codeSize of that address as a uint256.
```solidity
interface Isolution3 {
    function solution(address addr) external view 
    returns (uint256 codeSize);
}
```
Level 3 test contract: [0x81C81Ae05dB618ffe1FE1ee4e37886fe86f76c34](https://goerli.etherscan.io/address/0x81C81Ae05dB618ffe1FE1ee4e37886fe86f76c34)

## Level 4 - Memory

Using the Isolution4 interface write a function that takes a uint256 and saves it to memory slot 3.
```solidity
interface Isolution4 {
    function solution(uint256 value) external;
}
```
Level 4 test contract: [0xdee429a9041cC9d42Ff3A09935170205F037F169](https://goerli.etherscan.io/address/0xdee429a9041cC9d42Ff3A09935170205F037F169)

## Level 5 - Modular Exponentiation

Using the Isolution5 interface calculate Modular Exponentiation (base**exp % mod). Implementing it from scratch would take too much gas so you will need to use the precompiled contract at address 0x05
```solidity
interface Isolution5 {

    function solution(
        bytes32 b,
        bytes32 ex, 
        bytes32 mod) 
    external returns (
        bytes32 result
    );

}
```
Level 5 test contract: [0xf420D13dC67191cCd274c1746cE272cfc0143Ff4](https://goerli.etherscan.io/address/0xf420D13dC67191cCd274c1746cE272cfc0143Ff4)

## Level 6 - Verifying Signatures

For this level we signed some messages off chain using the following front end code:
```javascript
const ethers = require('ethers');

let messageHash = ethers.utils.id("bidPrice(0.420)");
let messageHashBytes = ethers.utils.arrayify(messageHash);
let flatSig = await wallet.signMessage(messageHashBytes); // Sign the binary data
let sig = ethers.utils.splitSignature(flatSig);  // sig.v sig.r sig.s etc
```
Using the Isolution6 interface write a function that will take the messageHash (plus params) and return the signer of the message.

Hint: Don't forget to prepend your message with “\x19Ethereum Signed Message:\n32”
```solidity
interface Isolution6 {
    function solution(
      bytes32 messageHash, 
      uint8 v, 
      bytes32 r, 
      bytes32 s
      ) external pure 
    returns (address signer);
}
```
Level 6 test contract: [0x719Df2d793B3b21D84b5e81be450785752834950](https://goerli.etherscan.io/address/0x719Df2d793B3b21D84b5e81be450785752834950)
