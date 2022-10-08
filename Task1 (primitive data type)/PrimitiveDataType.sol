pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

// import "@openzeppelin/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol


/**
 * @title PrimitiveDataType
 * @dev Set student data, Get student data & change owner
 */

contract PrimitiveDataType {
      address private owner;

    address[] registeredStudentList;

    // event for EVM logging(logging old owner and new owner)
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    event StudentLog(address indexed sender, address indexed studentID,uint8 percentage,uint8 totalmark);

    /**
     * @dev Set contract deployer as owner
     */
    constructor() {
        owner = msg.sender;
        emit OwnerSet(address(0), owner);
    }

    //  This contains the data of the student
    struct Student {
        address studentID;
        uint8 percentage;
        uint8 totalMarks;
    }

    Student[] student;

    // pering student to an ID 
    mapping(address => Student) studentdetail;

    // modifier to check if caller is owner
    modifier onlyOwner() {
        require(msg.sender == owner, "can only be executed by the contract owner");
        _;
    }

    // modifier to check if the registered address is a valid address
    modifier validAddress(address _addr) {
        require(_addr != address(0), "provide a valid address");
        _;
    }

    // modifier loop through the list of students pass thereby confirming the validation of the addresses
    function checkValid (address[] memory _addr) internal pure returns(bool){
        for (uint i = 0; i < _addr.length; i++){
            if(_addr[i] != address(0)){
                return true;
            }
           
        } 
         return false;
    }

 /** 
     * @dev Calls checkregisteredstudent() function to check if the address is alreaady a registered student
     * @dev value pass (student ID)
     * @return true or false depend depending on the condition
     */
    function checkregisteredstudent(address _addr) internal view returns (bool){
        for (uint i; i < registeredStudentList.length; i++) {
            if (registeredStudentList[i] == _addr) {
                return true;
            }
        }
        return false;
    }

    /** 
     * @dev Calls register() function to set student up
     * @dev value pass (student ID, percentage, totalMarks)
     */

    function register(address[] memory _studentID, uint8 _percentage, uint8 _totalMarks) public onlyOwner {
        require( _percentage <= 100, "percentage should not be greater than 100%");
        require( _totalMarks <= 100, "total marks should not be greater than 100");
        require(checkValid(_studentID) == true, "not a valid address");


        for(uint i; i < _studentID.length; i++){
            // check if the ID is already register
            //  if false register else delete it from the array

            if(checkregisteredstudent(_studentID[i]) != true){
                Student memory newstudent = (Student(_studentID[i], _percentage, _totalMarks));
                student.push(newstudent);
                studentdetail[_studentID[i]] = newstudent;

                registeredStudentList.push(_studentID[i]);
                emit StudentLog(msg.sender, _studentID[i], _percentage, _totalMarks);
            } 

            if(checkregisteredstudent(_studentID[i]) == true){
              delete _studentID[i];
              continue;
            }

        }

 
    }


    /** 
     * @dev Calls getStudentDetails() function to get the index of the winner contained in the student array and then
     * @dev value pass (student ID)
     * @return studentdetail to get the detail of the student
     */
    function getStudentDetails(address studentID)
        public
        view
        returns (Student memory)
    {
        return studentdetail[studentID];
    }

  /**
     * @dev Return number of registered student 
     * @return registeredStudentList to get the number of registered student 
     */
    function numberOfRegisterStudent() public view returns (uint256) {
        return registeredStudentList.length;
    }



    /**
     * @dev Change owner
     * @param _addr address of new owner
     */
    function transferOwnership(address _addr)external onlyOwner validAddress(_addr){
        emit OwnerSet(owner, _addr);
        console.log("contract Owner change from %s to %s", owner, _addr);
        owner = _addr;
    }


  /**
     * @dev Calls getAllStudent() function to get an array of addresses for registered student 
     * @return registeredStudentList of addresses of registered student 
     */
    function getAllStudent() internal view returns (address[] memory) {
        return registeredStudentList;
    }

    // to support receiving ETH by default
    receive() external payable {}

    fallback() external payable {}
}
