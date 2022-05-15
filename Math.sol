
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


library Math{
    function divide(uint256 value1, uint256 value2) public pure returns(uint256){
        require(value2>0);
        return value1/value2;
    }
}