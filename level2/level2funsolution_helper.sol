pragma solidity ^0.8.0;

contract AddressCalculator {
    function calculateAddress(address deployingAddress, uint256 nonce) public pure returns (address, address) {
        bytes32 hash = keccak256(abi.encodePacked(
            bytes1(0xff),
            deployingAddress,
            bytes32(nonce)
        ));
        address c1 = address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), deployingAddress, bytes1(uint8(nonce)))))));
        address c2 = address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), c1, bytes1(uint8(1)))))));
        return (c1, c2);
    }
}
