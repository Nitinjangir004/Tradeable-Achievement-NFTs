// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AchievementNFT {
    mapping(uint256 => address) public ownerOf;
    mapping(address => uint256) public balanceOf;
    mapping(uint256 => address) public approvals;
    
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    uint256 private nextTokenId;

    function mint() external {
        uint256 tokenId = nextTokenId;
        nextTokenId++;
        
        ownerOf[tokenId] = msg.sender;
        balanceOf[msg.sender]++;

        emit Transfer(address(0), msg.sender, tokenId);
    }

    function approve(address to, uint256 tokenId) external {
        require(ownerOf[tokenId] == msg.sender, "Not the owner");
        approvals[tokenId] = to;
        emit Approval(msg.sender, to, tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) external {
        require(ownerOf[tokenId] == from, "Not the owner");
        require(msg.sender == from || approvals[tokenId] == msg.sender, "Not approved");
        
        balanceOf[from]--;
        balanceOf[to]++;
        ownerOf[tokenId] = to;

        delete approvals[tokenId];
        emit Transfer(from, to, tokenId);
    }
}
