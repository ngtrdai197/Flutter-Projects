import 'package:deli_meals/screens/categories_screen.dart';
import 'package:deli_meals/screens/favorite_screen.dart';
import 'package:deli_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _screens = [
    {'screen': CategoriesScreen(), 'title': 'Categories'},
    {'screen': FavoriteScreen(), 'title': 'Favorite'}
  ];
  int _selectedScreenIndex = 0;

  void _selectedScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_screens[_selectedScreenIndex]['title'] as String),
          ),
          drawer: MainDrawer(),
          body: _screens[_selectedScreenIndex]['screen'] as Widget,
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectedScreen,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.white,
            selectedItemColor: Theme.of(context).accentColor,
            currentIndex: _selectedScreenIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              )
            ],
          ),
        ));
  }
}
