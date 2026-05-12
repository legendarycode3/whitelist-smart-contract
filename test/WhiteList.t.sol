// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


import {Test} from "forge-std/Test.sol";
import {WhiteList} from "../src/WhiteList.sol";

contract WhitelistTesct is Test {

    /** State Variables */
    WhiteList whitelist;

    // created a address to stimulate a person with an address
    address public USER = makeAddr("addr");


    /** Functions */
    function setUp() public {
        whitelist = new WhiteList();
    }
    

    function testAddAddress() public {
        // No vm.prank needed here because 'this' (the test contract - i_owner) is the owner. Becus on the main contract (the contructor , the i_owner is set defaultly as the owner of the contract)
        
            // ACT
        whitelist.addAddress(USER);

            // ASSERT
        assertEq(whitelist.isWhiteListed(USER) , true, "User was not added to whitelist");
        
    }
    

}



// function testIfAddressIsAdded() public {
    //     vm.prank(ADDR); 
        
    //     whitelist.addAddress(ADDR);

    //     vm.prank(ADDR);
    //     uint256 balance = simplebank.checkBalance();
    //     assertEq(balance, minEthAmount);
    //     // assertEq(left, right);
    //     // assert(condition);
    // }




