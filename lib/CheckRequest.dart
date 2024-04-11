import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckRequest extends StatefulWidget {
  final String selectedRole;

  const CheckRequest({Key? key, required this.selectedRole}) : super(key: key);

  @override
  _CheckRequestState createState() => _CheckRequestState();
}

class _CheckRequestState extends State<CheckRequest> {
  List<Map<String, dynamic>> requests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/fetchRequests.php'));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> parsedRequests = List<Map<String, dynamic>>.from(json.decode(response.body));
        setState(() {
          requests = parsedRequests;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load requests: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching requests: $e');
      setState(() {
        isLoading = false;
      });
      // Handle error gracefully, display an error message or retry logic if necessary
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Requests"),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : requests.isEmpty
          ? Center(
        child: Text('No requests found'),
      )
          : ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(requests[index]['name']),
            subtitle: Text(requests[index]['mobile']),
            // Add more fields as needed
          );
        },
      ),
    );
  }
}
