var PricingModel = artifacts.require("./PricingModel.sol");
var DavidToken = artifacts.require("./DavidToken.sol");
var ChungToken = artifacts.require("./ChungToken.sol");
var Trade = artifacts.require("./Trade.sol");
var Wallet = artifacts.require("./Wallet.sol");
//var TestERC20 = artifacts.require("./TestERC20.sol");

var contract1;
var contract2;
var contract3;
var contract4;
//var contract5;

contract('Simulator', function(accounts) {
  
  //PricingModel.deployed().then(function(instance){contract3 = instance;});

  //DavidToken.deployed(contract3.address).then(function(instance){contract = instance;});


/*
  it("1. deploy tokens", function() {
    PricingModel.deployed().then(function(instance) {
      contract3 = instance;

      DavidToken.deployed(contract3.address).then(function(instance) {
        contract1 = instance;

        return contract1.name.call();

      }).then(function(res) {
        console.log(res);
      });

      ChungToken.deployed(contract3.address).then(function(instance) {
        contract2 = instance;

        return contract2.name.call();

      }).then(function(res) {
        console.log(res);
      });

      return contract3.address;

    }).then(function(res) {

      contract1.issue.call(accounts[0], 30000).then(function(res) {
        return contract1.totalSupply.call()
      });

      console.log('issue tokens!');
      //console.log('pricingModel deployed!');
    });
  });

*/

  beforeEach(function(done){
    done();
  });
  afterEach(function(done){
    done();
  });

  it("1. deploy contracts", function() {

      PricingModel.deployed().then(function(pricingContract) {

        contract3 = pricingContract;
        return pricingContract.address;

      }).then(function(pricingAddr) {

        DavidToken.deployed(pricingAddr).then(function(davidTokenContract) {

          contract1 = davidTokenContract;
          return davidTokenContract.address;

        }).then(function(davidTokenContractAddr) {

          console.log(davidTokenContractAddr);

        });

        ChungToken.deployed(pricingAddr).then(function(chungTokenContract) {

          contract2 = chungTokenContract;
          return chungTokenContract.address;

        }).then(function(chungTokenContractAddr) {

          console.log(chungTokenContractAddr);

        });

      });

     

  });


/*
  it("2. issue tokens", function() {
      contract1.issue.call(accounts[0], 3000).then(function(res) {
        console.log(res);
      }).then(function(res) {
        contract1.totalSupply.call().then(function(res) {
          console.log(res);
        });
      });
  });
*/

/*
  it("2. issue tokens", function() {
      contract1.issue.call(accounts[0], 3000).then(function(res) {
        console.log(res);

        contract1.totalSupply.call().then(function(res) {
          console.log(res);
        });

      });
  });
*/

/*

  it("2. issue tokens", function() {

    var res = contract1.issue(accounts[0], 3000);
    console.log(res);
    //return contract1.name.call().then(function(res) {
    //  console.log(res)
    //});

    var name = contract1.name();
    console.log(name);

  });
*/

/*
  it("2. issue tokens", function() {
    return contract1.issue(accounts[0], 3000).then(function() {
      //return contract1.totalSupply.call();
      //return contract1.totalSupply();
      return contract1.balanceOf(accounts[0]);
    }).then(function(res) {
      console.log(res);  
    })
  */
  var tokenPrice;

  it("2. issue tokens", async() => {


    await contract1.issue(accounts[0], 3000);

    await contract1.transferFrom(accounts[0], accounts[1], 1000);

    await contract3.setPriceIndex(contract1.address, 200);

    await contract3.setVelocity(contract1.address, 9);

    await contract3.setPrice(contract1.address);

    //contract1.totalSupply.call().then(function(supply) {
    //  console.log(supply);
    //});

    //contract1.balanceOf.call(accounts[0]).then(function(balance) {
    //  console.log(balance);
    //})


/*
    await contract3.getPrice.call(contract1.address).then(function(price) {
      //console.log(price);
      tokenPrice = price;
    });



    var timer = setInterval(function(){
        doItPerSecond();
    },1000)
     
    function doItPerSecond() {
        console.log(tokenPrice);
    }
*/


    var timer = setInterval(function(){
      contract3.setPrice(contract1.address);
      contract3.getPrice.call(contract1.address).then(function(price) {
        console.log(price);
      });
    },1000)

    var timer2 = setInterval(function(){
      contract1.issue(accounts[0], 3000);
    },1000)
     

  })
  
  /*

  it("should increase the total as amounts are added", async () => {
    let instance = await Adder.deployed();
    await instance.add(10);
    assert.equal((await instance.getTotal.call()).toNumber(), 10);
  });
*/


/*

      contract1.issue.call(accounts[0], 3000).then(function(res) {
        console.log(res);
      });

      contract1.balanceOf.call(accounts[0]).then(function(res) {
        console.log(res);
      });
  });
*/


/*

  it("3. get supply", function() {
      contract1.totalSupply.call().then(function(res) {
          console.log(res);
        });
  });
*/

/*
  it("deploy pricing model", function() {

    return PricingModel.deployed().then(function(instance) {
      return instance.setPriceIndex.call(accounts[0],123);

    }).then(function(res) {
      console.log(res);
    });
  });
*/


});