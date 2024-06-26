import 'package:flutter/material.dart';
import 'package:simple_app_team1/api_service.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  ApiService _apiService = ApiService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _jobController = TextEditingController();

  void _addUser() async {
    String name = _nameController.text.trim();
    String job = _jobController.text.trim();
    try {
      var newUser = await _apiService.addUser(name, job);
      // Return to the previous screen with the new user data
      Navigator.pop(context, {
        'id': newUser['id'], // Pastikan id sebagai integer
        'first_name': name.split(' ')[0],
        'last_name': name.split(' ').length > 1 ? name.split(' ')[1] : '',
        'email': '', // Dummy email as it's not provided by the API
        'avatar': '', // Dummy avatar as it's not provided by the API
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
        title: Text('Add User', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Icon warna putih
          splashColor: Colors.white.withOpacity(0.5), // Warna splash
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: 'Back',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _jobController,
              decoration: InputDecoration(
                labelText: 'Job',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Add User', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.black87, // Warna yang serasi dengan tema
              ),
            ),
          ],
        ),
      ),
    );
  }
}
