pragma solidity ^0.4.24;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';

contract NaiveStorageToken is ERC721Token {
  
  mapping(uint256 => mapping(bytes32 => bytes32)) data;

  constructor(string name, string symbol) public
    ERC721Token(name, symbol)
  { }

  function mint(address _to, uint256 _tokenId) public {
    super._mint(_to, _tokenId);
  }

  function burn(uint256 _tokenId) public {
    super._burn(ownerOf(_tokenId), _tokenId);
  }

  function setTokenURI(uint256 _tokenId, string _uri) public {
    super._setTokenURI(_tokenId, _uri);
  }
  
  function _removeTokenFrom(address _from, uint256 _tokenId) public {
    super.removeTokenFrom(_from, _tokenId);
  }

  function read(uint256 _tokenId, bytes32 _key) public view returns (bytes32) {
    require(exists(_tokenId));
    return data[_tokenId][_key];
  }

  function write(uint256 _tokenId, bytes32 _key, bytes32 _value) public {
    require(msg.sender == ownerOf(_tokenId));
    data[_tokenId][_key] = _value;
  }

}