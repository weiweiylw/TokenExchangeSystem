pragma solidity ^0.4.8;
import './IERC20Token.sol';

////////////////////////////////////////////////////////////////////////////////////////////////////////

/// @title Pricing contract
/// @author David Young

contract PricingModel {

    uint  constant PRECISION = (10**3);

    mapping(address=>uint256) public tokenPrice;
    mapping(bytes32=>uint256) pairConversionRate;

    //Fisher Equation: P = (I * T) / (B * V)
    //P - price
    //I - price index level of global
    //T - size of token, 
    //B - supply of token, 
    //V - velocity of token

    mapping(address=>uint256) public tokenPirceIndex;//I
    mapping(address=>uint256) public tokenVolume;//T
    mapping(address=>uint256) public tokenSupply;//B
    mapping(address=>uint256) public tokenVelocity;//V


    function PricingModel() {

    }


    //get and set price
    function getPrice(IERC20Token token) constant returns(uint256) {
        return tokenPrice[token];
    }
    function setPrice(IERC20Token token) returns(bool) {
        var newPrice = (tokenPirceIndex[token] * tokenVolume[token] * PRECISION) / (tokenSupply[token] * tokenVelocity[token]);
        tokenPrice[token] = newPrice;
        return true;
    }


    //get and set rate
    function getRate(IERC20Token source, IERC20Token dest) constant returns(uint256) {
        var hash = sha3(source,dest);
        return pairConversionRate[hash];
    }
    function setRate(IERC20Token source, IERC20Token dest) returns(bool) {
        var rate = tokenPrice[source] * PRECISION / tokenPrice[dest];
        var hash = sha3(source,dest);
        pairConversionRate[hash] = rate;
        return true;
    }


    //get and set priceINdex
    function getPriceIndex(IERC20Token token) constant returns(uint256) {
        return tokenPirceIndex[token];
    }
    function setPriceIndex(IERC20Token token, uint256 _amount) returns(bool) {
        tokenPirceIndex[token] = _amount;
        return true;
    }


    //get and set supply
    function getSupply(IERC20Token token) constant returns(uint256) {
        return tokenSupply[token];
    }

    function setSupply(IERC20Token token, uint256 _amount) public returns(bool) {
        tokenSupply[token] = _amount;
        return true;
    }


    //get and set volume
    function getVolume(IERC20Token token) constant returns(uint256) {
        return tokenVolume[token];
    }
    function setVolume(IERC20Token token, uint256 _amount) public returns(bool) {
        tokenVolume[token] = _amount;
        return true;
    }


    //get and set volume
    function getVelocity(IERC20Token token) constant returns(uint256) {
        return tokenVelocity[token];
    }
    function setVelocity(IERC20Token token, uint256 _amount) public returns(bool) {
        tokenVelocity[token] = _amount;
        return true;
    }




}
