// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable {
    using SafeMath for uint256;

    event AllowanceChanged(
        address indexed _forWho,
        address indexed _fromWho,
        uint256 _oldAmount,
        uint256 _newAmount
    );

    mapping(address => uint256) public allowance;

    function addAllowance(address _who, uint256 _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    function ownerOrAllowed(uint256 _amount) public view {
        require(
            (msg.sender == owner()) || allowance[msg.sender] >= _amount,
            "You are not allowed!"
        );
    }

    function reduceAllowance(address _who, uint256 _amount) internal {
        emit AllowanceChanged(
            _who,
            msg.sender,
            allowance[_who],
            allowance[_who].sub(_amount)
        );
        allowance[_who] = allowance[_who].sub(_amount);
    }
}
