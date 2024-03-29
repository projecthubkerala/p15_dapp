import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notes_app/admin/result.dart';
import 'package:notes_app/admin/see_all_voters.dart';
import 'package:notes_app/user/candidate.dart';


import 'package:notes_app/user/vote_now.dart';

class UserHomaPage extends StatelessWidget {
  const UserHomaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2CC66D),
          title: const Text(
            "Home page",
            style: TextStyle(color: Colors.white),
          ),
        ),
        // show card?
        body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(20.0),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const VoteNow()));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 5)
                    ]),
                height: 20,
                // color: Colors.red,
                child: Center(child: Text('Vote now')),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Result(isAdmin: false,)));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 5)
                    ]),
                height: 20,
                // color: Colors.red,
                child: Center(child: Text('Result')),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CommingSoon()));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 5)
                    ]),
                height: 20,
                // color: Colors.red,
                child: Center(child: Text('See Condidate details')),
              ),
            ),
          ],
        ));
  }
}
