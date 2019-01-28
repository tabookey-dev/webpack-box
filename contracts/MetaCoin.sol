pragma solidity ^0.4.24;

import "tabookey-gasless/contracts/RelayRecipient.sol";

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin is RelayRecipient
 {

    function accept_relayed_call(address /*relay*/, address from, bytes memory /*encoded_function*/, uint /*gas_price*/, uint /*transaction_fee*/ ) public view returns(uint32) {
	

		return 0;
    	//allow free calls for token holders..
    	if ( balances[from] > 0 ) return 0;

    	// prevent anyone else.
		return 99;
	}

	//nothing to be done post-call. still, we must implement this method.
    function post_relayed_call(address relay, address from, bytes memory encoded_function, bool success, uint used_gas, uint transaction_fee ) public {
	}

	mapping (address => uint) balances;

	//give every account initial 100 tokens..
	mapping (address => bool) initial_fund;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	constructor(RelayHub hub) public {
		balances[tx.origin] = 10000;
		init_relay_hub(hub);
	}

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		fill_initial(get_sender());
		fill_initial(receiver);
		require (balances[get_sender()] >= amount);
		balances[get_sender()] -= amount;
		balances[receiver] += amount;
		emit Transfer(get_sender(), receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		fill_initial(addr);

		return balances[addr];
	}

	//this is required to simplify our test: we "air-drop" each new account with a lump of coins.
	// in a real project, of course, there are better mechanism to assign coins to users.
	function fill_initial(address addr) internal {
		if ( !initial_fund[addr] ) {
			balances[addr] += 10000;
			initial_fund[addr] = true;
		}
	}
}
