import 'package:deli_meals/main.dart';
import 'package:deli_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  final Function saveFilters;
  final FilterItem currentFilters;

  FiltersScreen({required this.saveFilters, required this.currentFilters});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters.gluten;
    _lactoseFree = widget.currentFilters.lactose;
    _vegetarian = widget.currentFilters.vegetarian;
    _vegan = widget.currentFilters.vegan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: [
            IconButton(
                onPressed: () {
                  final FilterItem selectedFilters = FilterItem(
                      gluten: _glutenFree,
                      lactose: _lactoseFree,
                      vegetarian: _vegetarian,
                      vegan: _vegan);
                  widget.saveFilters(selectedFilters);
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(children: <Widget>[
            _buildSwitchListTile(
              'Gluten-free',
              'Only include gluten-free meals.',
              _glutenFree,
              (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              },
            ),
            _buildSwitchListTile(
              'Lactose-free',
              'Only include lactose-free meals.',
              _lactoseFree,
              (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              },
            ),
            _buildSwitchListTile(
              'Vegetarian',
              'Only include vegetarian meals.',
              _vegetarian,
              (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              },
            ),
            _buildSwitchListTile(
              'Vegan',
              'Only include vegan meals.',
              _vegan,
              (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              },
            ),
          ])),
        ]));
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }
}
