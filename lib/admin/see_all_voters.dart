// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class VotersList extends StatefulWidget {
  final bool isAdmin;
  const VotersList({Key? key , required this.isAdmin}) : super(key: key);

  @override
  State<VotersList> createState() => _VotersListState();
}

class _VotersListState extends State<VotersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Voters List '),
        ),
        body: ListView(
          children:  [
            User(isAdmin: widget.isAdmin,),
            User(isAdmin: widget.isAdmin,),
            User(isAdmin: widget.isAdmin,),
            User(isAdmin: widget.isAdmin,),
        
          ],
        ));
  }
}

class User extends StatelessWidget {
  final bool isAdmin;
  const User({
    super.key,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: const Text('Name: Rahul'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Age : 20'),
            Text('Address : 123, abc street, xyz city'),
            Text('Phone : 1234567890'),
            Text('Adhar : 1234567890'),
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
      ),
    );
  }
}
