// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

/**
 * @title  WhiteList Smart Contract
 * @author LegendaryCode
 * @notice A whitelist smart contract allows restricted access to specific functions by validating whether a caller's address exists within a designated, approved list. 
 */




contract WhiteList {
   
        /** STATE VARIABLES */
    /// @notice The address of the contract owner / address owner.
    address public immutable i_owner;

    // @notice Maps addresses to their whitelist status (true = allowed)
    mapping (address => bool) s_whitelistedAddress;


        /** EVENTS */
    /// @notice Emitted when an account is added to the whitelist.  Used events to ensure transparency in who has been added or removed from the whitelist.
    /// @param account The address of the user/contract being whitelisted
    event AddedWhitelist(address indexed account);

    /// @notice  Emitted when an address is removed from the system/whitelist.
    /// @param account The address that was removed.
    event RemoveAddress(address indexed account);



        /** ERRORS (CUSTOM ERROR) */
    error WhiteList__NotOwner();
    error Already__Whitelisted(address whitelistedAddress);
    error Not__Whitelisted();
    error Removed__Whitelisted(address removedwhitelistedAddress);



        /** MODIFIERS */
    /// @notice Ensures that only authorized addresses can call the function it will be implemented on.
    modifier onlyWhitelisted() {
        //require(s_whitelistedAddress[msg.sender], "Not WhiteListed");
        if (!s_whitelistedAddress[msg.sender]) {
            revert Not__Whitelisted();
        }
        _;
    }

    modifier onlyOwner() {
        if(msg.sender != i_owner ){
            revert WhiteList__NotOwner();
        }
        _;
    }


        /** FUNCTIONS */
    /// @notice The Constructor , sets the contract deployer as the initial owner.
    constructor () {
        i_owner = msg.sender;
    }


    function addAddress(address _addr) public onlyOwner {
        // CHECKS
        if(s_whitelistedAddress[_addr]){
            revert Already__Whitelisted(_addr);
        }
        
        // EFFECTS
        s_whitelistedAddress[_addr] = true;
        emit AddedWhitelist(_addr);
    }

    function removeAddress(address _addr) public onlyOwner {
        // CHECKS
        if(!s_whitelistedAddress[_addr]){
            revert Removed__Whitelisted(_addr);
        }

        // EFFECTS
        s_whitelistedAddress[_addr] = false;
        emit RemoveAddress(_addr);
    }

   
        /**
     * @notice Checks if a given address is whitelisted.
     * @param _addr The address to verify.
     * @return bool True if the address is whitelisted, false otherwise.
     */
     function isWhiteListed(address _addr) public  view returns(bool)  {
       return s_whitelistedAddress[_addr];
    }

}


























