// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

import "../libraries/EnumerableMap.sol";

/**
 * @dev Interface of the IFundPool.
 */
interface IFundPool is IERC20Metadata {
    /**
     * @dev Returns sponsor.
     */
    function sponsor() external view returns (address);

    /**
     * @dev Returns shares per unit.
     */
    function sharesPerUnit() external view returns (uint256);

    /**
     * @dev Returns holding of asset.
     */
    function holdingOf(address asset) external view returns (uint256);

    /**
     * @dev Returns reserve of asset.
     */
    function reserveOf(address asset) external view returns (uint256);

    /**
     * @dev Returns the net asset value.
     */
    function nav() external view returns (uint256);

    /**
     * @dev Swaps tokens for creation unit.
     */
    function create(uint256 unit) external returns (bool);

    /**
     * @dev Redeems creation units and in return receives a basket of tokens.
     */
    function redeem(uint256 shares) external returns (bool);

    /**
     * @dev Updates holdings
     */
    function updateHoldings(address[] memory assets, uint256[] memory amounts) external returns (bool);

    /**
     * @dev Emitted when swap tokens for creation unit.
     */
    event Create(address indexed account, uint256 indexed unit);

    /**
     * @dev Emitted when redeem creation units.
     */
    event Redeem(address indexed account, uint256 indexed shares);
}
