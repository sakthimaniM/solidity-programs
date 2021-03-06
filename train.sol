// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract traindelaypenaulty{
    //string irctcAddress="0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB";
    //uint deployeddate;
    //uint currdate;
    address public manager;
    address payable[] public customerarr;
    uint coachincrement;
// sample data nagercoil express,
// start time 1649644200  - Mon Apr 11 2022 08:00:00 GMT+0530 (India Standard Time)
// end time   1649673000  - Mon Apr 11 2022 16:00:00 GMT+0530 (India Standard Time)
// total hrs   28800        8hrs 8*60*60
// testing delay end time 1649673300 5mnts late
    struct traindetails{
        string Name;
        uint StartTime;
        uint EndTime;
        uint TotalHrs;

    }
    struct customer{
        string Name;
        uint Trainno;
        uint Coach;

    }
    mapping(uint => traindetails) public trainmap;
    mapping(address => customer) public customermap;
    constructor(){
    //deployeddate=now;
        manager=msg.sender;
    }
    modifier notmanager(){
        require(msg.sender !=manager,"manager can not book ticket");
        _;
    }
    modifier onlymanager(){
        require(msg.sender ==manager,"manager can only add train details");
        _;
    }
    function booking(string memory _name,uint _Trainno) external payable notmanager {
         require(msg.value == 1 ether);
         require((msg.sender).balance >= 1 ether);
        coachincrement += 1;
        customermap[msg.sender]=customer(_name,_Trainno,coachincrement);
        payable(manager).transfer(1 ether);
        customerarr.push(payable(msg.sender));
    }
    function getcoach(address _cusAddress) public view returns(uint _coachno){
        return customermap[_cusAddress].Coach;
    }
    // function getallcustomeraddress() public view returns(uint[] memory)
    // {
    //     address[] memory newarray=new address[](customerarr.length);
    //     for(uint i=0;i < customerarr.length;i++)
    //     {
    //         address  tempaddress=address[i];
    //         newarray[i]=ticket[tempaddress].renum;
    //     }
    //     return newarray;
    // }

    //admin access

    function inserttraindetails(
        uint _Trainno,
        string memory _Name,
        uint _start,
        uint _end,uint _thrs
        ) public onlymanager{
        trainmap[_Trainno]=traindetails(_Name,_start,_end,_thrs);
    }
    function trainDelaypayment(
        uint _starttime,
        uint _entime,
        uint _trainno
        ) public payable
        onlymanager {

        uint totalhrsdefined=trainmap[_trainno].TotalHrs;
        
        uint totalrealhrs=_entime-_starttime;
        if(totalrealhrs > totalhrsdefined)
        {
            
            uint delayhrs=totalrealhrs-totalhrsdefined;
            uint mnts =delayhrs / 60;
            require((msg.sender).balance >=(customerarr.length * mnts) * (1 ether),"not enough balance");
            for(uint i=0;i < customerarr.length;i++)
            {
                address payable payaddress=customerarr[i];
                payaddress.transfer(mnts * (1 ether));
                
            }
            
        }            
    }
    function gettest() payable public returns(uint){
        uint amount=5*(1 ether);
        return amount;
    }


    
    function gettrainname(uint _trainno) public view returns(string memory)
    {
        return trainmap[_trainno].Name;
    }
    function gettrainstarttime(uint _trainno) public view returns(uint)
    {
        return trainmap[_trainno].StartTime;
    }
    function gettrainEndTime(uint _trainno) public view returns(uint)
    {
        return trainmap[_trainno].EndTime;
    }
    function gettrainTravelTime(uint _trainno) public view returns(uint)
    {
        return trainmap[_trainno].TotalHrs;
    }

    // receive() payable external notmanager{
    //     require(msg.value == 0.05 ether);
    //     require((msg.sender).balance >=0.05 ether);


    // }



}
