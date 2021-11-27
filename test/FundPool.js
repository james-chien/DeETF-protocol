const { expect } = require('chai');
const _ = require('lodash');
const { AddressZero, MaxUint256 } = require('ethers').constants;

const toWei = require('ethers').utils.parseEther;
const fromWei = require('ethers').utils.formatEther;

describe('FundPool contract', function () {
  let deployer; // 😎
  let godzilla; // 🦖
  let kong;     // 🐵

  let aaveToken;
  let bnbToken;
  let busdToken;
  let priceFeed;
  let fundFactory;
  let fundPool;

  let testFundPool;

  beforeEach(async () => {
    [deployer, godzilla, kong] = await ethers.getSigners();

    // tokens mock
    const AAVEMock = await ethers.getContractFactory('AAVEMock');
    aaveToken = await AAVEMock.deploy();
    await aaveToken.deployed();

    const BNBMock = await ethers.getContractFactory('BNBMock');
    bnbToken = await BNBMock.deploy();
    await bnbToken.deployed();

    const BUSDMock = await ethers.getContractFactory('BUSDMock');
    busdToken = await BUSDMock.deploy();
    await busdToken.deployed();

    // Chainlink aggregator mock
    const AggregatorMock = await ethers.getContractFactory('AggregatorMock');

    const aaveAggregator = await AggregatorMock.deploy('26893297691');
    await aaveAggregator.deployed();

    const bnbAggregator = await AggregatorMock.deploy('56832250495');
    await bnbAggregator.deployed();

    const busdAggregator = await AggregatorMock.deploy('100004763');
    await busdAggregator.deployed();

    // Chainlink Price feed
    const PriceFeed = await ethers.getContractFactory('PriceFeed');
    priceFeed = await PriceFeed.deploy(
      [
        aaveToken.address,
        bnbToken.address,
        busdToken.address,
      ],
      [
        aaveAggregator.address,
        bnbAggregator.address,
        busdAggregator.address,
      ]
    );
    await priceFeed.deployed();

    // fund factory
    const FundFactory = await ethers.getContractFactory('FundFactory');
    fundFactory = await FundFactory.deploy(priceFeed.address);
    await fundFactory.deployed();

    await fundFactory.createPool(
      'SPX Fund',
      'SETF',
      [
        aaveToken.address,
        bnbToken.address,
        busdToken.address,
      ],
      [
        toWei('0.05'),
        toWei('0.03'),
        toWei('0.02'),
      ],
      1000
    );
    const poolAddresses = await fundFactory.poolsOf(deployer.address);
    const poolAddress = poolAddresses[poolAddresses.length - 1];

    const FundPool = await ethers.getContractFactory('FundPool');
    fundPool = FundPool.attach(poolAddress);

    await aaveToken.approve(poolAddress, MaxUint256);
    await bnbToken.approve(poolAddress, MaxUint256);
    await busdToken.approve(poolAddress, MaxUint256);
  });

  it('returns the correct name', async function () {
    expect(await fundPool.name()).to.equal('SPX Fund');
  });

  it('returns the correct symbol', async function () {
    expect(await fundPool.symbol()).to.equal('SETF');
  });

  it('returns the correct nav', async function () {
    expect(await fundPool.nav()).to.equal('83825552949');
  });

  it('can create unit', async function () {
    await fundPool.create(1);
    expect(await fundPool.balanceOf(deployer.address)).to.equal('1000');
  });

  it('can redeem tokens', async function () {
    await fundPool.create(1);
    await fundPool.redeem(1000);
    expect(await fundPool.balanceOf(deployer.address)).to.equal('0');
  });
});
