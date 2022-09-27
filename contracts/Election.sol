pragma solidity >=0.4.22 <0.8.0;

contract Election{

    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    mapping(address => bool) public voters;
    mapping(uint => Candidate) public candidates;

    uint public candidatesCount;

    event votedEvent(string mine,uint indexed _candidateId);

    constructor () public {
        addCandidate("Narendra Modi");
        addCandidate("Manmohan Singh");
    }

    function addCandidate(string memory _name) public{
        ++candidatesCount;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId) public{
        //require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted 
        voters[msg.sender] = true;

        // Update candidate vote count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent("voted right now", _candidateId);
    }

    function winner() public view returns(string memory){
        for(uint i=1; i<=candidatesCount; i++){
            if(candidates[i].voteCount >= 3){
                return candidates[i].name;
            }
        }
        return "No one is winner";
    }
}