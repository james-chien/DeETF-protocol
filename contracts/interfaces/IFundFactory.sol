// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev Interface of the IFundFactory.
 */
interface IFundFactory {
    struct Params {
        address[] assets;
        uint256[] amounts;
        uint256 sharesPerUnit;
        address priceFeed;
        address sponsor;
    }

    /**
     * @dev Gets pools of account.
     */
    function poolsOf(address account) external view returns (address[] memory);

    /**
     * @dev Gets onwer of pool.
     */
    function ownerOf(address pool) external view returns (address);

    /**
     * @dev Gets pool of symol.
     */
    function poolOf(string memory symbol) external view returns (address);

    /**
     * @dev Gets parameters.
     */
    function getParams() external view returns (address, uint256, address, address[] memory, uint256[] memory);

    /**
     * @dev Creats pool.
     */
    function createPool(string memory name, string memory symbol, address[] memory assets, uint256[] memory amounts, uint256 sharesPerUnit) external returns (address);

    /**
     * @dev Emitted when create pool.
     */
    event CreatePool(address indexed account, address indexed pool);
}
