// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/cryptography/MerkleProof.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";

contract ZKVerify {
        
        bytes32 public root;   //last updated merkle root.
        uint256 public currentBlock; //last block that got verified in last batch

        event rootCommit(bytes32 newRoot); //event for log merkle root
        event blockCommit(uint256 block);  // event for maintain verified block logs


        using Counters for Counters.Counter;
        Counters.Counter public _verifiedBatch;

        constructor(bytes32 _root){
            root = _root;
        }
        
        //we pass proof,leaf and merkle root for verifying transactions.
        //This function returns true if that transaction proof is valid.
        function isValid(bytes32[] memory proof, bytes32 leaf,bytes32 verifyRoot)external pure returns(bool) {
           require(MerkleProof.verify(proof, verifyRoot, leaf),"Not valid transaction");
           return MerkleProof.verify(proof, verifyRoot, leaf);
        }
        
        //after validating transactions updating new merkle root and blocks.

        function updateRoot(bytes32 newRoot,uint256 newBlock)external returns(bool){
             require(currentBlock < newBlock,"new block should be greater than previous block");
             root = newRoot;
             _verifiedBatch.increment();
             emit rootCommit(newRoot);
             for(uint i=(currentBlock+1);i<=newBlock;i++){
                  emit blockCommit(i);
             }
             return updatePreblock(newBlock);
        }
        
        //for updating last block of every batch for validating new batch.
        function updatePreblock(uint blockValue)public returns(bool){
            currentBlock = blockValue;
            return true;
        }

} 
