// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final bool isAdmin;
  const Result({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: ListView(
          children:  [
            ResultItem(isAdmin: isAdmin,),
            ResultItem(isAdmin: isAdmin,),
            ResultItem(isAdmin: isAdmin,),
            ResultItem(isAdmin: isAdmin,),
          ],
        ));
  }
}

class ResultItem extends StatelessWidget {
  final bool isAdmin;
  const ResultItem({
    required this.isAdmin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: const Text('Name: Election 1'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('1st . Ameen : UFD  , 1000 votes'),
            Text('2nd . Amar :  BPS ,  500 votes'),
            Text('3rd . Akshay :  LFD ,  200 votes'),
          ],
        ),
        trailing: Visibility(
          visible: isAdmin,
          child: Column(
            children: [
              Expanded(
                  child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.white,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
