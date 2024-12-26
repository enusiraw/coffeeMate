// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yenebuna/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // Fetch user details
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userName = user.displayName ?? 'No Name';
        userEmail = user.email ?? 'No Email';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu, color: AppColors.backgroundColor),
            );
          },
        ),
        title: Image.asset(
          'Assets/images/logo.png',
          fit: BoxFit.contain,
          height: 50.h,
        ),
        actions: [
          Positioned(
            right: 8.0,
            top: 8.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://img.freepik.com/premium-photo/side-view-woman-holding-hands_1048944-16242081.jpg?t=st=1735202078~exp=1735202678~hmac=5936aa51ed6289efa8d03b9f1fdf4e87823988e2b479a6fd42d6f7b94dfdc86c",
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {},
        ),
      ])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userName.isNotEmpty && userEmail.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Hello, $userName',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: $userEmail',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '', // No label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '', // No label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '', // No label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '', // No label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '', // No label
          ),
        ],
      ),
    );
  }
}
