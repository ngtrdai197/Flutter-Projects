import 'package:deli_meals/constants/routes.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "The Drawer!",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 26.0,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          _buildListTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed(DAINTROUTING.CATEGORIES);
          }),
          _buildListTile('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(DAINTROUTING.FILTERS);
          }),
        ],
      )),
    );
  }

  Widget _buildListTile(
      String title, IconData icon, VoidCallback onTapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24.0,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold),
      ),
      onTap: onTapHandler,
    );
  }
}
