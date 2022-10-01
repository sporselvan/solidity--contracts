# solidity--contracts
Exploring various smartcontracts and web3 technology.

1. Simple ethereum stacking smart contract.
2. zk rollup validation smart contract.

        2.1 Introduction
                zk-rollup is ethereum scaling solution. This has several procedures to complete verification.  
        2.2 steps to verify transactions
                1. Getting transactions that needs to be verified on L1.
                2. Generating validity proofs and leafs and merkle root.
                3. verifying transactions with proofs.
                4. maintaining block snapshot as logs in L1 after verifying transactions and updating merkle proof.
        2.3 Implementation.
                1. take the transaction from l2 that needs to be verified.
                2. This transactions will sent to the Arithmetic Circuit that produce leafs ,validity proofs and merkle root.
                3. now we have enough data for validating transaction , smart contract needs to be deploy on L1.
          2.3.1 smart contract flow:
                1. for every batch of transactions last block count included in smart contract.
                2. checking new batch of transaction blocks are greater than previous.
                3. passing validity proof,leaf and merkle root for verifying transactions.
                4. after verifying transactions updating snapshot of L2 blocks and merkle root on chain L1 as logs.
                5. so that every verified transaction has merkle root and block count.
          
        
