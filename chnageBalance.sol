pragma solidity ^0.5.0;
contract changeBalance{
    uint8 public balance;
    function increase() public {
    balance++;
    }
    function decrease() public {
        balance--;
    }
}
