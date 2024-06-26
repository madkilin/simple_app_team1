import 'package:flutter/material.dart';
import 'package:simple_app_team1/add_user.dart';
import 'package:simple_app_team1/api_service.dart';
import 'package:simple_app_team1/detail.dart';

class DirectoryPage extends StatefulWidget {
  @override
  _DirectoryPageState createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  ApiService _apiService = ApiService();
  List<dynamic> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    try {
      var users = await _apiService.getUsers();
      setState(() {
        _users = users;
      });
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  void _addNewUser(Map<String, dynamic> newUser) {
    setState(() {
      _users.add(newUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Directory User', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87, // Warna yang serasi dengan tema
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          var user = _users[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(
                '${user['first_name']} ${user['last_name']}',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                user['email'] ?? 'No email available',
                style: TextStyle(fontSize: 16),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user['avatar'] ?? ''),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailPage(userId: int.parse(user['id'].toString())),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newUser = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserPage()),
          );

          if (newUser != null) {
            _addNewUser(newUser);
          }
        },
        backgroundColor: Colors.black87,
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Add User',
      ),
    );
  }
}
