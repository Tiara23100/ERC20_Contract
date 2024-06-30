// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Token {

    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply;

   
    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);
 

    constructor(string memory _name, string memory _symbol, uint _decimals, uint _totalSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply; 
        balanceOf[msg.sender] = totalSupply;
    }


    function transfer(address _to, uint256 _value) external returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        _transfer(msg.sender, _to, _value);
        return true;
    }

    // transfer function
    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != address(0));
        balanceOf[_from] = balanceOf[_from] - (_value);
        balanceOf[_to] = balanceOf[_to] + (_value);
        emit Transfer(_from, _to, _value);
    }

    // mint function
    function mint (address _address, uint _value) public {
        totalSupply += _value;
        balanceOf[_address] += _value;
    }

    // burn function
    function burn (address _address, uint _value) public {
        if(balanceOf[_address] >= _value) {
            totalSupply -= _value;
           balanceOf[_address] -= _value;
        }
        else{
        revert("Total Supply is less than the amount to be transfered.");
        }

}
}
