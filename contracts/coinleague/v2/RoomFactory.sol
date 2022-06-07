//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./CoinLeaguesFactory.sol";

// Allows creation of rooms
contract RoomFactoryV2 is Ownable {
    event RoomCreated(address indexed creator, address room, string name);
    event SettingsChanged(address settingsAddress);
    CoinLeaguesFactoryV2[] public factories;
    mapping(address => bool ) public factoryMap;
    mapping(address => string ) public factoryMapName;
    address private _settings;

    constructor(address settings) {
        _settings = settings;
    }

    function createRoom(string memory name) public returns (CoinLeaguesFactoryV2 factoryAddress){
        factoryAddress = new CoinLeaguesFactoryV2( _settings, owner());
        factories.push(factoryAddress);
        factoryMap[address(factoryAddress)] = true;
        factoryMapName[address(factoryAddress)] = name;
        emit RoomCreated(msg.sender, address(factoryAddress), name);
    }


    function roomExists(address room) public view returns (bool){
         require(room != address(0), "Room can not be zero address");
         return factoryMap[room];
    }

    function setSettings(address newSettings) public onlyOwner {
        require(newSettings != address(0), "Settings can not be zero address");
        _settings = newSettings;
        emit SettingsChanged(newSettings);
    }

    function setSettingsOf(address newSettings, address factory) public onlyOwner {
       require(newSettings != address(0), "Settings can not be zero address");
       require(factory != address(0), "Factory can not be zero address");
       CoinLeaguesFactoryV2(factory).setSettings(newSettings);
    }

    function totalFactories() external view returns (uint256) {
        return factories.length;
    }

}