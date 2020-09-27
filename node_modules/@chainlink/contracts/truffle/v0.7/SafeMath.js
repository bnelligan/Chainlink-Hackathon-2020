'use strict'
Object.defineProperty(exports, '__esModule', { value: true })
const contract = require('@truffle/contract')
const SafeMath = contract({
 "contractName": "SafeMath",
 "abi": [],
 "evm": {
  "bytecode": {
   "linkReferences": {},
   "object": "0x60566023600b82828239805160001a607314601657fe5b30600052607381538281f3fe73000000000000000000000000000000000000000030146080604052600080fdfea26469706673582212206e141d957887d3e09ec3dd878d03c452407098c3aa32a3b70b6d91bc4615c47c64736f6c63430007000033",
   "opcodes": "PUSH1 0x56 PUSH1 0x23 PUSH1 0xB DUP3 DUP3 DUP3 CODECOPY DUP1 MLOAD PUSH1 0x0 BYTE PUSH1 0x73 EQ PUSH1 0x16 JUMPI INVALID JUMPDEST ADDRESS PUSH1 0x0 MSTORE PUSH1 0x73 DUP2 MSTORE8 DUP3 DUP2 RETURN INVALID PUSH20 0x0 ADDRESS EQ PUSH1 0x80 PUSH1 0x40 MSTORE PUSH1 0x0 DUP1 REVERT INVALID LOG2 PUSH5 0x6970667358 0x22 SLT KECCAK256 PUSH15 0x141D957887D3E09EC3DD878D03C452 BLOCKHASH PUSH17 0x98C3AA32A3B70B6D91BC4615C47C64736F PUSH13 0x63430007000033000000000000 ",
   "sourceMap": "589:2774:8:-:0;;;;;;;;;;;;;;;;;;;;;;;;;"
  },
  "deployedBytecode": {
   "immutableReferences": {},
   "linkReferences": {},
   "object": "0x73000000000000000000000000000000000000000030146080604052600080fdfea26469706673582212206e141d957887d3e09ec3dd878d03c452407098c3aa32a3b70b6d91bc4615c47c64736f6c63430007000033",
   "opcodes": "PUSH20 0x0 ADDRESS EQ PUSH1 0x80 PUSH1 0x40 MSTORE PUSH1 0x0 DUP1 REVERT INVALID LOG2 PUSH5 0x6970667358 0x22 SLT KECCAK256 PUSH15 0x141D957887D3E09EC3DD878D03C452 BLOCKHASH PUSH17 0x98C3AA32A3B70B6D91BC4615C47C64736F PUSH13 0x63430007000033000000000000 ",
   "sourceMap": "589:2774:8:-:0;;;;;;;;"
  },
  "methodIdentifiers": {}
 },
 "metadata": "{\"compiler\":{\"version\":\"0.7.0+commit.9e61f92b\"},\"language\":\"Solidity\",\"output\":{\"abi\":[],\"devdoc\":{\"details\":\"Wrappers over Solidity's arithmetic operations with added overflow checks. Arithmetic operations in Solidity wrap on overflow. This can easily result in bugs, because programmers usually assume that an overflow raises an error, which is the standard behavior in high level programming languages. `SafeMath` restores this intuition by reverting the transaction when an operation overflows. Using this library instead of the unchecked operations eliminates an entire class of bugs, so it's recommended to use it always.\",\"kind\":\"dev\",\"methods\":{},\"version\":1},\"userdoc\":{\"kind\":\"user\",\"methods\":{},\"version\":1}},\"settings\":{\"compilationTarget\":{\"/Users/steve/workspace/chainlink/evm-contracts/src/v0.7/vendor/SafeMath.sol\":\"SafeMath\"},\"evmVersion\":\"istanbul\",\"libraries\":{},\"metadata\":{\"bytecodeHash\":\"ipfs\"},\"optimizer\":{\"enabled\":true,\"runs\":1000000},\"remappings\":[]},\"sources\":{\"/Users/steve/workspace/chainlink/evm-contracts/src/v0.7/vendor/SafeMath.sol\":{\"keccak256\":\"0x9fe4afb74faea910cd4f0aecdacaca134e0e367ba7970e45c4212da47dd66b10\",\"urls\":[\"bzz-raw://c3c3e3af0847a2fd45018dd4254f257de7dbdcfb154d01d278431e93e145e465\",\"dweb:/ipfs/QmNoYneZqnJBRbXFignrrwALYEaeou3HNKeLPs2hzC3EKq\"]}},\"version\":1}"
})

if (process.env.NODE_ENV === 'test') {
  try {
    eval('SafeMath.setProvider(web3.currentProvider)')
  } catch (e) {}
}

exports.SafeMath = SafeMath
