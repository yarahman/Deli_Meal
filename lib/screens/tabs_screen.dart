import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import './category_screen.dart';
import './favourite_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'TabsScreen';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> Screens = [
    {'screen': CategoryScreen(), 'title': 'Categories'},
    {'screen': FavouriteScreen(), 'title': 'Favourite'},
  ];
  int selectedPageIndex = 0;

  void _selectTab(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Screens[selectedPageIndex]['title'].toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      drawer: const MainDrawer(),
      body: Screens[selectedPageIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        backgroundColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outlined), label: 'Favorite'),
        ],
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: selectedPageIndex,
      ),
    );
  }
}
