pragma solidity ^0.8.0;

contract Twetter {

    address owner;
    uint256 MAX_TWEET_LENGTH = 280;

    struct Tweet {
        uint256 id;
        string content;
        string author;
        uint256 timestamp;
        uint256 likes;
    }

    constructor(){
        owner = msg.sender;
        _;
    }

    event TweetCreated(address indexed author, uint256 id, string content, uint256 timestamp);
    event TweetLiked(address indexed likedUser, uint256 tweetId, string Tweetcontent);
    event TweetDisliked(address indexed unlikedUser, uint256 tweetId, string Tweetcontent);

    modifier onlyOWner() {
        require(msg.sender == owner,"ONLY SMART CONTRACT OWNER CAN PERFORM THIS ACTION");
    }


    mapping(address => Tweet[]) public tweets;


    function changeTweetLength(uint256 _newLength) public view  onlyOwner{
        MAX_TWEET_LENGTH = _newLength;
    }

    function createTweet(string _content) external {
        require(bytes(_content).length <= MAX_TWEET_LENGTH, "TWEETS CAN'T EXCEED 280 CHARCTER");

        Tweet newTweet = Tweet({
            id: tweets[msg.sender],
            content: _content,
            author:msg.sender,
            timestamp:block.timestamp,
            likes:0
        })

        tweets[msg.sender].push(newTweet);

        emit TweetCreated

    }


    function getAllTweets() external returns(Tweet[]){
        return tweets[msg.sender];
    } 


    function getSingleTweet(address _author,uint256 id) external returns(Tweet){
        require(tweets[_author][id].id == id,"TWEET DOESN'T EXISTS);
        return tweets[_author][id];
    }

    function likeTweet(address _author,uint256 id) external{
        require(tweets[_author][id].id == id,"TWEET DOESN'T EXISTS);
        tweets[_author][id].likes++;
    }

    function unlikeTweet(address _author,uint256 id) external{
        require(tweets[_author][id].id == id,"TWEET DOESN'T EXISTS);
        require(tweets[_author][id].likes > 0,"TWEET LIKES CAN'T GO BELOW 0);
        tweets[_author][id].likes--;
    }

}