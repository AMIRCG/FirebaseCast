// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Read in Firebase has tow types => 1- One-time Read 2-provided by realtime updates
class ContactsPage extends StatelessWidget {
  final String? documentId;

  ContactsPage({Key? key, this.documentId}) : super(key: key);
  CollectionReference contact =
      FirebaseFirestore.instance.collection("contact"); //note 1

  String? name;
  String? phone;
  @override
  Widget build(BuildContext context) {
    // note 2 => <DocumentSnapshot> and AsyncSnapshot<DocumentSnapshot>
    return FutureBuilder<DocumentSnapshot>(
        future: contact.doc(documentId).get(), // note 3
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
          //note 4 => snapshot.hasData && !snapshot.data!.exists
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(
              child: Text("Document does not exist"),
            );
          }
          //note 5 =>  snapshot.connectionState == ConnectionState.done
          if (snapshot.connectionState == ConnectionState.done) {
            //note 6
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Scaffold(
              appBar: AppBar(),
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Name: ${data['name']} Phone: ${data['phone']}"),
                  ],
                ),
              )),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
