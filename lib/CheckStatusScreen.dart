import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckStatusScreen extends StatelessWidget {
  final String aadharNo;

  const CheckStatusScreen({Key? key, required this.aadharNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Status'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .where('username', isEqualTo: aadharNo) // Fetch data based on username field
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No requests found.'),
            );
          }
          return ListView(
            padding: EdgeInsets.all(16.0),
            children: snapshot.data!.docs.map((doc) {
              final requestData = doc.data() as Map<String, dynamic>;
              final name = requestData['name'];
              final documentType = requestData['documentType'];
              final purpose = requestData['purpose'];
              final status = requestData['status'];
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: $name'),
                      Text('Document Type: $documentType'),
                      Text('Purpose: $purpose'),
                      Text('Status: $status', style: TextStyle(fontWeight: FontWeight.bold, color: status == 'pending' ? Colors.red : Colors.green)),
                    ],
                  ),
                  onTap: () {
                    // Handle onTap if needed
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
