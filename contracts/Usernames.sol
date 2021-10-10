//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;


contract Usernames{

     event UsernameChanged(address indexed user);
     mapping(address => string) public users;
       
     function setUsername(string memory _username) public{
          users[msg.sender] = _username;
          emit UsernameChanged(msg.sender);
     }


}