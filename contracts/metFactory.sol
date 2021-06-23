pragma solidity ^0.8.5;

import "./metERC20.sol"
import "./uniswap-v2-core/UniswapV2Factory.sol"

contract metFactory {

  struct metToken {
    uint objectID;
    address tokenAddress;
    bool exists = false;
  }

  mapping (uint => metToken) public metTokens;

  event TokenMinted(uint objectID, string title, string artist, string year, string link, string medium, address tokenAddress);
  event TokenProposed(uint objectID, string title, string artist);

  function proposeToken(uint _objectID, string _title, string _artist) external {
    require(metTokens[_objectID].exists = false, "Token already exists.")
    emit TokenProposed(uint objectID, string title, string artist)
  }

  function mintToken(uint _objectID, string _title, string _artist, string _year, string _link, string _medium) external {
    metToken storage _metToken = metTokens[_objectID];
    metERC20 _metERC20 = new metERC20(_objectID, _title, _artist, _year, _link, _medium);
    metToken.objectID = _objectID;
    metToken.tokenAddress = address(_metERC20);
    metToken.exists = true;
    emit TokenMinted(_objectID, _title, _artist, _year, _link, _medium, address(_metERC20))
  }

}
