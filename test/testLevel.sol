// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Import test librarys
import "forge-std/Test.sol";
import "forge-std/Vm.sol";

// Interface
interface Ilevel {
    function completeLevel(address) external payable returns(uint8, uint256);
}

contract testSolution is Test {
	// Tester contract for level
	address level = 0x7D0E14BbBf62E3f0Cc0999Cc16f25b9460D89f96;
	// Solution contract
	address solution = 0x51d04913B3B8EdeEd895cbd3D7A556EAB27ec21a;
	// Targets
	uint256 targetScore = 5;
	uint256 targetGas = 4788;
	uint256 targetGasVariance = 0;
	
	function test(uint256 time, uint256 blockNum, address coinbase, uint256 fee) public {
		// EVM variables to be fuzzed
		vm.warp(time);
		vm.roll(blockNum);
		vm.coinbase(coinbase);
		vm.fee(fee);
		// Get score and gas of solution
		(uint8 score, uint256 gas) = Ilevel(level).completeLevel(solution);
		// Check target score
		assertEq(score, targetScore);
		// Check gas is within specified variance
		assertLe(gas, targetGas + targetGasVariance);
		assertGe(gas, targetGas - targetGasVariance);
	}
}
