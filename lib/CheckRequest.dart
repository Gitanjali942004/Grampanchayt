import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckRequest extends StatefulWidget {
  final String selectedRole;

  const CheckRequest({Key? key, required this.selectedRole}) : super(key: key);

  @override
  _CheckRequestState createState() => _CheckRequestState();
}

class _CheckRequestState extends State<CheckRequest> {
  late Future<List<Map<String, dynamic>>> _futureRequests;

  @override
  void initState() {
    super.initState();
    _futureRequests = fetchRequests();
  }

  Future<List<Map<String, dynamic>>> fetchRequests() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('requests').get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  void markCompleted(int index) {
    // Add logic to mark request as completed
  }

  void markPending(int index) {
    // Add logic to mark request as pending
  }

  void viewDetails(Map<String, dynamic> requestData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Request Details'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${requestData['name']}'),
                  Text('Mobile Number: ${requestData['mobile']}'),
                  Text('Adhar Number: ${requestData['adhar']}'),
                  Text('Document Type: ${requestData['documentType']}'),
                  Text('Purpose: ${requestData['purpose']}'),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Add logic for accept
                Navigator.pop(context);
              },
              child: Text('Accept'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic for reject
                Navigator.pop(context);
              },
              child: Text('Reject'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Requests"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> requests = snapshot.data ?? [];
            if (requests.isEmpty) {
              return Center(child: Text('No requests found'));
            }
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      title: Text(requests[index]['name'] ?? ''),
                      subtitle: Text(requests[index]['documentType'] ?? ''),
                      onTap: () => viewDetails(requests[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () => markCompleted(index),
                            child: Text('Completed'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => markPending(index),
                            child: Text('Pending'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}