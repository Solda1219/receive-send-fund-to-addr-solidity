// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Donation {
    // The keyword "public" makes variables
    // accessible from other contracts
    mapping(address => uint256) public gravities;
    address payable owner;
    // Constructor code is only run when the contract
    // is created
    address payable addr1;
    address payable addr2;
    address payable addr3;

    constructor(address payable _addr1, address payable _addr2, address payable _addr3) {
        owner = payable(msg.sender);
        addr1 = _addr1;
        addr2 = _addr2;
        addr3 = _addr3;
        gravities[addr1] = 50;
        gravities[addr2] = 30;
        gravities[addr3] = 20;
    }

    event Received(address, uint);
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    function balance() public view returns (uint256){
        return payable(address(this)).balance;
    }

    // Sends an amount of newly created coins to an address
    // Can only be called by the contract creator
    function distributeFunds() public {
        require(owner == msg.sender, "Only owner can call this");
        uint256 bal= address(this).balance;
        addr1.transfer((bal / 100) * gravities[addr1]);
        addr2.transfer((bal / 100) * gravities[addr2]);
        addr3.transfer((bal / 100) * gravities[addr3]);
    }
}
