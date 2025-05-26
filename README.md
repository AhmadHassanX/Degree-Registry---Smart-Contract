# DegreeRegistry Smart Contract

A Solidity smart contract for managing student degree records on the Ethereum blockchain.  
This contract enables the contract owner and authorized moderators to add, update, delete, and view student degree information securely and transparently.

---

## Overview

The **DegreeRegistry** contract allows:

- Storage of student degree details (name, unique degree number, degree title, issuing institution, and issue year) mapped by their CNIC (a unique national ID).
- Role-based access control:
  - **Owner** (contract deployer) has full control.
  - **Moderators** authorized by the owner can manage student records.
- Event logging for important actions like adding/removing moderators and managing student records.

---

## Features

- Add new student degree records.
- Update existing student records.
- Delete student records.
- Retrieve student information by CNIC.
- Manage moderators who can also modify records.
- Owner-only access for moderator management.
- Secure and permissioned access with Solidity modifiers.
- Emits events for transparency and off-chain monitoring.

---

## Contract Details

- Solidity version: `^0.8.0`
- Owner is set as the contract deployer.
- Moderators are managed by the owner.
- Student data structure includes:
  - `name`: Student's full name
  - `degreeNo`: Unique degree number
  - `degreeTitle`: Degree name/title
  - `institution`: Issuing institution name
  - `issueYear`: Year degree was awarded

---

## Deployment

This contract has been written and deployed using [Remix IDE](https://remix.ethereum.org/).

### How to deploy on Remix:

1. Open Remix IDE.
2. Create a new Solidity file and paste the `DegreeRegistry` contract code.
3. Compile the contract using the Solidity compiler (`0.8.x`).
4. Select an environment (e.g., Injected Web3 for MetaMask or JavaScript VM for local testing).
5. Deploy the contract.
6. Use the deployed contract interface to interact with the functions.

---

## Usage

### Owner functions

- `addModerator(address moderatorAddress)`  
  Add a new moderator who can modify student records.

- `removeModerator(address moderatorAddress)`  
  Remove an existing moderator.

### Moderator & Owner functions

- `addStudent(name, degreeNo, degreeTitle, institution, issueYear, cnic)`  
  Add a new student record.

- `updateStudent(name, degreeNo, degreeTitle, institution, issueYear, cnic)`  
  Update an existing student record.

- `deleteStudent(cnic)`  
  Delete a student record.

### Public view functions

- `getStudent(cnic)`  
  Get student details by CNIC.

- `isModerator(address)`  
  Check if an address is a moderator.

- `isOwner(address)`  
  Check if an address is the owner.

---

## Events

- `StudentAdded(name, cnic)` — emitted when a new student is added.
- `StudentUpdated(name, cnic)` — emitted when a student record is updated.
- `StudentDeleted(cnic)` — emitted when a student record is deleted.
- `ModeratorAdded(moderator)` — emitted when a new moderator is added.
- `ModeratorRemoved(moderator)` — emitted when a moderator is removed.
- 
---

*Happy blockchain coding! 🚀*

