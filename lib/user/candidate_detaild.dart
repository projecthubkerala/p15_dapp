// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes_app/blockchain_services.dart';
import 'package:provider/provider.dart';

class CandidateDetails extends StatefulWidget {
  const CandidateDetails({Key? key}) : super(key: key);

  @override
  State<CandidateDetails> createState() => _CandidateDetailsState();
}

class _CandidateDetailsState extends State<CandidateDetails> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notesServices = context.watch<BlockchainServices>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home
      : Scaffold(
        appBar: AppBar(
          title: const Text('Candidate Details'),
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context , int){
          return ListTile(
            title: Text('Name : Suresh Kumar ${int+1}'),
            subtitle: int == 2 ? Text('LNF'): Text('UNF'),
            // trailing: IconButton(
            //   icon: const Icon(
            //     Icons.delete,
            //     color: Colors.red,
            //   ),
            //   onPressed: () {
            //     notesServices.deleteNote(notesServices.votes[int].id);
            //   },
            // ),
          );
        
        })
   
      ),
    );
  }
}
