pragma solidity ^0.4.24;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';
import './PatriciaTree.sol';

contract StorageToken is ERC721Token {
  
  mapping(uint256 => bytes32) public data;
  PatriciaTree tree;

  constructor(string name, string symbol, address _treeLibAddr) public ERC721Token(name, symbol) {
    tree = PatriciaTree(_treeLibAddr);
  }

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

  function verify(uint256 _tokenId, bytes _key, bytes _value, uint _branchMask, bytes32[] _siblings) public view returns (bool) {
    require(exists(_tokenId));
    return tree.verifyProof(data[_tokenId], _key, _value, _branchMask, _siblings);
  }

  function write(uint256 _tokenId, bytes32 _newRoot) public {
    require(msg.sender == ownerOf(_tokenId));
    data[_tokenId] = _newRoot;
  }

}