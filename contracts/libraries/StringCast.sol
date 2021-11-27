// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev String operations.
 */
library StringCast {
    /**
     * @dev Converts a string `value` to unsigned integer.
     */
    function toUint256(string memory value) internal pure returns (uint256) {
        return uint256(keccak256(abi.encode(value)));
    }
}
