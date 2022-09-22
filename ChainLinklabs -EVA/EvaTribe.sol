// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '../extension/ERC721PsiRandomSeedReveal.sol';
import "hardhat/console.sol";
import "../extension/Ownable.sol";


contract EvaTribe is Ownable, ERC721PsiRandomSeedReveal {
    uint64 immutable subId;
    constructor(string memory name_, string memory symbol_, address coordinator_, uint64 _subId) 
        ERC721Psi(name_, symbol_) 
        ERC721PsiRandomSeedReveal(
            coordinator_,
            100000,
            10
        )
        {
            subId = _subId;
        }

    /*
    * @dev mint funtion with _to address. no cost mint
    *  by contract owner/deployer
    */
    function Devmint(uint256 quantity, address _to) external onlyOwner {
        require(totalSupply() + quantity <= MAX_SUPPLY, "Not enough tokens left");
        _safeMint(_to, quantity);
    }

     /*
     *@dev
     * Set publicsale price to mint per NFT
     */
    function setPublicMintPrice(uint256 _price) external onlyOwner {
        mintRate = _price;
    }

    
     /*
     * @dev Pause sale if active, make active if paused
     */
    function setSaleActive() public onlyOwner {
        saleIsActive = !saleIsActive;
    }

    function _keyHash() internal override returns (bytes32){
        return bytes32(0);
    }
    function _subscriptionId() internal override returns (uint64) {
        return subId;
    }

    function baseURI() public view returns (string memory) {
        return _baseURI();
    }

    function exists(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }

    function safeMint(address to, uint256 quantity) public onlyOwner {
        _safeMint(to, quantity);
    }

    function safeMint(
        address to,
        uint256 quantity,
        bytes memory _data
    ) public {
        _safeMint(to, quantity, _data);
    }

    function getBatchHead(
        uint256 tokenId
    ) public view returns (uint256){
        return _getBatchHead(tokenId);
    }

    function getMetaDataBatchHead(
        uint256 tokenId
    ) public view returns (uint256) {
        return _getMetaDataBatchHead(tokenId);
    }

    function tokenGen(uint256 tokenId) public view returns (uint256) {
        _tokenGen(tokenId);
    } 

    function reveal() public {
        _reveal();
    }

    function benchmarkOwnerOf(uint256 tokenId) public returns (address owner) {
        uint256 gasBefore = gasleft();
        owner = ownerOf(tokenId);
        uint256 gasAfter = gasleft();
        console.log(gasBefore - gasAfter);
    }

    
}