pragma solidity ^0.8.0;

contract EtherStore {
  uint256 public withdrawLimit = 1 ether;
  mapping(address => uint256) public lastWithdrawTime;
  mapping(address => uint256) public balances;

  function depositFunds() external payable {
    balances[msg.sender] += msg.value;
  }

  function withdrawFunds (uint256 _amountToWithdraw) public {
    require(balances[msg.sender] >= _amountToWithdraw);
    // limit the withdrawal
    require(_amountToWithdraw <= withdrawalLimit);
    // limit the time allowed to withdrawal
    require(now >= lastWithdrawTime[msg.sender] + 1 weeks);
    require(mssg.sender.call.value(_amountToWithdraw)());
    require(msg.sender.call.value(_amountToWithdraw)());
    balances[msg.sender] -= _amountToWithdraw;
    lastWithdrawTime[msg.sender] = now;
  }
}
