// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {MakePayment} from "./MakePaymentSmartContract.sol";

contract PayGizmoUserRegistration {
    // Struct to represent user information
        struct UserInfo {
        string firstName;
        string surname;
        string jobTitle;
        uint256 monthlyPay; // in GBP/USD
        string songTitle; // Only for creative earnings
        uint256 royaltyEarnings; // in GBP/USD
    }

    // Mapping to store user information
    mapping(address => UserInfo) public users;

    // Array to store addresses of registered users
    address[] public userAddresses;

    // Event to log user registration
    event UserRegistered(
        address indexed user,
        string firstName,
        string surname
    );

    // Function to register a new user
    function registerUser(
        string memory _firstName,
        string memory _surname,
        string memory _jobTitle,
        uint256 _monthlyPay,
        string memory _songTitle,
        uint256  _royaltyEarnings
    ) external {
        // Ensure the user is not already registered
        require(bytes(_firstName).length > 0 && bytes(_surname).length > 0, "First name and surname are required");

        // Add user to the mapping
        users[msg.sender] = UserInfo({
            firstName: _firstName,
            surname: _surname,
            jobTitle: _jobTitle,
            monthlyPay: _monthlyPay,
            songTitle: _songTitle,
            royaltyEarnings: _royaltyEarnings
        });

        // Add the user's address to the array
        userAddresses.push(msg.sender);

        // Emit event
        emit UserRegistered(msg.sender, _firstName, _surname);
    }

    // Function to retrieve user information
    function getUserInfo() external view returns (UserInfo memory) {
        return users[msg.sender];
    }

    // Function to retrieve the number of registered users
    function getNumUsers() external view returns (uint256) {
        return userAddresses.length;
    }

    // Function to retrieve user information by index
    function getUserInfoByIndex(uint256 index) external view returns (UserInfo memory) {
        require(index < userAddresses.length, "Index out of bounds");
        address userAddress = userAddresses[index];
        return users[userAddress];
    }

    // function registerUserAndParticipant(
    //     string memory _firstName,
    //     string memory _surname,
    //     string memory _jobTitle,
    //     uint _monthlyPay,
    //     string memory _songTitle,
    //     uint _royaltyEarnings,
    //     address _participantWallet
    // ) external {
    //     // Register the user
    //     registerUser(
    //         _firstName,
    //         _surname,
    //         _jobTitle,
    //         _monthlyPay,
    //         _songTitle,
    //         _royaltyEarnings
    //     );

    //     // Add the user as a participant in the payment contract
    //     MakePayment makePaymentContract = MakePayment(
    //         0xd9145CCE52D386f254917e481eB44e9943F39138
    //     );

    //     // Define payment terms, advance payment, and advance balance
    //     string memory paymentTerms = "Monthly"; // Define your payment terms
    //     uint256 advancePayment = 1000; // Define advance payment amount
    //     uint256 advanceBalance = 0; // Initialize advance balance to 0

    //     MakePayment.Participant memory newParticipant = MakePayment
    //         .Participant({
    //             walletAddress: _participantWallet,
    //             role: _jobTitle,
    //             royaltyEarnings: _royaltyEarnings,
    //             paymentTerms: paymentTerms,
    //             advancePayment: advancePayment,
    //             advanceBalance: advanceBalance
    //         });

    //     // Replace 'assetId' with the actual asset identifier
    //     makePaymentContract.addParticipant("asset123", newParticipant);
    // }
}
