# 1st NFT Step

## Introduction

For educational purpose: generating art and json files with hashlips and minting NFTs on EVM testnet through a solidity smart contract in order to be visible on OpenSea

## Instructions

First `git clone https://github.com/HashLips/hashlips_art_engine.git`

In hashlips folder npm install => install hashlips

Move layers in layers folders

set /src/config.js as you wish (see mine with comments in hashlips config folder)

once set use `node index.js` => generate art collection

`node utils/rarity.js` => give the details of every layers in quantity/percentage terms (using \_metadata.json freshly generated in build/json directory)

Upload /build/images folder on server (pinata for example)

Copy CID from pinata

Replace in config.js the base URI with the CID

`node utils/update_info.js` to update info in all json files

Then upload /build/json folder on server (pinata for example)

Then publish erc721 minting smart contract `ChatChienFactory.sol` with ifps json uri, cf tokenRUI function, simply change the CID with the json one:

`function tokenURI(uint256 _tokenId) public pure override returns (string memory) { return string( abi.encodePacked( "https://gateway.pinata.cloud/ipfs/YOUR-CID/", Strings.toString(_tokenId), ".json" ) ); }`

Owner must set a minimum price for minting before minting start

Contract can be published on blockchain directly using remix

Use goerli testnet because looks like rinkeby testnet is not working anymore with OpenSea when i used it?

Goerli pow faucet: https://goerli-faucet.pk910.de/

MINT!

See your freshly minted NFTs on OpenSea Testnet :)

## Thanks

Thanks to https://github.com/Alyra-school and https://github.com/BenBktech for the wonderful layers and the teaching :)

Thanks to https://github.com/HashLips for the wonderful tool !
