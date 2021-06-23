/**
 * @dev Transfer tokens to a specified address after diverting a fee to a central account.
 * @param _to The receiving address.
 * @param _value The number of tokens to transfer.
 */
function transfer(address _to, uint256 _value) public returns (bool) {
  require(_to != address(0));
  require(_value <= balances[msg.sender]);
  require(_value % (uint256(10) ** decimals) == 0);

  uint fee = SafeMath.div(SafeMath.mul(_value, transferFeePercentage), 100);
  uint taxedValue = SafeMath.sub(_value, fee);

  // SafeMath.sub will throw if there is not enough balance.
  balances[msg.sender] = SafeMath.sub(balances[msg.sender], _value);

  balances[_to] = SafeMath.add(balances[_to], taxedValue);
  Transfer(msg.sender, _to, taxedValue);
  balances[feeAccount] = SafeMath.add(balances[feeAccount], fee);
  Transfer(msg.sender, feeAccount, fee);

  return true;
}
