//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./CoinLeaguesFactoryRoles.sol";

// Allows creation of rooms
contract RoomFactory is Ownable {
    event RoomCreated(address indexed creator, address room);
    event SettingsChanged(address settingsAddress);
    CoinLeaguesFactoryRoles[] public factories;
    mapping(address => bool ) public factoryMap;
    address private _settings;

    constructor(address settings) {
        _settings = settings;
    }

    function createRoom() public returns (CoinLeaguesFactoryRoles factoryAddress){
        factoryAddress = new CoinLeaguesFactoryRoles( _settings, msg.sender);
        factories.push(factoryAddress);
        factoryMap[address(factoryAddress)] = true;
        emit RoomCreated(msg.sender, address(factoryAddress));
    }


    function roomExists(address room) public view returns (bool){
         return factoryMap[room];
    }

    function setSettings(address newSettings) public onlyOwner {
        require(newSettings != address(0), "Settings can not be zero address");
        _settings = newSettings;
        emit SettingsChanged(newSettings);
    }

    function setSettingsOf(address newSettings, address factory) public onlyOwner {
       CoinLeaguesFactoryRoles(factory).setSettings(newSettings);
    }

}