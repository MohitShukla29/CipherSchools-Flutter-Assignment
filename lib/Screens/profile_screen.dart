import 'package:cipherschool_expense_tracking_app/Screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Navigate to login screen and remove all previous routes
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignUpScreen()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Handle any logout errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: ${e.toString()}')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // Creates a notch for the FAB
        notchMargin: 8.0, // Space around FAB
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, color: Colors.grey, size: 28),
                Text("Home", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sync_alt, color: Colors.grey, size: 28),
                Text("Transaction", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            SizedBox(width: 40), // Space for FAB
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.pie_chart, color: Colors.grey, size: 28),
                Text("Budget", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person, color: Color(0xFF7E3FF2), size: 28),
                Text("Profile", style: TextStyle(color: Color(0xFF7E3FF2), fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 65.0),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color(0xFF7E3FF2),
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(3), // Adjust the border thickness
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF7E3FF2),
                        width: 2, // Border width
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                  ),

                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username", style: TextStyle(color: Colors.grey, fontSize: 14)),
                      SizedBox(height: 4),
                      Text("Khushi Sharma", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.mode_edit_outlined, size: 30,),
                ],
              ),
              SizedBox(height: 30),
              buildProfileOption(icon: Icons.wallet, text: "Account", color: Color(0xFF7E3FF2)),
              buildProfileOption(icon: Icons.settings, text: "Settings", color: Color(0xFF7E3FF2)),
              buildProfileOption(icon: Icons.upload, text: "Export Data", color: Color(0xFF7E3FF2)),
              GestureDetector(
                onTap: () => _signOut(context),
                child: buildProfileOption(
                    icon: Icons.logout,
                    text: "Logout",
                    color: Colors.red
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileOption({required IconData icon, required String text, required Color color}) {
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          SizedBox(width: 15),
          Text(text, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
