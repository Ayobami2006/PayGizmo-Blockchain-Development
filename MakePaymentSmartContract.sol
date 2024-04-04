// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract MakePayment {
    struct Asset {
        string metadata;
        uint256 earnings;
        mapping(address => Participant) participants;
    }

    struct Participant {
        address walletAddress;
        string role;
        uint256 royaltyEarnings;
        uint256 paymentTerms;
        uint256 advancePayment;
        uint256 advanceBalance;
    }

    mapping(string => Asset) public assets;

    function retrieveAssetMetadata(
        string memory assetId
    ) public view returns (string memory) {
        return assets[assetId].metadata;
    }

    function retrieveAssetEarnings(
        string memory assetId
    ) public view returns (uint256) {
        return assets[assetId].earnings;
    }

    function addParticipant(
        string memory assetId,
        Participant memory newParticipant
    ) public {
        assets[assetId].participants[
            newParticipant.walletAddress
        ] = newParticipant;
    }

    function calculatePayment(
        string memory assetId,
        address participantAddress
    ) public view returns (uint256) {
        Participant memory participant = assets[assetId].participants[
            participantAddress
        ];
        uint256 duePayment = participant.royaltyEarnings -
            participant.advancePayment -
            participant.advanceBalance;
        return duePayment;
    }

    function disbursePayment(
        string memory assetId,
        address participantAddress
    ) public {
        Participant storage participant = assets[assetId].participants[
            participantAddress
        ];
        uint256 duePayment = calculatePayment(assetId, participantAddress);

        // Update participant's advance balance
        participant.advanceBalance += duePayment;

        // Disburse payment to participant's wallet
        address payable participantWallet = payable(participantAddress);
        bool success = participantWallet.send(duePayment);

        require(success, "Payment transfer failed");
    }
}
