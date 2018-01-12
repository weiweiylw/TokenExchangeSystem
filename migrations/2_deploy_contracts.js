//var TestERC20 = artifacts.require("./TestERC20.sol");
//var ERC20Token = artifacts.require("./ERC20Token.sol");

var PricingModel = artifacts.require("./PricingModel.sol");
var DavidToken = artifacts.require("./DavidToken.sol");
var ChungToken = artifacts.require("./ChungToken.sol");
var Trade = artifacts.require("./Trade.sol");
var Wallet = artifacts.require("./Wallet.sol");

module.exports = function(deployer) {
  //deployer.deploy(TestERC20);
  //deployer.deploy(ERC20Token, 'DummyToken', 'DUM', 10000);
  //deployer.deploy(DavidToken);

  //deployer.deploy(PricingModel);
  //await deployer.deploy(SmartToken, 'Token1', 'TKN1', 2);


  deployer.deploy(PricingModel).then(function(){
  deployer.deploy(DavidToken, PricingModel.address)});
	
  deployer.deploy(Wallet);

  deployer.deploy(ChungToken);
  
  deployer.deploy(Trade);

};

  //deployer.deploy(PricingModel).then((instance) => {
  //  console.log(instance.address);
  //});