# PayGizmoUserRegistration Smart Contract Project

This project contains the smart contract code for the UserRegistration contract, developed using Truffle and tested on the Ganache local Ethereum client.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Usage](#usage)
  - [Local Development](#local-development)

## Prerequisites

Make sure you have the following installed on your machine:

- [Node.js](https://nodejs.org/) and [npm](https://www.npmjs.com/) - JavaScript runtime and package manager
- [Truffle](https://www.trufflesuite.com/truffle) - Development framework for Ethereum
- [Ganache](https://www.trufflesuite.com/ganache) - Local Ethereum blockchain for development

## Project Structure

- **contracts/**: Contains the smart contract code.
- **migrations/**: Migration scripts to deploy contracts.
- **test/**: Test scripts for the smart contract.
- **truffle-config.js**: Truffle configuration file.

## Usage

### Local Development

1. Clone the repository:

   ```bash
   git clone https://github.com/Ayobami2006/UserReg-MakePayment-Blockchain-Development.git
   ```

2. Install dependencies:

   ```bash
   npm install -g truffle ganache-cli
   ```

3. Start Ganache:

   ```bash
   ganache-cli
   ```
   Start Ganache with your preferred settings. Make sure it's running on `http://127.0.0.1:8545` or update the `truffle-config.js` accordingly.

4. Compile and migrate the smart contract:

   ```bash
   truffle compile
   truffle migrate --reset
   ```

5. Interact with the contract:

   Use the Truffle console to interact with your deployed contract:

   ```bash
   truffle console
   ```
   
   - Accessing Contract Instance:
   ```javascript
   instance = await PayGizmoUserRegistration.deployed()
   ```
   This will give you an instance of your deployed contract. You can use this instance variable to interact with the contract functions.

   - Registering a New User on the contract:
   ```javascript
   await instance.registerUser("FirstName", "LastName", "JobTile", 5000, "SongName", 1000)
   ```
   
   - Retrieve User Information: To retrieve user information, you can call the getUserInfo function:
   ```javascript
   user = await instance.getUserInfo()
   console.log(user)
   ```

   - To check the available account, type:
   ```javascript
   account = accounts[0]
   console.log(account)
   ```

   - Exit the Console: To exit the Truffle console, type:

   ```bash
   .exit
   ```
