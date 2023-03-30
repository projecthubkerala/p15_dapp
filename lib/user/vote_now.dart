//comming soon page

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class VoteNow extends StatelessWidget {
  const VoteNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vote Now'),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Election 1'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => VotingBooth()));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Election 2'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => VotingBooth()));
                },
              ),
            ),
          ],
        ));
  }
}

class VotingBooth extends StatefulWidget {
  const VotingBooth({super.key});

  @override
  State<VotingBooth> createState() => _VotingBoothState();
}

class _VotingBoothState extends State<VotingBooth> {
  int id = 0;
  @override
  Widget build(BuildContext context) {
    log(id.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text('Voting Booth'),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: id == 1 ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Name of Candidate 1'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  setState(() {
                    id = 1;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: id == 2 ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Name of Candidate 2'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  setState(() {
                    id = 2;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: id == 3 ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Name of Candidate 3'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  setState(() {
                    id = 3;
                  });
                },
              ),
            ),
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
                    id = 3;
                  });
                },
              ),
            ),
          ],
        ));
  }
}
