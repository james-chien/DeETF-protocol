// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

import "./interfaces/IFundPool.sol";
import "./interfaces/IPriceFeed.sol";
import "./interfaces/IFundFactory.sol";

/**
 * @dev Implementation of fund pool.
 *
 * There are primary 3 features for this fund pool contract.
 * 1. create - creates ETF shares
 * 2. redeem - redeem creation units and in return receives a basket of tokens
 * 3. updateHoldings - change ETF holdings
 */
contract FundPool is Ownable, ERC20, IFundPool {
    using EnumerableMap for EnumerableMap.AddressToUintMap;

    address private immutable _sponsor;
    uint256 private immutable _sharesPerUnit;

    // chainlink price feed
    address public priceFeed;

    EnumerableMap.AddressToUintMap private _holdings; // assets amount per share
    EnumerableMap.AddressToUintMap private _reserves;

    // records for holding changes
    mapping(address => mapping(address => uint256)) public records;

    /**
     * @dev Initializes the contract
     */
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        address[] memory _assets;
        uint256[] memory _amounts;

        (_sponsor, _sharesPerUnit, priceFeed, _assets, _amounts) = IFundFactory(_msgSender()).getParams();

        // register holdings
        for (uint256 i = 0; i < _assets.length; ++i) {
            _holdings.set(_assets[i], _amounts[i]);
        }

        // transfer ownership to sponsor
        transferOwnership(_sponsor);
    }

    /**
     * @dev See {IFundPool-sponsor}.
     */
    function sponsor() public view virtual override returns (address) {
        return _sponsor;
    }

    /**
     * @dev See {IFundPool-sharesPerUnit}.
     */
    function sharesPerUnit() public view virtual override returns (uint256) {
        return _sharesPerUnit;
    }

    /**
     * @dev See {IFundPool-holdingOf}.
     */
    function holdingOf(address asset) public view virtual override returns (uint256) {
        return _holdings.get(asset);
    }

    /**
     * @dev See {IFundPool-reserveOf}.
     */
    function reserveOf(address asset) public view virtual override returns (uint256) {
        return _reserves.get(asset);
    }

    /**
     * @dev See {IFundPool-nav}.
     */
    function nav() public view virtual override returns (uint256) {
        uint256 totalValue;
        for (uint256 i = 0; i < _holdings.length(); ++i) {
            (address asset,) = _holdings.at(i);
            totalValue += uint256(IPriceFeed(priceFeed).getLatestPrice(asset));
        }
        return totalValue;
    }

    /**
     * @dev See {IFundPool-create}.
     */
    function create(uint256 unit) public virtual override returns (bool) {
        bool sufficientAssets = true;
        uint256 shares = _sharesPerUnit * unit;

        for (uint256 i = 0; i < _holdings.length(); ++i) {
            (address asset,) = _holdings.at(i);
            uint256 balance = IERC20(asset).balanceOf(_msgSender());
            uint256 assetAmount = _holdings.get(asset) * shares;
            if (balance >= assetAmount) {
                IERC20(asset).transferFrom(_msgSender(), address(this), assetAmount);
                _reserves.set(asset, assetAmount);
                records[asset][_msgSender()] += shares;
            } else {
                sufficientAssets = false;
            }
        }

        if (sufficientAssets) {
            _mint(_msgSender(), shares);
        }

        require(sufficientAssets, 'FundPool: insufficient assets');

        emit Create(_msgSender(), unit);

        return true;
    }

    /**
     * @dev See {IFundPool-redeem}.
     */
    function redeem(uint256 shares) public virtual override returns (bool) {
        _burn(_msgSender(), shares);

        for (uint256 i = 0; i < _holdings.length(); ++i) {
            (address asset,) = _holdings.at(i);
            if (records[asset][_msgSender()] > 0) {
                records[asset][_msgSender()] -= Math.min(shares, records[asset][_msgSender()]);
                IERC20(asset).transfer(_msgSender(), _holdings.get(asset) * shares);
            }
        }

        emit Redeem(_msgSender(), shares);

        return true;
    }

    /**
     * @dev See {IFundPool-updateHoldings}.
     */
    function updateHoldings(address[] memory assets, uint256[] memory amounts) public virtual override onlyOwner returns (bool) {
        require(assets.length == amounts.length, "FundFactory: length mismatch");

        for (uint256 i = 0; i < assets.length; ++i) {
            _holdings.set(assets[i], amounts[i]);
        }

        return true;
    }

    /**
     * @dev See {ERC20-_beforeTokenTransfer}.
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);

        for (uint256 i = 0; i < _holdings.length(); ++i) {
            (address asset,) = _holdings.at(i);
            if (records[asset][from] > 0) {
                records[asset][to] = records[asset][from];
                records[asset][from] = 0;
            }
        }
    }
}
