object "Contract" {
    code {
        // Deploys contract
        datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
        return(0, datasize("Runtime"))
    }
    object "Runtime" {
        code {
            sstore(3, calldataload(4))
        }
    }
}
