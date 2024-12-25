import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:yenebuna/constants/colors.dart';
import 'package:yenebuna/screens/post.dart';

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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'Assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                  print('Post button clicked');
                },
                child: const Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Coffee Mates Button
              TextButton(
                onPressed: () {
                  print('Coffee Mates button clicked');
                },
                child: const Text(
                  'Coffee Mates',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
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
            else
              const CircularProgressIndicator(), 
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
