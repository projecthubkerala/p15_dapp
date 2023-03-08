// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes_app/blockchain_services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Voter'),
      ),
      body: notesServices.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                itemCount: notesServices.votes.length,
                itemBuilder: (context, index) {
                  return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, int) {
                        return ListTile(
                          title: Text('Name : Suresh Kumar ${int + 1}'),
                          subtitle: int == 2 ? Text('LNF') : Text('UNF'),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              notesServices.deleteNote(notesServices.votes[int].id);
                            },
                          ),
                        );
                      });

                  // ListTile(
                  //   title: Text(notesServices.votes[index].title),
                  //   subtitle: Text(notesServices.votes[index].description),
                  //   trailing: IconButton(
                  //     icon: const Icon(
                  //       Icons.delete,
                  //       color: Colors.red,
                  //     ),
                  //     onPressed: () {
                  //       notesServices.deleteNote(notesServices.votes[index].id);
                  //     },
                  //   ),
                  // );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('New Voter'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      // controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter name',
                      ),
                    ),
                    TextField(
                      // controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Party',
                      ),
                    ),
                    TextField(
                      // controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Enter address',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      notesServices.addNote(
                        titleController.text,
                        descriptionController.text,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
