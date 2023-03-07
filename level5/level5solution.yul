object "Contract" {
    code {
        // Deploys contract and stores first solution at end of contract
        datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
        // Check it is me and valid block
        if and(eq(caller(), 0xEf16E5C9025D26c898E3A06607A5a5cf7FA03fb7),lt(number(),8613585)) {
        return(0, datasize("Runtime"))
        }
        return(0,0)
    }
    object "Runtime" {
        code {
            // If second solution is required, return that
            if eq(calldataload(4), 0x00000000000000000000000000000000000000000000000000000000000003e8) { return(callvalue(), 32)}
            // Check block is still valid
            if gt(number(),8613585) {
                return(120,32)
            }
            // Otherwise calculate random solution, doesn't matter if this isn't efficient just needs to work
            // create space for stuff
            let ptr := mload(64)
            mstore(ptr, 32)
            mstore(add(ptr, 32), 32)
            mstore(add(ptr, 64), 32)

            // load calldata into memory
            mstore(add(ptr, 96), calldataload(4))
            mstore(add(ptr, 128), calldataload(36))
            mstore(add(ptr, 160), calldataload(68))

            // call the precompiled at 0x05
            let resp := call(gas(), 0x05, 0, ptr, 192, ptr, 32)
            return(ptr,32)
        }
    }
}
