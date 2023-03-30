// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes_app/blockchain_services.dart';
import 'package:provider/provider.dart';

class Election extends StatefulWidget {
  const Election({Key? key}) : super(key: key);

  @override
  State<Election> createState() => _ElectionState();
}

class _ElectionState extends State<Election> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Voters List'),
        ),
        body: ListView(
          children: const [
            ElectionItem(),
            ElectionItem(),
            ElectionItem(),
            ElectionItem(),
          ],
        ));
  }
}

class ElectionItem extends StatelessWidget {
  const ElectionItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: const Text('Name: Election 1'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Candidates details'),
            Text('1 . Ameen : UFD'),
            Text('2 . Amar :  BPS'),
            Text('3 . Akshay :  LFD'),
            Text('End Date :  12/12/2021'),
          ],
        ),
        trailing: Column(
          children: [
            Expanded(
                child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
