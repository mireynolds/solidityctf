# Some Solutions to Encode Club Expert Solidity CTF (Feb '23 Cohort)
CTF frontend: https://www.solidityctf.xyz/
CTF Goerli contract: [0x3256a635372b4510595eab7219c470ce2143ea4e](https://goerli.etherscan.io/address/0x3256a635372b4510595eab7219c470ce2143ea4e)

For each level, the goal is to use the least gas whilst passing the checks of the level.

Descriptions of each level are given below, you can find some solutions in their respective folders in this repo.

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
