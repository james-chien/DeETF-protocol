// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev Interface of the IPriceFeed.
 */
interface IPriceFeed {
    /**
     * @dev Returns the latest price for `token`.
     */
    function getLatestPrice(address token) external view returns (int256);
}
