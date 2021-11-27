const fs = require('fs');
const { resolve } = require('path');
const _ = require('lodash');

/**
 * This is a script for deploying your contracts. You can adapt it to deploy
 * yours, or create new ones.
 */
async function main() {
  // This is just a convenience check
  if (network.name === 'hardhat') {
    console.warn(
      `You are trying to deploy a contract to the Hardhat Network, which` +
        `gets automatically created and destroyed every time. Use the Hardhat` +
        ` option '--network localhost'`
    );
  }

  // ethers is avaialble in the global scope
  const [deployer] = await ethers.getSigners();
  console.log(
    "Deploying the contracts with the account:",
    await deployer.address
  );

  const ethersNetwork = await ethers.provider.getNetwork();
  console.log(`Network: ${network.name} (${ethersNetwork.chainId})`);
  console.log('Account balance:', ethers.utils.formatEther((await deployer.getBalance())));

  // tokens mock
  const AAVEMock = await ethers.getContractFactory('AAVEMock');
  const aaveMock = await AAVEMock.deploy();
  await aaveMock.deployed();
  console.log("AAVE deployed to:", aaveMock.address);

  const BNBMock = await ethers.getContractFactory('BNBMock');
  const bnbMock = await BNBMock.deploy();
  await bnbMock.deployed();
  console.log("BNB deployed to:", bnbMock.address);

  const BUSDMock = await ethers.getContractFactory('BUSDMock');
  const busdMock = await BUSDMock.deploy();
  await busdMock.deployed();
  console.log("BUSD deployed to:", busdMock.address);

  const COMPMock = await ethers.getContractFactory('COMPMock');
  const compMock = await COMPMock.deploy();
  await compMock.deployed();
  console.log("COMP deployed to:", compMock.address);

  const DAIMock = await ethers.getContractFactory('DAIMock');
  const daiMock = await DAIMock.deploy();
  await daiMock.deployed();
  console.log("DAI deployed to:", daiMock.address);

  const HTMock = await ethers.getContractFactory('HTMock');
  const htMock = await HTMock.deploy();
  await htMock.deployed();
  console.log("HT deployed to:", htMock.address);

  const MATICMock = await ethers.getContractFactory('MATICMock');
  const maticMock = await MATICMock.deploy();
  await maticMock.deployed();
  console.log("MATIC deployed to:", maticMock.address);

  const SOLMock = await ethers.getContractFactory('SOLMock');
  const solMock = await SOLMock.deploy();
  await solMock.deployed();
  console.log("SOL deployed to:", solMock.address);

  const SUSHIMock = await ethers.getContractFactory('SUSHIMock');
  const sushiMock = await SUSHIMock.deploy();
  await sushiMock.deployed();
  console.log("SUSHI deployed to:", sushiMock.address);

  const TUSDMock = await ethers.getContractFactory('TUSDMock');
  const tusdMock = await TUSDMock.deploy();
  await tusdMock.deployed();
  console.log("TUSD deployed to:", tusdMock.address);

  const UNIMock = await ethers.getContractFactory('UNIMock');
  const uniMock = await UNIMock.deploy();
  await uniMock.deployed();
  console.log("UNI deployed to:", uniMock.address);

  const USDCMock = await ethers.getContractFactory('USDCMock');
  const usdcMock = await USDCMock.deploy();
  await usdcMock.deployed();
  console.log("USDC deployed to:", usdcMock.address);

  const USDTMock = await ethers.getContractFactory('USDTMock');
  const usdtMock = await USDTMock.deploy();
  await usdtMock.deployed();
  console.log("USDT deployed to:", usdtMock.address);

  const WBTCMock = await ethers.getContractFactory('WBTCMock');
  const wbtcMock = await WBTCMock.deploy();
  await wbtcMock.deployed();
  console.log("WBTC deployed to:", wbtcMock.address);

  const WETHMock = await ethers.getContractFactory('WETHMock');
  const wethMock = await WETHMock.deploy();
  await wethMock.deployed();
  console.log("WETH deployed to:", wethMock.address);

  // Chainlink aggregator mock
  const AggregatorMock = await ethers.getContractFactory('AggregatorMock');

  const aaveAggregator = await AggregatorMock.deploy('26893297691');
  await aaveAggregator.deployed();
  console.log("AAVE Aggregator deployed to:", aaveAggregator.address);

  const bnbAggregator = await AggregatorMock.deploy('56832250495');
  await bnbAggregator.deployed();
  console.log("BNB Aggregator deployed to:", bnbAggregator.address);

  const busdAggregator = await AggregatorMock.deploy('100004763');
  await busdAggregator.deployed();
  console.log("BUSD Aggregator deployed to:", busdAggregator.address);

  const compAggregator = await AggregatorMock.deploy('28117592466');
  await compAggregator.deployed();
  console.log("COMP Aggregator deployed to:", compAggregator.address);

  const daiAggregator = await AggregatorMock.deploy('99970466');
  await daiAggregator.deployed();
  console.log("DAI Aggregator deployed to:", daiAggregator.address);

  const htAggregator = await AggregatorMock.deploy('976464199');
  await htAggregator.deployed();
  console.log("HT Aggregator deployed to:", htAggregator.address);

  const maticAggregator = await AggregatorMock.deploy('157025818');
  await maticAggregator.deployed();
  console.log("MATIC Aggregator deployed to:", maticAggregator.address);

  const solAggregator = await AggregatorMock.deploy('21295000000');
  await solAggregator.deployed();
  console.log("SOL Aggregator deployed to:", solAggregator.address);

  const sushiAggregator = await AggregatorMock.deploy('834740363');
  await sushiAggregator.deployed();
  console.log("SUSHI Aggregator deployed to:", sushiAggregator.address);

  const tusdAggregator = await AggregatorMock.deploy('100000000');
  await tusdAggregator.deployed();
  console.log("TUSD Aggregator deployed to:", tusdAggregator.address);

  const uniAggregator = await AggregatorMock.deploy('2127000000');
  await uniAggregator.deployed();
  console.log("UNI Aggregator deployed to:", uniAggregator.address);

  const usdcAggregator = await AggregatorMock.deploy('100012735');
  await usdcAggregator.deployed();
  console.log("USDC Aggregator deployed to:", usdcAggregator.address);

  const usdtAggregator = await AggregatorMock.deploy('100080072');
  await usdtAggregator.deployed();
  console.log("USDT Aggregator deployed to:", usdtAggregator.address);

  const wbtcAggregator = await AggregatorMock.deploy('5682034399127');
  await wbtcAggregator.deployed();
  console.log("WBTC Aggregator deployed to:", wbtcAggregator.address);

  const wethAggregator = await AggregatorMock.deploy('413975506255');
  await wethAggregator.deployed();
  console.log("WETH Aggregator deployed to:", wethAggregator.address);

  // Chainlink Price feed
  const PriceFeed = await ethers.getContractFactory('PriceFeed');
  const priceFeed = await PriceFeed.deploy(
    [
      aaveMock.address,
      bnbMock.address,
      busdMock.address,
      compMock.address,
      daiMock.address,
      htAggregator.address,
      maticAggregator.address,
      solAggregator.address,
      sushiAggregator.address,
      tusdAggregator.address,
      uniAggregator.address,
      usdcAggregator.address,
      usdtAggregator.address,
      wbtcAggregator.address,
      wethAggregator.address,
    ],
    [
      aaveAggregator.address,
      bnbAggregator.address,
      busdAggregator.address,
      compAggregator.address,
      daiAggregator.address,
      htAggregator.address,
      maticAggregator.address,
      solAggregator.address,
      sushiAggregator.address,
      tusdAggregator.address,
      uniAggregator.address,
      usdcAggregator.address,
      usdtAggregator.address,
      wbtcAggregator.address,
      wethAggregator.address,
    ]
  );
  await priceFeed.deployed();
  console.log("PriceFeed deployed to:", priceFeed.address);

  // fund factory
  const FundFactory = await ethers.getContractFactory('FundFactory');
  const fundFactory = await FundFactory.deploy(priceFeed.address);
  await fundFactory.deployed();
  console.log("FundFactory deployed to:", fundFactory.address);

  // multicall
  const Multicall = await ethers.getContractFactory('Multicall');
  const multicall = await Multicall.deploy();
  await multicall.deployed();
  console.log("Multicall deployed to:", multicall.address);

  // faucet
  const Faucet = await ethers.getContractFactory('Faucet');
  const faucet = await Faucet.deploy();
  await faucet.deployed();
  console.log("Faucet deployed to:", faucet.address);

  if (network.name !== 'hardhat') {
    // save to file
    saveAddresses(network.name, {
      AAVE: aaveMock.address,
      BNB: bnbMock.address,
      BUSD: busdMock.address,
      COMP: compMock.address,
      DAI: daiMock.address,
      HT: htMock.address,
      MATIC: maticMock.address,
      SOL: solMock.address,
      SUSHI: sushiMock.address,
      TUSD: tusdMock.address,
      UNI: uniMock.address,
      USDC: usdcMock.address,
      USDT: usdtMock.address,
      WBTC: wbtcMock.address,
      WETH: wethMock.address,

      AaveAggregator: aaveAggregator.address,
      BnbAggregator: bnbAggregator.address,
      BusdAggregator: busdAggregator.address,
      CompAggregator: compAggregator.address,
      DaiAggregator: daiAggregator.address,
      HtAggregator: htAggregator.address,
      MaticAggregator: maticAggregator.address,
      SolAggregator: solAggregator.address,
      SushiAggregator: sushiAggregator.address,
      TusdAggregator: tusdAggregator.address,
      UniAggregator: uniAggregator.address,
      UsdcAggregator: usdcAggregator.address,
      UsdtAggregator: usdtAggregator.address,
      WbtcAggregator: wbtcAggregator.address,
      WethAggregator: wethAggregator.address,

      PriceFeed: priceFeed.address,
      FundFactory: fundFactory.address,
      Multicall: multicall.address,
      Faucet: faucet.address,
    });

    saveTokenList(network.name, {
      AAVE: aaveMock.address,
      BNB: bnbMock.address,
      BUSD: busdMock.address,
      COMP: compMock.address,
      DAI: daiMock.address,
      HT: htMock.address,
      MATIC: maticMock.address,
      SOL: solMock.address,
      SUSHI: sushiMock.address,
      TUSD: tusdMock.address,
      UNI: uniMock.address,
      USDC: usdcMock.address,
      USDT: usdtMock.address,
      WBTC: wbtcMock.address,
      WETH: wethMock.address,
    });
  }
}

function saveAddresses(network, data) {
  console.log('Saving contracts.json file...');
  const jsonFile = resolve('./scripts/data/contracts.json');
  let addresses = {};
  if (fs.existsSync(jsonFile)) {
    addresses = JSON.parse(fs.readFileSync(jsonFile, 'utf8'));
  }
  addresses[network] = _.merge(addresses[network], data);
  fs.writeFileSync(jsonFile, JSON.stringify(addresses, null, 2));
}

function saveTokenList(network, data) {
  console.log('Saving manifest.json file...');
  const jsonFile = resolve(`./tokenList/${network}/manifest.json`);
  let manifest = {};
  if (fs.existsSync(jsonFile)) {
    manifest = JSON.parse(fs.readFileSync(jsonFile, 'utf8'));

    for (const [index, token] of manifest['tokens'].entries()) {
      if (data[token['symbol']]) {
        manifest['tokens'][index]['address'] = data[token['symbol']];
      }
    }
    fs.writeFileSync(jsonFile, JSON.stringify(manifest, null, 2));
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
