object "Contract" {
    code {
        // Deploys contract
        datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
        // Check that it is me and block is valid
        if and(eq(caller(), 0x4d516b56047540DaDc7C8f927A01f91DCdf66988),lt(number(),8602867)) {
        return(0, datasize("Runtime"))
    }
    object "Runtime" {
        code {
            mstore(callvalue(), 42)
            return(callvalue(),32)
        }
    }
}
