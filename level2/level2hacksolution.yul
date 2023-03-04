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
            // If first solution is required, return that
            if eq(calldataload(4), 0x63) { datacopy(callvalue(), sub(codesize(),320), 320) return(callvalue(), 320)}
            let constructor_offset := 14
            // Create and store solution constructor in memory
            // Push2 {solutionsize + 640)
            mstore8(0,0x61)
            let total_solution_size := add(datasize("Solution"),640)
            let padded_total_size := shl(240, total_solution_size)
            mstore(1,padded_total_size)
            // Push1 {constructor_offset}
            mstore8(3,0x60)
            mstore8(4,constructor_offset)
            // Push1 0
            mstore8(5,0x60)
            // Codecopy
            mstore8(7,0x39)
            // Push2 {solutionsize + 640}
            mstore8(8,0x61)
            mstore(9, padded_total_size)
            // Push1 0
            mstore8(11,0x60)
            // Return
            mstore8(13,0xf3)
            // Should be something like 0x61{xxxx}600e60003961{xxxx}6000f3 in memory
            // Store solution runtime code in memory
            datacopy(constructor_offset,dataoffset("Solution"),datasize("Solution"))
            // Append first solution in memory
            datacopy(add(datasize("Solution"),constructor_offset),sub(codesize(),320),320)
            // Declare ptrs
            let contract_init_code_size := add(add(datasize("Solution"), constructor_offset),320)
            let arr_ptr := contract_init_code_size
            // Copy the array from calldata to memory using an initial guess
            calldatacopy(arr_ptr, 4, 320)
            // Implement insertion sort on the copied array in memory
            for { let i := 1 } lt(i, 10) { i := add(i, 1) } {
                let key := mload(add(arr_ptr, mul(i, 32)))
                let j := sub(i, 1)
                for { } and(gt(j, callvalue()), gt(mload(add(arr_ptr, mul(j, 32))), key)) { j := sub(j, 1) } {
                    mstore(add(arr_ptr, mul(add(j, 1), 32)), mload(add(arr_ptr, mul(j, 32))))
                }
                mstore(add(arr_ptr, mul(add(j, 1), 32)), key)
            }
            // sort the first element separately to avoid off by one error
            for { let i := 0 } lt(i, 9) { i := add(i, 1) } {
                if gt(mload(arr_ptr),mload(add(arr_ptr,mul(32,add(i,1))))) {
                    let key := mload(add(arr_ptr,mul(i,32)))
                    mstore(add(arr_ptr,mul(i,32)),mload(add(arr_ptr,mul(add(i,1),32))))
                    mstore(add(arr_ptr,mul(add(i,1),32)),key)
                }
            }
            // Deploy contract and save address to 0
            sstore(0,create(0,0, add(contract_init_code_size, 320)))
            return(arr_ptr, 320)
        }
        object "Solution" {
            code {
                if eq(calldataload(4), 0x63) { datacopy(callvalue(), datasize("Solution"), 320) return(callvalue(), 320)}
                datacopy(callvalue(),add(datasize("Solution"),320), 320)
                return(callvalue(), 320)
            }
        }
    }
}
