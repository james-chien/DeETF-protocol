// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @dev Implementation of chainlink aggregator mock.
 *
 * Not all tokens price show on each blockchain. We will deploy on more chains,
 * so we use aggregator mock to show prices for chainlink hackathon only.
 */
contract AggregatorMock is AggregatorV3Interface {
    uint256 public price; // price in USD

    /**
     * @dev Initializes the contract
     */
    constructor(uint256 price_) {
        price = price_;
    }

    function decimals() public view virtual override returns (uint8) {
        return 8;
    }

    function description() public view virtual override returns (string memory) {
        return "Chainlink price feed";
    }

    function version() public view virtual override returns (uint256) {
        return 1;
    }

    function getRoundData(uint80 _roundId) public view virtual override returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
        return (
            1,
            int256(price),
            0,
            0,
            0
        );
    }

    function latestRoundData() public view virtual override returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
        return (
            1,
            int256(price),
            0,
            0,
            0
        );
    }
}
