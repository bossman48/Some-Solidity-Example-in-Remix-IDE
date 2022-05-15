
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract MyContract{

    string value;
    string  public value2;

    enum State {Waiting,Ready,Active}
    State public state;

    struct Person {
        uint id;
        string firstName;
        string lastName;
    }

    Person[] public people;

    //you can understand mapping from this url: https://www.devtwins.com/blog/understanding-mapping-vs-array-in-solidity
    mapping(uint => Person) public people2;
    uint public people2Count=0;

    constructor() {
        value = "My Value";
        value2 = "osman";
        state=State.Waiting;
        owner=msg.sender;
        wallet=payable(msg.sender);
        openningTime=block.timestamp;
    }

    /*constructor(address payable walletAddress) public {
        wallet=walletAddress;
    }*/

    address owner;
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    uint256 openningTime;

    modifier onlyOpenTime(){
        require(block.timestamp >= openningTime+30);
        _;
    }

    

    function get() public view returns(string memory){
        return value;
    }

    function set(string memory valueString ) public {
        value=valueString;
    }

    function setReadyState() public {
        state=State.Ready;
    }

    //TO DO do not return something
    //to array
    function addPerson(string memory firstName, string memory lastName) public returns(uint){
        people.push(Person(people.length,firstName,lastName));
        return people.length-1;
    }
    

    //TO DO do not return something
    //to mapping
    function addPerson2(string memory firstName, string memory lastName) public onlyOwner {
        people2[people2Count]= Person(people2Count, firstName, lastName);
        addCounter();
        //people2Count+=1;
        //return people2Count;
    }

    function addPerson3(string memory firstName, string memory lastName) public returns(uint) {
        people2[people2Count]= Person(people2Count, firstName, lastName);
        addCounter();
        //people2Count+=1;
        return people2Count;
    }

    function addPerson4(string memory firstName, string memory lastName) public onlyOpenTime {
        people2[people2Count]= Person(people2Count, firstName, lastName);
        addCounter();
        //people2Count+=1;
    }

    function isStateReady() public view returns(bool){

        if(state==State.Ready){
            return true;
        }
        else{
            return false;
        }
    }

    function addCounter() internal{
        people2Count+=1;
    }



    mapping(address => uint) public balances;
    address payable wallet;

    event Purchase(
        address indexed buyer,
        uint256 amount
    );

    function buyToken() public payable {
        // buy token 
        balances[msg.sender]+=1;
        //send ether to coin's owner 
        //change the value in the deployment panel
        wallet.transfer(msg.value);
        emit Purchase(msg.sender,1);
    }

    fallback() external payable{
        buyToken();
    }

    
}