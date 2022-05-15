// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract etherTransder{
    address  payable private owner;
    uint balance;

    address payable dealer;
    address payable participant;
    constructor(){
        owner=payable(msg.sender);
        balance=5 ether;
    }

    function setDealerAddress(address payable address2) public{
        dealer=address2;
    }

    function setParticipantAddress(address payable address2) public{
        participant=address2;
    }

    function sendEther(uint money) public payable {
        dealer.transfer(money);
        participant.transfer(money);
        owner.transfer(money);
    }
    function getContractBalance() public view returns (uint256) {
        return address(this).balance; 
    } 
    function getContract() public view returns (address ) {
        return address(this); 
    } 
}