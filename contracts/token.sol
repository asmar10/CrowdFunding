pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract token is ERC20 {
    constructor(uint256 initialSupply) ERC20("token", "tok") {
        _mint(msg.sender, initialSupply);
    }
}

contract challenge {
    event Funded(address indexed funder, uint amount);

    ERC20 _token = ERC20(0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8);
    uint public fundingGoal = 1000;
    mapping(address => uint) public funders;
    uint public fundsAdded;
    uint public fundingGoalTime = block.timestamp + 60;

    function fund(uint amount) public {
        require(amount > 0, "Enter a valid amount");
        require(
            _token.balanceOf(msg.sender) >= amount,
            "You dont have enough balance"
        );
        funders[msg.sender] = amount;
        fundsAdded = fundsAdded + amount;
        emit Funded(msg.sender, amount);
    }

    function refund() public {
        require(funders[msg.sender] > 0, "You havent funded anything");
        require(fundingGoalTime < block.timestamp, "Theres still time");
        uint value = funders[msg.sender];
        funders[msg.sender] = 0;
        fundsAdded = fundsAdded - value;
        payable(msg.sender).transfer(value);
    }
}
