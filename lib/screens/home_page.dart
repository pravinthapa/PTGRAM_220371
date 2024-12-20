import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prabin/onboarding/fifth_page.dart';
import 'package:prabin/onboarding/first_page.dart';
import 'package:prabin/onboarding/fourth_page.dart';
import 'package:prabin/onboarding/second_page.dart';
import 'package:prabin/onboarding/third_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int _selectedIndex = 0;

final List _pages = [
  FirstPage(),
  SecondPage(),
  ThirdPage(),
  FourthPage(),
  FifthPage(),

  // Container(
  //   color: Colors.red,
  // ),
  // Container(
  //   color: Colors.blue,
  // ),
  // Container(
  //   color: Colors.green,
  // ),
  // Container(
  //   color: Colors.purple,
  // ),
  // Container(
  //   color: Colors.yellow,
  // ),
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 0
                  ? 'assets/vectors/home-bold.svg'
                  : 'assets/vectors/home-outline.svg'),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 1
                  ? 'assets/vectors/search-bold.svg'
                  : 'assets/vectors/search-outline.svg'),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 2
                  ? 'assets/vectors/add-square-bold.svg'
                  : 'assets/vectors/add-square-outline.svg'),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 3
                  ? 'assets/vectors/video-play-bold.svg'
                  : 'assets/vectors/video-play-outline.svg'),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/vectors/person.png')),
                    shape: BoxShape.circle),
              ),
              label: ''),
        ],
      ),
    );
  }

  // return const Scaffold(
  //   body: Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Center(child: Text("hello world")),
  //     ],
  //   ),
  // );
}
