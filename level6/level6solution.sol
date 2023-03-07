contract answer {
    function solution(bytes32 message, uint8 v, bytes32 r, bytes32 s) external pure returns (address) {
            bytes32 hash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", message));
            return (ecrecover(hash, v, r, s));
    }
}
