# Growic Solidity Developer Program
A  Solidity Developer Program eth-miami

## Task one


#### **Description**

> Perform the task and share the link to your github in the field below.

#### **Instructions**
> Create a smart contract for registering the details of a student with their StudentID(Ethereum Address) and to get the details based on their Student ID and they can be added only by the contract deployed address. Also, check whether the studentID data already exists. Also, have a function to view the Details of student based on their studentID including percentage and Total Marks.

#### **State variables:**

* Make owner a state variable with value type address and make it public
* Have a mapping of address to students, you can give the mapping any name of your choice
* Have a constructor that ensures that owner is equal to the msg.sender
* Make use of a custom error if wish to
* Have a modifier called onlyOwner and require that msg.sender = owner
* Have a struct to contain details of students
* Make sure that student cannot register twice
* Have a function to get student details and it accepts one argument
* Have a function to register students and it should be onlyOwner
* function register(address studentID) then add all the rest details of the student from your struct to the argument of this function
* function getStudentDetails(address studentID)

[Task one Solution](https://github.com/ikpeku/Growic-Solidity-Developer-Program/blob/main/Task1%20(primitive%20data%20type)/PrimitiveDataType.sol)).

#### **Review**
- This task has introduce me to a lot of data types and modifier
- I learned some optimizing e.g i pass in an array of Student then loop through to verify each which also save gas to by 50%.