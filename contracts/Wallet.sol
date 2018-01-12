pragma solidity ^0.4.8;
import './IERC20Token.sol';

////////////////////////////////////////////////////////////////////////////////////////////////////////

/// @title Wallet contract
/// @author David Young

contract Wallet {


    mapping(address=>address[]) public tokenList;

    function Wallet() {

    }

    function isTokenExisted (address[] list, address item) public constant returns (bool) {
        for (uint i = 0; i < list.length; i++) {
            if (list[i] == item) {
                return true;
            }
        }
        return false;
    }

    function addToken(address _account, address _token) public {
            if (!isTokenExisted(tokenList[_account], _token)) {
                tokenList[_account].push(_token);
            }
    }

    function getToken(address _account) public constant returns (address[]) {
        return tokenList[_account];
    }


/*

    //这个逻辑就是错的。要判断数组内存不存在某个元素，应遍历每个数组，判断每个元素是否与当前元素相等即可，并不需要单独做一个struct。一开始都不知道这个元素是否存在，就无法访问到struct的exist了....
    struct TokenInfo {
        IERC20Token token;
        //0 means unregistered
        uint exist;
    }

    mapping(address=>TokenInfo[]) public tokenList;
    //mapping(address=>IERC20Token[]) public tokenList;

    function Wallet() {

    }


    function addToken(address _account, IERC20Token _token) public returns (string){
        for (uint i = 0; i <= tokenList[_account].length; i++) {
            if (tokenList[_account][i].exist == 0) {
                //var tokenInfo = TokenInfo(_token, 1);
                //tokenList[_account].push(tokenInfo);
                //address instead of IERC20Token?
                return 'here!';
            }
        }
    }



    function getToken(address _account) public constant returns (IERC20Token[]) {
        IERC20Token[] returnList;
        for (uint i = 0; i < tokenList[_account].length; i++) {
            returnList.push(tokenList[_account][i].token);
        }
        return returnList;
    }

    function getTokenListLength(address _account) public constant returns (uint) {
        return tokenList[_account].length;
    }

/*
    function addToken(address _account, IERC20Token _token) public {
        if(tokenList[_account].exist == 0) {
            tokenList[_account].push(TokenInfo(_token, 1));
        }
    }

    function getToken(address _account) public constant returns (IERC20Token[]) {
            return tokenList[_account];
    }
*/

}
