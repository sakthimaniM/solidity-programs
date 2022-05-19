Pragma solidity ^0.5.0;
contract simpleStorage {
   event storageSet(string _message);
   uint public storeData;
   function set(uint x) public {
      storeData = x;
      emit storageSet("Data stored successfully");
    }
}
