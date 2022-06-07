//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./CoinLeaguesFactory.sol";

// Allows creation of rooms
contract RoomFactory is Ownable {
    event RoomCreated(address indexed creator, address room);
    event SettingsChanged(address settingsAddress);
    CoinLeaguesFactory[] public factories;
    mapping(address => bool ) public factoryMap;
    address private _settings;

    constructor(address settings) {
        _settings = settings;
    }

    function createRoom() public returns (CoinLeaguesFactory factoryAddress){
        factoryAddress = new CoinLeaguesFactory( _settings, owner());
        factories.push(factoryAddress);
        factoryMap[address(factoryAddress)] = true;
        emit RoomCreated(msg.sender, address(factoryAddress));
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
       CoinLeaguesFactory(factory).setSettings(newSettings);
    }

}