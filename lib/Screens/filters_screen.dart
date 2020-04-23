import 'package:flutter/material.dart';
import 'package:meals_app/Widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const route = '/filters';
  final Function saveFilters;
  final Map<String, Object> currentFilters;
  FiltersScreen({@required this.saveFilters, @required this.currentFilters});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegeterian = false;
  var _islactoseFree = false;
  
  @override
  initState() {
     _isGlutenFree = widget.currentFilters['gluten'];
     _isVegan = widget.currentFilters['vegan'];
     _isVegeterian = widget.currentFilters['vegeterian'];
     _islactoseFree = widget.currentFilters['lactose'];
     super.initState();
  }

  Widget _buildSwitchListTile(String title, String descrpition,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(descrpition),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            color: Colors.white,
            onPressed: () {
              final _selectedFilters = {
                'gluten': _isGlutenFree,
                'lactose': _islactoseFree,
                'vegan': _isVegan,
                'vegeterian': _isVegeterian,
              };
              widget.saveFilters(_selectedFilters);
            },
          ),
        ],
        title: Text('Filters'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Filters',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Container(
            child: Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile('Gluten free',
                      'Only show gluten free meals', _isGlutenFree, (newValue) {
                    setState(() {
                      _isGlutenFree = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegeterian', 'Only show Vegeterian meals', _isVegeterian,
                      (newValue) {
                    setState(() {
                      _isVegeterian = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegan', 'Only show Vegan meals', _isVegan, (newValue) {
                    setState(() {
                      _isVegan = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Lactose free',
                      'Only show Lactose free meals',
                      _islactoseFree, (newValue) {
                    setState(() {
                      _islactoseFree = newValue;
                    });
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
