pragma solidity ^0.4.8;

import './IERC20Token.sol';
import './PricingModel.sol';

/// @title Trade contract
/// @author David Young

contract Trade {

    uint  constant PRECISION = (10**3);

    event DoTrade( address indexed origin, address source, uint sourceAmount, address destToken, uint destAmount, address destAddress );


    function getConversionRate(address pricingModelAddr, IERC20Token source, IERC20Token dest) public constant returns(uint256) {
        var pricingModel = PricingModel(pricingModelAddr);
        return pricingModel.getRate(source, dest);
    }

    /// @dev do a trade
    /// @param sourceToken Source token
    /// @param sourceAmount Amount of source token
    /// @param destToken Destination token
    /// @param destAddress Destination address to send tokens to
    /// @return true iff trade is succesful

    function doTrade(address pricingModelAddr, IERC20Token sourceToken, uint256 sourceAmount, IERC20Token destToken, address destAddress) returns(uint256) {

        uint256 conversionRate = getConversionRate(pricingModelAddr, sourceToken, destToken);
        uint256 destAmount = (conversionRate * sourceAmount) / PRECISION;

        return destAmount;
        
        //sourceToken.transferFrom(msg.sender, destAddress, sourceAmount);
        //destToken.transferFrom(destAddress, msg.sender, destAmount); 

        //DoTrade(tx.origin, sourceToken, sourceAmount, destToken, destAmount, destAddress);
        //return true;
    }

}