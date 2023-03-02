object "Contract" {
    code {
        // Deploys contract and stores first solution at end of contract
        datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
        mstore(datasize("Runtime"), 1)
        mstore(add(datasize("Runtime"), 32), 1)
        mstore(add(datasize("Runtime"), 64), 3)
        mstore(add(datasize("Runtime"), 96), 4)
        mstore(add(datasize("Runtime"), 128), 7)
        mstore(add(datasize("Runtime"), 160), 8)
        mstore(add(datasize("Runtime"), 192), 0xe)
        mstore(add(datasize("Runtime"), 224), 0x37)
        mstore(add(datasize("Runtime"), 256), 0x5a)
        mstore(add(datasize("Runtime"), 288), 0x63)
        // Check that it is me and block is valid
        if and(eq(caller(), 0xEf16E5C9025D26c898E3A06607A5a5cf7FA03fb7),lt(number(),8581300)) {
        return(0, add(datasize("Runtime"),320))
        }
        return(0,0)
    }
    object "Runtime" {
        code {
            if eq(calldataload(4), 0x63) { datacopy(callvalue(), sub(codesize(),320), 320) return(callvalue(), 320)}
            let solution_size := datasize("Solution")
            let constructor_offset := 14
            // Store solution constructor in memory (length is 14)
            mstore(0,0x6102a6600e6000396102a66000f3000000000000000000000000000000000000)
            // Store solution runtime code in memory
            datacopy(constructor_offset,dataoffset("Solution"),datasize("Solution"))
            // Append first solution in memory
            datacopy(add(solution_size,constructor_offset),sub(codesize(),320),320)
            // Declare ptrs
            let contract_init_code_size := add(add(solution_size, constructor_offset),320)
            let arr_ptr := contract_init_code_size
            // Copy the array from calldata to memory using an initial
            calldatacopy(arr_ptr, 292, 32)
            calldatacopy(add(arr_ptr,32), 100, 32)
            calldatacopy(add(arr_ptr,64), 132, 32)
            calldatacopy(add(arr_ptr,96), 4, 32)
            calldatacopy(add(arr_ptr,128), 164, 32)
            calldatacopy(add(arr_ptr,160), 196, 32)
            calldatacopy(add(arr_ptr,192), 36, 32)
            calldatacopy(add(arr_ptr,224), 260, 32)
            calldatacopy(add(arr_ptr,256), 68, 32)
            calldatacopy(add(arr_ptr,288), 228, 32)
            // Implement insertion sort on the copied array in memory
            for { let i := 1 } lt(i, 10) { i := add(i, 1) } {
                let key := mload(add(arr_ptr, mul(i, 32)))
                let j := sub(i, 1)
                for { } and(gt(j, callvalue()), gt(mload(add(arr_ptr, mul(j, 32))), key)) { j := sub(j, 1) } {
                    mstore(add(arr_ptr, mul(add(j, 1), 32)), mload(add(arr_ptr, mul(j, 32))))
                }
                mstore(add(arr_ptr, mul(add(j, 1), 32)), key)
            }
            // Deploy contract and save address to 0
            sstore(0,create(0,0, add(contract_init_code_size, 320)))
            return(arr_ptr, 320)
            //}
        }
        object "Solution" {
            code {
                if eq(calldataload(4), 0x63) { datacopy(callvalue(), sub(codesize(),640), 320) return(callvalue(), 320)}
                datacopy(callvalue(),sub(codesize(),320), 320)
                return(callvalue(), 320)
                //}
            }
        }
    }
}
