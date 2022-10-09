pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

// import "@openzeppelin/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol


/**
 * @title Struct
 * @dev Store & retrieve value
 */

contract Struct {
    address payable owner;

    // event for EVM logging(logging old owner and new owner)
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    event Valuesend(address indexed _from, address indexed _to, uint _value);
    event Deposit(address indexed _from, uint _value);

    error HandleError(string ErrorMessage); // Error handling

      /**
     * @dev Set contract deployer as owner
     */
    constructor () {
        owner = payable(msg.sender);
        emit OwnerSet(address(0), owner);
    }

    // per address to interger
    mapping (address => uint) balance;

   /** 
     * @dev Calls deposit() function to set the sender address to value
     * @param amount value to associate to the address
     */
    function deposit (uint256 amount) public payable {
        if(amount <= 0 ){
            revert HandleError("no value");
        }
        // initial amount of sender = 0 
        balance[msg.sender] += amount;
        emit Deposit(msg.sender, amount);
    }


     /**
     * @dev Calls checkBalance() function to take the address and display it value
     * @return balance return the value associated to the address
     */
    function checkBalance(address _addr) public view returns (uint) {
        if(msg.sender != _addr || owner != _addr){
            revert HandleError("only owner or sender");
        }
        return balance[_addr];
    }


    // To key details of a user
    struct User {
        string name;
        uint256 age;
    }

    User[] user;
    // value per to the user
    mapping (address => User) userDetail;

    /** 
     * @dev Calls setUserDetails() function to set the sender address to value
     * @param name and age value are per to the address
     */
    function setUserDetails(string calldata name, uint256 age) public {
        User memory _user = User(name, age);
        user.push(_user);
        userDetail[msg.sender] = _user;
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