// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./Allowance.sol";

contract SimpleWallet is Allowance {
    event MoneySent(address indexed _beneficiary, uint256 _amount);
    event MoneyReceived(address indexed _from, uint256 _amount);

    function withdrawMoney(address payable _to, uint256 _amount)
        public
        onlyOwner
    {
        require(
            _amount >= address(this).balance,
            "There are not enough funds stored in the smart contract"
        );
        if (!(msg.sender == owner())) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public view override onlyOwner {
        revert("Can't renounce ownership here!");
    }

    function reveiceMoney() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
}
