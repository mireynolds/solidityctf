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
    }
    object "Runtime" {
        code {
            switch calldataload(4)
            case 0x0 {
                selfdestruct(0)
            }
            default {
            if eq(calldataload(4), 0x63) { datacopy(callvalue(), sub(codesize(),320), 320) return(callvalue(), 320)}
            // Declare ptrs
            let arr_ptr := callvalue()
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
            return(arr_ptr, 320)
            }
        }
    }
}
