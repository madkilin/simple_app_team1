import 'package:flutter/material.dart';
import 'package:simple_app_team1/api_service.dart';

class DetailPage extends StatefulWidget {
  final int userId;

  DetailPage({required this.userId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ApiService _apiService = ApiService();
  Map<String, dynamic> _user = {};

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  void _fetchUser() async {
    try {
      var user = await _apiService.getUserById(widget.userId);
      setState(() {
        _user = user['data'];
      });
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87, // Warna yang serasi dengan tema
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Icon warna putih
          splashColor: Colors.white.withOpacity(0.5), // Warna splash
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: 'Back',
        ),
      ),
      body: _user.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      '${_user['first_name']} ${_user['last_name']}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      _user['email'] ?? 'No email available',
                      style: TextStyle(fontSize: 18),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_user['avatar'] ?? ''),
                      radius: 30,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Details:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ID: ${_user['id']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Job: ${_user['job']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  // Add other details as needed
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
