pragma solidity ^0.4.11;
import './IERC20Token.sol';
import './PricingModel.sol';
import './Wallet.sol';

/**
    ERC20 Standard Token implementation
*/
contract DavidToken is IERC20Token{
    string public name = 'DavidToken';
    string public symbol = 'DAV';
    uint8 public decimals = 18;
    uint256 public totalSupply = 0;

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // triggered when the total supply is increased
    event Issuance(uint256 _amount);
    // triggered when the total supply is decreased
    event Consumption(uint256 _amount);

    address public pricingModelAddr;
    //address public walletAddr;

    /**
        @dev constructor
    */

    function DavidToken(address _pricingModelAddr) {
        pricingModelAddr = _pricingModelAddr;
        //walletAddr = _walletAddr;
    }
    
    function getpricingModelAddr() constant returns(address) {
        return pricingModelAddr;
    }

    function issue(address _to, uint256 _amount) public {
        totalSupply += _amount;
        balanceOf[_to] += _amount;

        setSupplyToPricingModel();

        Issuance(_amount);
        Transfer(this, _to, _amount);

    }

    function consume(address _from, uint256 _amount) public {
        balanceOf[_from] -= _amount;
        totalSupply -= _amount;

        setSupplyToPricingModel();

        Transfer(_from, this, _amount);
        Consumption(_amount);
    }

/*
    function setTokenToWallet(address _account) public {
        var wallet = Wallet(walletAddr);
        wallet.addToken(_account, this);
    }
*/

    function setSupplyToPricingModel() public {
        var pricingModel = PricingModel(pricingModelAddr);
        pricingModel.setSupply(this, totalSupply);
    }


    function setVolumeToPricingModel(uint256 _amount) public {
        var pricingModel = PricingModel(pricingModelAddr);

        //Add transfer volume
        var volume_new = pricingModel.getVolume(this) + _amount;

        pricingModel.setVolume(this, volume_new);
    }

    /**
        @dev send coins
        throws on any error rather then return a false flag to minimize user errors

        @param _to      target address
        @param _value   transfer amount

        @return true if the transfer was successful, false if it wasn't
    */
    function transfer(address _to, uint256 _value) public returns (bool success) {
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        setVolumeToPricingModel(_value);

        Transfer(msg.sender, _to, _value);
        return true;
    }

    /**
        @dev an account/contract attempts to get the coins
        throws on any error rather then return a false flag to minimize user errors

        @param _from    source address
        @param _to      target address
        @param _value   transfer amount

        @return true if the transfer was successful, false if it wasn't
    */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        //allowance[_from][msg.sender] -= _value;
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        setVolumeToPricingModel(_value);

        Transfer(_from, _to, _value);
        return true;
    }

    /**
        @dev allow another account/contract to spend some tokens on your behalf
        throws on any error rather then return a false flag to minimize user errors

        also, to minimize the risk of the approve/transferFrom attack vector
        (see https://docs.google.com/document/d/1YLPtQxZu1UAvO9cZ1O2RPXBbT0mooh4DYKjA_jp-RLM/), approve has to be called twice
        in 2 separate transactions - once to change the allowance to 0 and secondly to change it to the new allowance value

        @param _spender approved address
        @param _value   allowance amount

        @return true if the approval was successful, false if it wasn't
    */
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
}
