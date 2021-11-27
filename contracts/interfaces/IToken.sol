// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @dev Interface of the IToken.
 */
interface IToken is IERC20 {
    function mint(address account, uint256 amount) external returns (bool);
    function burn(address account, uint256 amount) external returns (bool);
}
