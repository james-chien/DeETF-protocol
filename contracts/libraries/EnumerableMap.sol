// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

/**
 * @dev Library for managing
 *
 * ```
 * contract Example {
 *     // Add the library methods
 *     using EnumerableMap for EnumerableMap.AddressToUintMap;
 *
 *     // Declare a set state variable
 *     EnumerableMap.AddressToUintMap private myMap;
 * }
 * ```
 *
 * @notice A fork of OpenZeppelin EnumerableSet specifically tailored for address to uint
 */

library EnumerableMap {
    using EnumerableSet for EnumerableSet.Bytes32Set;

    struct Map {
        EnumerableSet.Bytes32Set _keys;
        mapping(bytes32 => bytes32) _values;
    }

    function _set(
        Map storage map,
        bytes32 key,
        bytes32 value
    ) private returns (bool) {
        map._values[key] = value;
        return map._keys.add(key);
    }

    function _remove(Map storage map, bytes32 key) private returns (bool) {
        delete map._values[key];
        return map._keys.remove(key);
    }

    function _contains(Map storage map, bytes32 key) private view returns (bool) {
        return map._keys.contains(key);
    }

    function _length(Map storage map) private view returns (uint256) {
        return map._keys.length();
    }

    function _at(Map storage map, uint256 index) private view returns (bytes32, bytes32) {
        bytes32 key = map._keys.at(index);
        return (key, map._values[key]);
    }

    function _tryGet(Map storage map, bytes32 key) private view returns (bool, bytes32) {
        bytes32 value = map._values[key];
        if (value == bytes32(0)) {
            return (_contains(map, key), bytes32(0));
        } else {
            return (true, value);
        }
    }

    function _get(Map storage map, bytes32 key) private view returns (bytes32) {
        bytes32 value = map._values[key];
        require(value != 0 || _contains(map, key), "EnumerableMap: nonexistent key");
        return value;
    }

    // AddressToUintMap

    struct AddressToUintMap {
        Map _inner;
    }

    function set(
        AddressToUintMap storage map,
        address key,
        uint256 value
    ) internal returns (bool) {
        return _set(map._inner, bytes32(uint256(uint160(key))), bytes32(value));
    }

    function remove(AddressToUintMap storage map, address key) internal returns (bool) {
        return _remove(map._inner, bytes32(uint256(uint160(key))));
    }

    function contains(AddressToUintMap storage map, address key) internal view returns (bool) {
        return _contains(map._inner, bytes32(uint256(uint160(key))));
    }

    function length(AddressToUintMap storage map) internal view returns (uint256) {
        return _length(map._inner);
    }

    function at(AddressToUintMap storage map, uint256 index) internal view returns (address, uint256) {
        (bytes32 key, bytes32 value) = _at(map._inner, index);
        return (address(uint160(uint256(key))), uint256(value));
    }

    function tryGet(AddressToUintMap storage map, address key) internal view returns (bool, uint256) {
        (bool success, bytes32 value) = _tryGet(map._inner, bytes32(uint256(uint160(key))));
        return (success, uint256(value));
    }

    function get(AddressToUintMap storage map, address key) internal view returns (uint256) {
        return uint256(_get(map._inner, bytes32(uint256(uint160(key)))));
    }
}
