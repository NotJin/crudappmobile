import 'package:crudappmobile/search.dart';
import 'package:crudappmobile/user_page.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'firebase_options.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
  int _curentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
            body: IndexedStack(
              index: _curentIndex,
              children:[
                const HomePage(),
                SearchPage(),
                UserPage(),
                DetailPage(),
              ],
            ),
            bottomNavigationBar: SalomonBottomBar(
                currentIndex: _curentIndex,
                onTap: (index){
                  setState(() {
                    _curentIndex = index;
                  });
                },
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                items: [
                  SalomonBottomBarItem(icon: const Icon(Icons.home), title: const Text("Home")),
                  SalomonBottomBarItem(icon: const Icon(Icons.search), title: const Text("Search")),
                  SalomonBottomBarItem(icon: const Icon(Icons.badge), title: const Text("Search")),
                  SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text("User")),
                ]
            ),
          )
      ),
    );
  }
}
