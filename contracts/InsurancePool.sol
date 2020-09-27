// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/math/Math.sol";
import "@chainlink/contracts/ChainlinkClient.sol";

contract InsurancePool is AccessControl, Ownable, ChainlinkClient {
    using SafeMath for uint256;
    
    struct Disbursement {
        address payable hospitalAddress;
        address patientAddress;
        bytes32 ailment;
        uint256 cost;
        uint256 timestamp;
        bool isPaid;
    }

    uint256 public memberCount = 0;
    uint256 public memberMaxCount = 1000;
    uint256 public coverageMultiple = 10;
    uint256 public price = 3 ether;
    uint256 public poolValue = 0 ether;
    uint256 public coverageLimit = price.mult(coverageMultiple);
    uint256 public duration = 365 days;
    uint256 public disbursementCount = 0;
    bool public instantPayment = false;
    
    mapping(address => bool) memberAutoRenew;
    mapping(address => uint256) memberDisbursements;
    mapping(uint => Disbursement) disbursementLog;

    bytes32 public constant CONTRACT_OWNER_ROLE = keccack256("CONTRACT_OWNER");
    bytes32 public constant HOSPITAL_ROLE = keccak256("HOSPITAL");
    bytes32 public constant APPROVED_MEMBER_ROLE = keccak256("APPROVED_MEMBER");
    bytes32 public constant INSURED_MEMBER_ROLE = keccak256("INSURED_MEMBER");


    constructor() public {
        owner = msg.sender;
        _setupRole(CONTRACT_OWNER_ROLE, msg.sender);
        _setRoleAdmin(HOSPITAL_ROLE, CONTRACT_OWNER_ROLE);
        _setRoleAdmin(APPROVED_MEMBER_ROLE, CONTRACT_OWNER_ROLE);
        _setRoleAdmin(INSURED_MEMBER_ROLE, APPROVED_MEMBER_ROLE);
    }

    /**
     * Contract owner grants APPROVED_MEMBER_ROLE so member can purchase insurance
     */
    function ApproveMember(address memberAddress) 
    public onlyOwner {
        require(memberAddress != owner);
        grantRole(APPROVED_MEMBER_ROLE, memberAddress);
    }

    /**
     * Contract owner grants HOSPITAL_ROLE so hospital can request disbursements
     */
    function ApproveHospital(address hospitalAddress) 
    public onlyOwner {
        grantRole(HOSPITAL_ROLE, providerAddress);
    }

    /

    /**
     * Member purchases the insurance
     * Eth is transfered to the contract implicitly
     */
    function PurchaseInsurance(bool setAutoRenew) 
    payable public {
        // 1: Check for member approved and they are the active member
        require(hasRole(APPROVED_MEMBER_ROLE, msg.sender) && !hasRole(INSURED_MEMBER_ROLE, msg.sender));
        // 2: Check payment amount
        require(msg.value == price);
        // 3: Grant approved role
        grantRole(INSURED_MEMBER_ROLE, msg.sender);
        // 4: Update member count and validate not above max
        memberCount = getRoleMemberCount();
        require(memberCount < memberMaxCount)
        // 5: Update coverage limits (no more than the pool balance)
        flatLimit = min(price.mult(coverageMultiple), poolTotal);
        // 6: Queue expiration job using ChainLink alarm clock
        // !!! TODO !!!
    }
    

    /**
     * Hospital calls this to request payment from the pool
     * Payment happens automatically IF instantPayment config is enabled
     */
    function RequestDisbursement(address memberAddress, bytes32 procedure, uint256 amount)
    public
    {
        // Step 1: Check member balance
        require(memberDisbursements.add(amount) < flatLimit);
        // Step 2: Increase member disbursements
        memberDisbursements[memberAddress] = memberDisbursements[memberAddress].add(amount);
        // Step 3: Store the disbursement request
        disbursementCount += 1;
        uint disbursementID = disbursementCount;
        Disbursement disbursement = Disbursement({
            addrHospital: msg.sender, 
            patientAddress: memberAddress,
            ailment: procedure, 
            cost: amount,
            date: block.timestamp,
            isPaid: false
        });
        if(instantPayment == true){
            disbursement.hospitalAddress.transfer(disbursement.cost);
            disbursement.isPaid = true;
        }
        disbursementLog[disbursementID] = disbursement;
    }    

    /**  
     * Contract owner OR patient can release payment to the hospital
     */
    function ApproveDisbursement(uint disbursementID) 
    public
    {
        // 1: Retrieve the disbursement record
        Disbursement disbursement = disbursementLog[disbursementID];
        // 2: Validate disbursement is not already paid for
        require(disbursement.isPaid == false);
        // 3: Validate sender as contract owner or patient
        require(hasRole(CONTRACT_OWNER_ROLE) || disbursement.patient == msg.sender)
        // 4: Send ETH to the hospital equal to disbursement value
        disbursement.hospitalAddress.transfer(disbursement.cost);
        // 5: Mark the disbursement as paid
        disbursement.isPaid = true;
        // 6: Update the disbursement record in storage
        disbursementLog[disbursementID] = disbursement;
    }

    /**
     * Disable AutoRenew -- Can only be enabled by the member when purchasing new insurance
     */
    function DisableAutoRenew() {
        require(hasRole(INSURED_MEMBER_ROLE, msg.sender) || hasRole(CONTRACT_OWNER_ROLE, msg.sender));
        memberAutoRenew[msg.sender] = false;
    }

    /**
     * Called by ChainLink alarm clock when the insurance period is expired
     */
    function ExpireInsurance() {
        require(hasRole(INSURED_MEMBER_ROLE, msg.sender || hasRole)
    }
    

    /**
     * Anyone can check the balance for any address
     */
    function GetMemberDisbursementTotal() 
    public view returns(uint256) {
        return (memberDisbursements[msg.sender]);
    }

    /**
     * Check if you have auto-renew enabled
     */
    function GetAutoRenew () 
    public view returns (bool) {
        return memberAutoRenew[msg.sender];
    }
    
    /**
     * View member payment history since purchase
     */
    function ViewMemberDisbursements(address memberAddress) 
    public view returns (uint) {
        return memberDisbursements[memberAddress];
    }
   
} 