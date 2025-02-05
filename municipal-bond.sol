pragma solidity ^0.8.0;

contract MunicipalBond {

    // Struct to represent a bond
    struct Bond {
        uint256 principal;  // The face value of the bond
        uint256 interestRate; // Annual interest rate (in percentage)
        uint256 maturityDate; // The date when bond matures
        uint256 interestPaid; // The total interest paid till now
        address issuer; // The town or municipality issuing the bond
        bool isActive; // If the bond is still active
    }

    // Mapping from bond ID to Bond struct
    mapping(uint256 => Bond) public bonds;
    uint256 public bondCounter = 0;

    // Mapping from investor address to their purchased bond IDs
    mapping(address => uint256[]) public investorBonds;

    // Event for bond issuance
    event BondIssued(uint256 bondId, address issuer, uint256 principal, uint256 interestRate, uint256 maturityDate);

    // Event for interest payment
    event InterestPaid(uint256 bondId, address bondholder, uint256 amount);

    // Function to issue a new bond
    function issueBond(uint256 principal, uint256 interestRate, uint256 maturityDate) public {
        bondCounter++;
        uint256 bondId = bondCounter;

        // Create a new bond
        Bond memory newBond = Bond({
            principal: principal,
            interestRate: interestRate,
            maturityDate: maturityDate,
            interestPaid: 0,
            issuer: msg.sender,
            isActive: true
        });

        // Store bond details
        bonds[bondId] = newBond;

        // Emit event
        emit BondIssued(bondId, msg.sender, principal, interestRate, maturityDate);
    }

    // Function for an investor to buy a bond
    function buyBond(uint256 bondId) public payable {
        require(bonds[bondId].isActive, "Bond is no longer active");
        require(msg.value == bonds[bondId].principal, "Incorrect amount sent");

        // Add bond to the investor's list
        investorBonds[msg.sender].push(bondId);
    }

    // Function to pay interest to bondholders (e.g., yearly interest payment)
    function payInterest(uint256 bondId) public {
        require(bonds[bondId].isActive, "Bond is no longer active");

        uint256 interestAmount = (bonds[bondId].principal * bonds[bondId].interestRate) / 100;
        bonds[bondId].interestPaid += interestAmount;

        // Transfer interest to bondholder
        address bondholder = msg.sender;  // Assume bondholder is calling this function
        payable(bondholder).transfer(interestAmount);

        // Emit interest payment event
        emit InterestPaid(bondId, bondholder, interestAmount);
    }

    // Function to mark a bond as matured
    function markBondAsMatured(uint256 bondId) public {
        require(bonds[bondId].maturityDate <= block.timestamp, "Bond has not matured yet");
        bonds[bondId].isActive = false; // Deactivate the bond once matured
    }
}
