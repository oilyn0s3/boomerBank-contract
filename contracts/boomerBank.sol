// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract boomerBank {
    address public bankOwner;
    string public bankName;
    mapping(address => uint256) public customerBalance;

    constructor() {
        bankOwner = msg.sender;
    }

    function setBankName(string memory _name) external {
        require(
            msg.sender == bankOwner,
            "You must be the bank owner to access this function."
        );
        bankName = _name;
    }

    function depositeMoney() public payable {
        require(msg.value != 0, "You need to deposite some amount of money!");
        customerBalance[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint256 _total) public payable {
        require(
            _total <= customerBalance[msg.sender],
            "You have insuffecient funds for this transaction."
        );

        customerBalance[msg.sender] -= _total;
        _to.transfer(_total);
    }

    function getCusttomerBalance() external view returns (uint256) {
        return customerBalance[msg.sender];
    }

    function getBankBalance() public view returns (uint256) {
        require(
            msg.sender == bankOwner,
            "You don't have privilages to execute this function."
        );
        return address(this).balance;
    }

}