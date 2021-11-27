// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @dev Implementation of DAI mock token.
 */
contract DAIMock is ERC20 {
    /**
     * @dev Initializes the contract
     */
    constructor() ERC20("Dai Stablecoin", "DAI") {
         _mint(_msgSender(), 1e28);
    }

    /**
     * @dev See {ERC20-_mint}.
     */
    function mint(address account, uint256 amount) public virtual returns (bool) {
        _mint(account, amount);
        return true;
    }

    /**
     * @dev See {ERC20-_burn}.
     */
    function burn(address account, uint256 amount) public virtual returns (bool) {
        _burn(account, amount);
        return true;
    }
}
