// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// import Open Zepplin contracts

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract ChatChienFactory is ERC721, Ownable {
    uint256 private _tokenIds;
    uint256 public priceMin;

    // uint datetoreveal;

    constructor() ERC721("ChienChatNFT", "CCN") {}

    function setPrice(uint256 _price) public onlyOwner {
        priceMin = _price;
    }

    // use the mint function to create an NFT.
    function mint() public payable returns (uint256) {
        require(priceMin != 0, "minimum price not set yet");
        require(msg.value >= priceMin, "price is too low");

        // mint will start with nft Number 1 as _tokenIds is directly +1:
        _tokenIds += 1;
        _mint(msg.sender, _tokenIds);
        return _tokenIds;
    }

    // in the function below include the CID of the JSON folder on IPFS:

    function tokenURI(uint256 _tokenId)
        public
        pure
        override
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmXbhaSHY8ELcDVCKbsNT65UBYyiX7w5BWxwCWwdZywGcf/",
                    Strings.toString(_tokenId),
                    ".json"
                )
            );
    }

    // possible to include a reveal date:

    /*
        function tokenURI(uint256 _tokenId) override public pure returns(string memory) {
        if(block.timestamp<datetoreveal){
            return string(
            abi.encodePacked("https://gateway.pinata.cloud/ipfs/CIDDEMETADATA/hiden.json"))}

        else{
            return string(
            abi.encodePacked("https://gateway.pinata.cloud/ipfs/CIDDEMETADATA/",Strings.toString(_tokenId),".json"));
        }
    }
    */

    function withdrawMoney() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Transfer failed.");
    }
}
