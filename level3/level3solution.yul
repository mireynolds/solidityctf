object "Contract" {
    code {
        // Deploys contract
        datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
        return(0, datasize("Runtime"))
    }
    object "Runtime" {
        code {
            mstore(callvalue(), extcodesize(calldataload(4)))
            return(callvalue(),32)
        }
    }
}
