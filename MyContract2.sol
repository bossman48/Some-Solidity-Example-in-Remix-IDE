
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract ERC20Token {
    string public name;
    mapping (address => uint256) public balances;
    address public contractAddress= address(this);
    function mint() virtual public {
        balances[tx.origin]++;
    }
    constructor(string memory name2) public{
        name=name2;
    }
}



contract MyContract{

    mapping(address => uint) public balances;
    address payable wallet;
    address public token;
    constructor(address payable walletAddress, address tokenAddress) public {
        wallet=walletAddress;
        token=tokenAddress;
    }

    function buyToken() public payable {
        ERC20Token tokenERC20 = ERC20Token(address(token));
        tokenERC20.mint();
        wallet.transfer(msg.value);
    }

    fallback() external payable{
        buyToken();
    }
}

contract MyToken is ERC20Token{
    //cannot do this 
    //name = "My Token";

    string public symbol;
    address[] public owners;
    uint256 ownerCounts;

    constructor(string memory name2,string memory symbol2) ERC20Token(name2) public{
        symbol=symbol2;
    }

    function mint() public override {
        super.mint();
        ownerCounts++;
        owners.push(msg.sender);
    }

}

import "./Math.sol";

contract MyContract2 {
    uint256 public value;
    function calculate(uint value1, uint value2) public {
        value = value1/value2;
        value = Math.divide(value1,value2);
    }
}

/*library Math{
    function divide(uint256 value1, uint256 value2) public pure returns(uint256){
        require(value2>0);
        return value1/value2;
    }
}
*/
