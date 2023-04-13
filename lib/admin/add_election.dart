import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notes_app/blockchain_services.dart';
import 'package:notes_app/helper/firebaseaut.dart';
import 'package:notes_app/helper/firestore.dart';
import 'package:provider/provider.dart';

class AddElection extends StatefulWidget {
  const AddElection({super.key});

  @override
  State<AddElection> createState() => _AddElectionState();
}

class _AddElectionState extends State<AddElection> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime selecteddate = DateTime(2023);

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var notesServices = context.watch<BlockchainServices>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Election'),
      ),
      body: Container(
        height: 500,
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('Elections').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshot.data!.docs[index]['name'],
                    ),
                    subtitle: Text(
                        "Date : ${snapshot.data!.docs[index]['date'].toDate()}"),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  );
                },
              );
            }),
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
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter name Of election',
                      ),
                    ),
                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            // Show a date picker dialog
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );

                            // Update the text field with the selected date
                            if (selectedDate != null) {
                              _dateController.text = selectedDate.toString();
                              setState(() {
                                selecteddate = selectedDate;
                              });
                            }
                          },
                          child: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    // TextField(
                    //   // controller: descriptionController,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Enter address',
                    //   ),
                    // ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      final _helper = FirestoreHelper();
                      await _helper.addElection(
                          name: titleController.text, date: selecteddate);
                      Navigator.of(context).pop();
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
