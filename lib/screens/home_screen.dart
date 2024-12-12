import 'package:flutter/material.dart';
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
          // title: const Text(
          //   'Home',
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     color: Colors.white,
          //   ),
          // ),
          // centerTitle: true,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate to Post screen or handle Post action
                    Navigator.pushNamed(context, PostPage.id);
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
                    // Navigate to Coffee Mates screen or handle action
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
            )
            // Post Button
          ]),
      body: const Center(
        
        child: Text('Home Screen Content'),
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
