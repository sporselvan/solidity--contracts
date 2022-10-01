// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract SimpleBank{

    mapping (address => uint) private balances;

    address public owner;

    event logDeposit(address accountAddress,uint amount);
    
    constructor() {
        owner = msg.sender;
    }
    
    function balance() public view returns(uint){
              return balances[msg.sender];
    }

    function deposite()external payable returns(uint){
          require(msg.value >= 0.5 ether,"Minimum deposite amount is 0.5 ETH");
          balances[msg.sender] += msg.value;
          emit logDeposit(msg.sender,msg.value);
          return balances[msg.sender];
    }

    function withdraw(uint withdrawAmount) public returns (uint){
         require(withdrawAmount < balances[msg.sender],"User don't have enough amount of ether for withdraw");
         balances[msg.sender] = balances[msg.sender] - withdrawAmount; 
         payable(msg.sender).transfer(withdrawAmount);
         return balances[msg.sender];
    }

}
