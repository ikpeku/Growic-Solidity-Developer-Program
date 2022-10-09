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

## [Task one Solution](https://github.com/ikpeku/Growic-Solidity-Developer-Program/blob/main/Task1%20(primitive%20data%20type)/PrimitiveDataType.sol).

#### **Review Task 1**
- This task has introduce me to a lot of data types and modifier
- I learned some optimizing e.g i pass in an array of Student then loop through to verify each which also save gas to by 50%.


## Task two

#### **Description**

> Perform the task and share the link to your github in the field below.

#### **Instructions**
> Create a smart contract that saves user balance. The contract should have the functions:

* deposit (uint256 amount) this function accepts one argument and it saves the amount a user is depositing into a mapping,
* checkBalance() this function searches for the user balance inside the balance mapping and returns the balance of whoever is calling the contract.

## [Task two Solution](https://github.com/ikpeku/Growic-Solidity-Developer-Program/blob/main/Task2%20(mappings)/Mappings.sol).

#### **Review Task 2**
- uping my knowledge of mapping 
- learned how to customize error and also reduce gas


## Task three

#### **Description**

> You must complete the tasks from the 'Mapping' and 'Structs' topics before you begin this assignment.
Perform the task and share the link to your github in the field below.

#### **Instructions**

> This task extends the functionality of the previous task. Create a deposit function that allows anybody to send funds. Store the user and the amount in a mapping as the previous task.

* Add a withdraw function and create a modifier that only allows the owner of the contract to withdraw the funds.
* Add an addFund function and create a modifier that only allows users that have deposited using the deposit function, to increase their balance on the mapping. The function should accept the amount to be added and update the mapping to have the new balance
    > Hint: if their balance is zero on the mapping, it should revert
    >
    > Hint: theMapping[userId] = theMapping[userId] + _amount;

* Create a modifier that accepts a value(uint256 _amount):
    * Create a private constant variable called Fee
    * In the modifier check if the value(_amount) it accepts is less than the Fee, revert with a custom error AmountToSmall()
Add it to the addFund function
    > Hint: addFund(uint256 _amount)..........

## [Task two Solution](https://github.com/ikpeku/Growic-Solidity-Developer-Program/blob/main/Task2%20(mappings)/Mappings.sol).