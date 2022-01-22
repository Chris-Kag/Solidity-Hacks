contract EtherStore {

  // initialize the mutex
  bool reEntrancyMutex = false
  uint256 public withdrawLimit = 1 ether;
  mapping(address => uint256) public lastWithdrawTime;
  mapping(address => uint256) public balances;

  function depositFunds() external payable {
    balances[msg.sender] += msg.value;
  }

  function withdrawFunds (uint256 _amountToWithdraw) public
    require(!reEntrancyMutex);
    require(balances[msg.sender] >= _amountToWithdraw);
    // limit the withdrawal
    require(_amountToWithdraw <= withdrawalLimit);
    // limit the time allowed to withdrawal
    require(now >= lastWithdrawTime[msg.sender] + 1 weeks);
    balances[msg.sender] -= _amountToWithdraw;
    lastWithdrawTime[msg.sender] = now;
    // set the reEntrancy mutex before the external call
    reEntrancyMutex = true;
    require(msg.sender.call.value(_amountToWithdraw)());
    // release the mutex after the external call
    reEntrancyMutex = false;
  }
}
