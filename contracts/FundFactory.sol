// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";

import "@openzeppelin/contracts/utils/Address.sol";

import "./interfaces/IFundFactory.sol";
import './FundPool.sol';
import "./libraries/StringCast.sol";

/**
 * @dev Implementation of fund factory.
 */
contract FundFactory is Context, IFundFactory {
    // chainlink price feed
    address public priceFeed;

    Params private _params;

    mapping(address => address[]) public pools;
    mapping(address => address) public owners;
    mapping(uint256 => address) public symbols;

    /**
     * @dev Initializes the contract
     */
    constructor(address priceFeed_) {
        priceFeed = priceFeed_;
    }

    /**
     * @dev See {FundFactory-poolsOf}.
     */
    function poolsOf(address account) public view virtual override returns (address[] memory) {
        return pools[account];
    }

    /**
     * @dev See {FundFactory-ownerOf}.
     */
    function ownerOf(address pool) public view virtual override returns (address) {
        return owners[pool];
    }

    /**
     * @dev See {FundFactory-poolOf}.
     */
    function poolOf(string memory symbol) public view virtual override returns (address) {
        return symbols[StringCast.toUint256(symbol)];
    }

    /**
     * @dev See {IFundFactory-getParams}.
     */
    function getParams() public view virtual override returns (address, uint256, address, address[] memory, uint256[] memory) {
        return (_params.sponsor, _params.sharesPerUnit, _params.priceFeed, _params.assets, _params.amounts);
    }

    /**
     * @dev See {IFundFactory-createPool}.
     */
    function createPool(string memory name, string memory symbol, address[] memory assets, uint256[] memory amounts, uint256 sharesPerUnit) public virtual override returns (address) {
        require(assets.length == amounts.length, "FundFactory: length mismatch");
        require(bytes(name).length > 0 && bytes(symbol).length > 0, "FundFactory: missing name & symol");

        uint256 _symbol = StringCast.toUint256(symbol);
        require(symbols[_symbol] == address(0), "FundFactory: symbol exists");

        _params = Params({
          assets: assets,
          amounts: amounts,
          sharesPerUnit: sharesPerUnit,
          priceFeed: priceFeed,
          sponsor: _msgSender()
        });
        address pool = address(new FundPool{salt: keccak256(abi.encode(symbol))}(name, symbol));
        delete _params;

        pools[_msgSender()].push(pool);
        owners[pool] = _msgSender();
        symbols[_symbol] = pool;

        emit CreatePool(_msgSender(), pool);

        return pool;
    }
}
