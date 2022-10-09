pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

// import "@openzeppelin/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol


/**
 * @title Events
 * @dev Store & retrieve value
 */

contract Events {
    // contract owner
    address payable owner;
    
    // initialize fee
     uint256 private Fee = 20;
     uint256 public contractBalance;

    event OwnerSet(address indexed oldOwner, address indexed newOwner);   // event for changing contrast ownership(logging old owner and new owner)
    event Valuesend(address indexed _from, address indexed _to, uint _value);   // event for transaction from sender to receive and the value


    event FundsDeposited(address user, uint256 amount); // event for logging depositors
    event ProfileUpdated(address user); // event for logging user update

    error HandleError(string ErrorMessage); // Error handling
    error AmountToSmall(string amount); // Error handling



    /**
     * @dev Set contract deployer as owner
     */
    constructor () {
        owner = payable(msg.sender);
        emit OwnerSet(address(0), owner);
    }

    // owner only validations 
    modifier ownerOnly() {
        require(msg.sender == owner, "not owner");
        _;
    }

   // valid depositor validations 
    modifier onlyDepositor() {
        require(validUser[msg.sender], "deposit to continue");
        _;
    }

    // minimum deposit validations 
    modifier value(uint256 _amount) {
        if(_amount < Fee) {
            revert AmountToSmall("Amount too small");
        }
        _;
    }



   // To key details of a user
    struct User {
        string name;
        uint256 age;
    }

    // initialize struct
    User[] user;
  
    mapping (address => User) userDetail;   // value per to the user

    mapping (address => uint) balance;  // per address to interger
    mapping (address => bool) validUser;  // per address to interger
    address[] keys;

    /** 
     * @dev Calls addFund() function to set the sender address to value
     * @param amount value to associate to the address
     */
    function deposit (uint256 amount) public  {
        require(!validUser[msg.sender], "valid user addFund");
        // initial amount of sender = 0 
        balance[msg.sender] = amount;
        validUser[msg.sender] = true;
        contractBalance += amount;
        emit FundsDeposited(msg.sender, amount);
    }

   /** 
     * @dev Calls addFund() function to set the sender address to value
     * @param amount value to associate to the address
     */
    function addFund(uint256 amount) public value(amount) onlyDepositor {
        // initial amount of sender = 0 
        balance[msg.sender] += amount;
        contractBalance += amount;
        emit FundsDeposited(msg.sender, amount);
    }


     /**
     * @dev Calls checkBalance() function to take the address and display it value
     * @return balance return the value associated to the address
     */
    function checkBalance() public view returns (uint) {
        return balance[msg.sender];
    }

   
    /**
     * @dev Calls withdraw() function to withdraw the cotract fund
     */
    function withdraw () public ownerOnly {}


    /** 
     * @dev Calls setUserDetails() function to set the sender address to value
     * @param name and age value are per to the address
     */
    function setUserDetails(string calldata name, uint256 age) public {
        User memory _user = User(name, age);
        user.push(_user);
        userDetail[msg.sender] = _user;
        emit ProfileUpdated(msg.sender);
    }


     /**
     * @dev Calls getUserDetail() function to take the address and display it value
     * @return currentUser returns the value associated to the address
     */
    function getUserDetail() public view returns(User memory currentUser) {
        currentUser = userDetail[msg.sender];
    }



    // to support receiving ETH by default
    receive() external payable {
        emit Valuesend(msg.sender, address(this), msg.value);
    }
    // to support receiving ETH by default
    fallback() external payable {
        emit Valuesend(msg.sender, address(this), msg.value);
    }


}