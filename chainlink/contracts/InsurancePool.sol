pragma solidity >0.6.99 <0.8.0;

import "@openzepplin/contracts/access/Ownable.sol";
import "@openzepplin/contracts/access/AccessControl.sol";
import "@openzepplin/contracts/token/ERC20/ERC20.sol";
import "@openzepplin/contracts/math/SafeMath.sol";

contract InsurancePool is AccessControl, Ownable {
    using SafeMath for uint256;

    uint256 memberCount = 0;
    uint256 memberMaxCount = 1000;
    uint256 price = 5000;
    uint256 totalValue = 0;
    uint256 flatLimit;
    uint256 percentLimit;

    bytes32 public constant CONTRACT_OWNER_ROLE = keccack256("OWNER_ROLE");
    bytes32 public constant CARE_PROVIDER_ROLE = keccak256("CARE_PROVIDER");
    bytes32 public constant APPROVED_MEMBER_ROLE = keccak256("APPROVED_MEMBER");
    bytes32 public constant ACTIVE_MEMBER_ROLE = keccak256("ACTIVE_MEMBER");
    mapping(address => bool) memberAutoRenew;
    mapping(address => uint256) memberDisbursements;

    constructor(uint256 _price, uint256 _memberMax) public {
        memberMaxCount = _memberMax;
        price = _price;
        owner = msg.sender;
        _setupRole(CONTRACT_OWNER_ROLE, msg.sender);
        _setRoleAdmin(CARE_PROVIDER_ROLE, CONTRACT_OWNER_ROLE);
        _setRoleAdmin(APPROVED_MEMBER_ROLE, CONTRACT_OWNER_ROLE);
    }
    function ApproveMember(address memberAddress) public {
        grantRole(APPROVED_MEMBER_ROLE, memberAddress);
    }
    function ApproveHealthcareProvider(address providerAddress) public {
        grantRole(CARE_PROVIDER_ROLE, providerAddress);
    }
    function ViewMemberDisbursements(address memberAddress) public view returns (uint)
    {
        return memberDisbursements[memberAddress];
    }
    function RequestDisbursement(address memberAddress, bytes32 procedure, uint256 amount)
    {
        // Step 1: Check member balance
        // Step 2: Increase member disbursements
        memberDisbursements[memberAddress].add(amount);
        // Step 3: pay the healthcare provider
    }    
}