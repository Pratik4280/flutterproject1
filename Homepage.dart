import 'package:flutter/material.dart';
import 'package:flygaulf/Model/userProvider.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch user details when the page loads
    Provider.of<UserProvider>(context, listen: false).fetchUserDetails("1");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: Drawer(
        child: user == null
            ? Center(child: CircularProgressIndicator()) // Show loading indicator until user data is fetched
            : ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: user.profilePhoto.isNotEmpty
                        ? CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                        'http://192.168.1.19/fgica/${user.profilePhoto}',
                      ),
                          )
                        : Icon(Icons.person, size: 50),
                  ),
                  ListTile(
                    title: Text(user.userName),
                  ),
                  ListTile(
                    title: Text(user.userEmail),
                  ),
                  ListTile(
                    title: Text(user.position),
                  ),
                ],
              ),
      ),
      body: Center(
        child: user == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:NetworkImage(
                        'http://192.168.1.19/fgica/' + user.profilePhoto,
                      ),
                  ),
                  SizedBox(height: 20),
                  Text(user.userName, style: TextStyle(fontSize: 24)),
                  Text(user.position, style: TextStyle(fontSize: 18)),
                ],
              ),
      ),
    );
  }
}
