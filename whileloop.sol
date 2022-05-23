pragma solidity ^0.5.0;
contract Types {
	uint[] data;
	uint8 j = 0;
	function loop(
	) public returns(uint[] memory){
	while(j < 5) {
		j++;
		data.push(j);
	}
	return data;
	}
}
