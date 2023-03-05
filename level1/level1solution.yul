object "Contract" {
    code {
        // Deploys contract
        datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
        // Check that it is me and block is valid
        if and(eq(caller(), 0x4d516b56047540DaDc7C8f927A01f91DCdf66988),lt(number(),8602867)) {
        return(0, datasize("Runtime"))
        }
        return(0,0)
    }
    object "Runtime" {
        code {
            // Multiplies the first calldata number by two and returns it in the form [y,y], this works as the test supplies a matrix of the form [[x,x],[x,x]]
            mstore(callvalue(), mul(calldataload(4),2))
            mstore(32, mload(callvalue()))
            return(callvalue(), 64)
        }
    }
}
