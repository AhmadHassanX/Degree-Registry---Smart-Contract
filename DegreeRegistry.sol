// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This smart contract lets the owner or authorized moderators
// manage student degree records on the Ethereum blockchain.
contract DegreeRegistry {
    // Structure to hold a student's degree details
    struct Student {
        string name;         // Full name of the student
        uint degreeNo;       // Unique degree ID
        string degreeTitle;  // Name of the degree 
        string institution;  // Institution that issued the degree
        uint issueYear;      // Year in which the degree was awarded
    }

    // Stores student records mapped by their CNIC
    mapping(string => Student) private students;

    // Keeps track of which addresses are allowed to modify records
    mapping(address => bool) private moderators;

    // Owner of the contract (usually the deployer)
    address private owner;

    // Events to log important actions on-chain
    event StudentAdded(string name, string cnic);
    event StudentUpdated(string name, string cnic);
    event StudentDeleted(string cnic);
    event ModeratorAdded(address indexed moderator);
    event ModeratorRemoved(address indexed moderator);

    // Restricts function usage to contract owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Allows only the owner or an authorized moderator to call the function
    modifier onlyAuthorized() {
        require(msg.sender == owner || moderators[msg.sender], "Not authorized");
        _;
    }

    // Set the contract deployer as the owner when the contract is first deployed
    constructor() {
        owner = msg.sender;
    }

    // Add a new moderator (can modify student records)
    function addModerator(address moderatorAddress) external onlyOwner {
        require(moderatorAddress != address(0), "Invalid address");
        require(moderatorAddress != owner, "Owner cannot be a moderator");
        moderators[moderatorAddress] = true;
        emit ModeratorAdded(moderatorAddress);
    }

    // Remove a moderator
    function removeModerator(address moderatorAddress) external onlyOwner {
        require(moderators[moderatorAddress], "Not a moderator");
        moderators[moderatorAddress] = false;
        emit ModeratorRemoved(moderatorAddress);
    }

    // Add a new student record
    function addStudent(
        string memory _name,
        uint _degreeNo,
        string memory _degreeTitle,
        string memory _institution,
        uint _issueYear,
        string memory _cnic
    ) external onlyAuthorized {
        require(bytes(_name).length > 0, "Name is required");
        require(bytes(_cnic).length > 0, "CNIC is required");
        require(_degreeNo > 0, "Degree number required");
        require(_issueYear > 1900, "Enter valid issue year");
        require(bytes(students[_cnic].name).length == 0, "Student already exists");

        students[_cnic] = Student(_name, _degreeNo, _degreeTitle, _institution, _issueYear);
        emit StudentAdded(_name, _cnic);
    }

    // Update existing student record by CNIC
    function updateStudent(
        string memory _name,
        uint _degreeNo,
        string memory _degreeTitle,
        string memory _institution,
        uint _issueYear,
        string memory _cnic
    ) external onlyAuthorized {
        require(bytes(students[_cnic].name).length > 0, "Student not found");
        require(_degreeNo > 0, "Invalid degree number");

        students[_cnic] = Student(_name, _degreeNo, _degreeTitle, _institution, _issueYear);
        emit StudentUpdated(_name, _cnic);
    }

    // Remove a student record from the contract
    function deleteStudent(string memory _cnic) external onlyAuthorized {
        require(bytes(students[_cnic].name).length > 0, "Student not found");
        delete students[_cnic];
        emit StudentDeleted(_cnic);
    }

    // Get student details using their CNIC
    function getStudent(string memory _cnic) external view returns (
        string memory name,
        uint degreeNo,
        string memory degreeTitle,
        string memory institution,
        uint issueYear
    ) {
        Student memory stu = students[_cnic];
        require(bytes(stu.name).length > 0, "Student not found");
        return (stu.name, stu.degreeNo, stu.degreeTitle, stu.institution, stu.issueYear);
    }

    // Utility function to check if someone is a moderator
    function isModerator(address user) external view returns (bool) {
        return moderators[user];
    }

    // Utility function to check if the caller is the owner
    function isOwner(address user) external view returns (bool) {
        return user == owner;
    }
}
