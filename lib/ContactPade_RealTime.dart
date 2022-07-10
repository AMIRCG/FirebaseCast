// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactPage_Realtime extends StatefulWidget {
  const ContactPage_Realtime({Key? key}) : super(key: key);

  @override
  State<ContactPage_Realtime> createState() => _ContactPage_RealtimeState();
}

class _ContactPage_RealtimeState extends State<ContactPage_Realtime> {
  // note 1
  Stream collectionStream =
      FirebaseFirestore.instance.collection('contact').snapshots();
  Stream documentStream =
      FirebaseFirestore.instance.collection('contact').doc('mom').snapshots();
  //note 2
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('contact').snapshots();

  @override
  //note 3 => StreamBuilder and QuerySnapshot and AsyncSnapshot<QuerySnapshot>
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        //note => waiting
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        //note
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['phone']),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
