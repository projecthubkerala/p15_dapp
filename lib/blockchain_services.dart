import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/voter.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

class BlockchainServices extends ChangeNotifier {
  List<Voter> votes = [];
  final String _rpcUrl =
      Platform.isAndroid ? 'http://10.0.2.2:7545' : 'http://127.0.0.1:7545';
  final String _wsUrl =
      Platform.isAndroid ? 'http://10.0.2.2:7545' : 'ws://127.0.0.1:7545';
  bool isLoading = true;

  final String _privatekey =
      '0x29c023Ad2C4d5DBa8F0A84005a6C89BA2E58B66dFC13940845721Fed97E28976';
  late Web3Client _web3cient;
// we use wallnetconnection to connect to the blockchain
// use metamask
  BlockchainServices() {
    init();
  }

  Future<void> init() async {
    _web3cient = Web3Client(
      _rpcUrl,
      http.Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );
    await getABI();
    await getCredentials();
    await getDeployedContract();
  }

  late ContractAbi _abiCode;
  late EthereumAddress _contractAddress;
  Future<void> getABI() async {
    String abiFile =
        await rootBundle.loadString('build/contracts/MetaCoin.json');
    var jsonABI = jsonDecode(abiFile);
    _abiCode =
        ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'NotesContract');
    _contractAddress =
        EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
  }

  late EthPrivateKey _creds;
  Future<void> getCredentials() async {
    _creds = EthPrivateKey.fromHex(_privatekey);
  }

  late DeployedContract _deployedContract;
  late ContractFunction _createNote;
  late ContractFunction _deleteNote;
  late ContractFunction _notes;
  late ContractFunction _noteCount;

  Future<void> getDeployedContract() async {
    _deployedContract = DeployedContract(_abiCode, _contractAddress);
    _createNote = _deployedContract.function('createNote');
    _deleteNote = _deployedContract.function('deleteNote');
    _notes = _deployedContract.function('notes');
    _noteCount = _deployedContract.function('noteCount');
    await fetchNotes();
  }

  Future<void> fetchNotes() async {
//     List totalTaskList = await _web3cient.call(
//       contract: _deployedContract,
//       function: _noteCount,
//       params: [],
//     );
//
//     int totalTaskLen = totalTaskList[0].toInt();
//     votes.clear();
//     for (var i = 0; i < totalTaskLen; i++) {
//       var temp = await _web3cient.call(
//           contract: _deployedContract,
//           function: _notes,
//           params: [BigInt.from(i)]);
//       if (temp[1] != "") {
//         votes.add(
//           Voter(
//             id: (temp[0] as BigInt).toInt(),
//             title: temp[1],
//             description: temp[2],
//           ),
//         );
//       }
//     }
//     isLoading = false;

    notifyListeners();
  }

  Future<void> addNote(String title, String description) async {
    await _web3cient.sendTransaction(
      _creds,
      Transaction.callContract(
        contract: _deployedContract,
        function: _createNote,
        parameters: [title, description],
      ),
    );
    isLoading = true;
    fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await _web3cient.sendTransaction(
      _creds,
      Transaction.callContract(
        contract: _deployedContract,
        function: _deleteNote,
        parameters: [BigInt.from(id)],
      ),
    );
    isLoading = true;
    notifyListeners();
    fetchNotes();
  }
}


Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');

  String contractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Election'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcname);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}

Future<String> startElection(String name, Web3Client ethClient) async {
  var response =
      await callFunction('startElection', [name], ethClient, 'key');
  print('Election started successfully');
  return response;
}

Future<String> addCandidate(String name, Web3Client ethClient) async {
  var response =
      await callFunction('addCandidate', [name], ethClient, 'key');
  print('Candidate added successfully');
  return response;
}

Future<String> authorizeVoter(String address, Web3Client ethClient) async {
  var response = await callFunction('authorizeVoter',
      [EthereumAddress.fromHex(address)], ethClient, 'key');
  print('Voter Authorized successfully');
  return response;
}

Future<List> getCandidatesNum(Web3Client ethClient) async {
  List<dynamic> result = await ask('getNumCandidates', [], ethClient);
  return result;
}

Future<List> getTotalVotes(Web3Client ethClient) async {
  List<dynamic> result = await ask('getTotalVotes', [], ethClient);
  return result;
}

Future<List> candidateInfo(int index, Web3Client ethClient) async {
  List<dynamic> result =
      await ask('candidateInfo', [BigInt.from(index)], ethClient);
  return result;
}

Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result =
      ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<String> vote(int candidateIndex, Web3Client ethClient) async {
  var response = await callFunction(
      "vote", [BigInt.from(candidateIndex)], ethClient, 'key');
  print("Vote counted successfully");
  return response;
}
