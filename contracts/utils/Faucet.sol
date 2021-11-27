// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

import "../interfaces/IToken.sol";

/**
 * @dev Implementation of Faucet.
 */
contract Faucet is Context {
    /**
     * @dev Creates `amount` tokens and assigns them to user
     */
    function mintBatch(address[] memory assets, uint256 amount) public virtual returns (bool) {
        for (uint256 i = 0; i < assets.length; ++i) {
            IToken(assets[i]).mint(_msgSender(), amount);
        }
        return true;
    }
}
