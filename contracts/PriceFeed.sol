// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import "./interfaces/IPriceFeed.sol";

/**
 * @dev Implementation of fund pool.
 */
contract PriceFeed is IPriceFeed {
    mapping(address => address) public aggregators;

    /**
     * @dev Initializes the contract
     */
    constructor(address[] memory tokens_, address[] memory aggregators_) {
        // register aggregators
        for (uint256 i = 0; i < tokens_.length; ++i) {
            aggregators[tokens_[i]] = aggregators_[i];
        }
    }

    /**
     * @dev See {IPriceFeed-getLatestPrice}.
     */
    function getLatestPrice(address token) public view virtual override returns (int256) {
        require(aggregators[token] != address(0), "PriceFeed: unspported aggregator");
        (,int256 price,,,) = AggregatorV3Interface(aggregators[token]).latestRoundData();
        return price;
    }
}
