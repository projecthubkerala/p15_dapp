//comming soon page

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class VoteNow extends StatefulWidget {
  const VoteNow({super.key});

  @override
  State<VoteNow> createState() => _VoteNowState();
}

class _VoteNowState extends State<VoteNow> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vote Now'),
        ),
        body: StreamBuilder<QuerySnapshot>(
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
                  return Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index]['name']),
                      trailing: BlocUnwanted(
                        candidateId: snapshot.data!.docs[index].id,
                        index: index,
                        snapshot: snapshot,
                      ),
                      // onTap: () {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => VotingBooth(
                      //             CandidateId: snapshot.data!.docs[index].id,
                      //           )));
                      // },
                    ),
                  );
                },
              );
            }));
  }
}

class BlocUnwanted extends StatefulWidget {
  final String candidateId;
  AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  int index;

  BlocUnwanted(
      {super.key,
      required this.candidateId,
      required this.index,
      required this.snapshot});

  @override
  State<BlocUnwanted> createState() => _BlocUnwantedState();
}

class _BlocUnwantedState extends State<BlocUnwanted> {
  bool already_done = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future init() async {
    final collectionInstance = await FirebaseFirestore.instance
        .collection('Elections')
        .doc(widget.snapshot.data!.docs[widget.index].id)
        .collection('candidates')
        .where('votes', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (collectionInstance.docs.isNotEmpty) {
      setState(() {
        already_done = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return already_done
        ? Text("Already Votted")
        : ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VotingBooth(
                        CandidateId:
                            widget.snapshot.data!.docs[widget.index].id,
                      )));
            },
            child: Text("Vote Now"));
  }
}

class VotingBooth extends StatefulWidget {
  final String CandidateId;

  const VotingBooth({required this.CandidateId});

  @override
  State<VotingBooth> createState() => _VotingBoothState();
}

class _VotingBoothState extends State<VotingBooth> {
  int id = 0;
  String CandidateId = "";

  @override
  Widget build(BuildContext context) {
    log(id.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text('Voting Booth'),
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Elections')
                        .doc(widget.CandidateId)
                        .collection('candidates')
                        .snapshots(),
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
                          return Container(
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: id == index ? Colors.blue : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(snapshot.data!.docs[index]['name']),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                setState(() {
                                  id = index;
                                  CandidateId = snapshot.data!.docs[index].id;
                                });
                              },
                            ),
                          );
                        },
                      );
                    })),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                title: Center(child: const Text('Sbmit Vote')),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  setState(() {
                    try {
                      final ref = FirebaseFirestore.instance
                          .collection('Elections')
                          .doc(widget.CandidateId)
                          .collection('candidates')
                          .doc(CandidateId)
                          .set({
                        'votes': FieldValue.arrayUnion(
                            [FirebaseAuth.instance.currentUser!.uid])

                        // 'votes': FieldValue.increment(1),
                      }, SetOptions(merge: true));
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => VoteNow(),
                          ),
                          (route) => false);
                    } on FirebaseAuthException catch (e) {
                      print(e.message);
                    }
                  });
                },
              ),
            ),
          ],
        ));
  }
}
