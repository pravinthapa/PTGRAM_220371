import 'package:flutter/material.dart';
import 'package:ptgram/feature/add_post/ui/page/add_post.dart';
import 'package:ptgram/feature/home/page/ui/home_page.dart';
import 'package:ptgram/feature/proifile/page/profile_index.dart';
import 'package:ptgram/feature/proifile/page/profile_page.dart';
import 'package:ptgram/feature/reals/reals_views.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          Center(child: Text("Search Page")),
          AddPost(),
          ReelsScreen(),
          ProfileIndex(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 0),
            _buildNavItem(Icons.search, 1),
            const SizedBox(width: 40),
            _buildNavItem(Icons.movie, 3),
            _buildNavItem(Icons.person, 4),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(icon,
          color: _selectedIndex == index ? Colors.blue : Colors.grey),
      onPressed: () => _onItemTapped(index),
    );
  }
}
