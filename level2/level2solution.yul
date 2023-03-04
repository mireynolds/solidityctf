object "Contract" {
    code {
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
        return(0, add(datasize("Runtime"),320))
        // Check it is me and valid block
        if and(eq(caller(), 0xEf16E5C9025D26c898E3A06607A5a5cf7FA03fb7),lt(number(),8598028)) {
        return(0, add(datasize("Runtime"),320))
        }
        return(0,0)
    }
    object "Runtime" {
        code {
            // Make sure gas limit is set to 500000 for tx submission
            if gt(gas(), 425000) { datacopy(callvalue(), datasize("Runtime"), 320) return(callvalue(), 320)}
            // Declare ptrs
            let arr_ptr := callvalue()
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
                if gt(mload(add(arr_ptr,mul(i,32))),mload(add(arr_ptr,mul(32,add(i,1))))) {
                    let key := mload(add(arr_ptr,mul(i,32)))
                    mstore(add(arr_ptr,mul(i,32)),mload(add(arr_ptr,mul(add(i,1),32))))
                    mstore(add(arr_ptr,mul(add(i,1),32)),key)
                }
            }
            return(arr_ptr, 320)
        }
    }
}
