pragma solidity 0.8.13;

contract Vending {

    // Declare state variables of the contract
    address public owner;
    mapping (address => uint) public oanixBalance;

    // When 'Vending' contract is deployed:
    // 1. set the deploying address as the owner of the contract
    // 2. set the deployed smart contract's Oanix balance to 100
    constructor() public {
        owner = msg.sender;
        oanixBalance[address(this)] = 100;
    }

    // Allow the owner to increase the smart contract's Oanix balance
    function refill(uint amount) public {
        require(msg.sender == owner, "Only the owner can refill.");
        oanixBalance[address(this)] += amount;
    }

    // Allow anyone to purchase Oanix
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 1 ether, "You must pay at least 1 ETH per Oanix");
        require(oanixBalance[address(this)] >= amount, "Not enough Oanix in stock to complete this purchase");
        oanixBalance[address(this)] -= amount;
        oanixBalance[msg.sender] += amount;
    }
}
