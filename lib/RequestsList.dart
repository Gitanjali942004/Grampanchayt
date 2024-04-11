import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(RequestsList());
}
class RequestsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('requests').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var document = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(document['name']),
                  subtitle: Text(document['documentType']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Mark as completed
                        },
                        child: Text('Completed'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Mark as pending
                        },
                        child: Text('Pending'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: Text('No requests found'));
        },
      ),
    );
  }
}
