import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersPage extends StatefulWidget {
  const FiltersPage( this.currentFilters, this.saveFilters, {Key? key}) : super(key: key);

  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  // Widget _buildSwitchListTile(
  //   String title,
  //   String description,
  //   bool currentValue,
  //   Function(bool)? updateValue,
  // ) {
  //   return SwitchListTile(
  //     title: Text(title),
  //     value: _glutenFree,
  //     subtitle: Text(description),
  //     onChanged: updateValue,
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters!'),
          actions: [
            IconButton(
              onPressed: () {
                final selectFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectFilters);
              },
              icon: const Icon(Icons.save),
              tooltip: 'Save',
            ),
          ],
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Adjust your meals here.',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  // _buildSwitchListTile(
                  //   'Gluten-Free',
                  //   'Only include gluten-free meal',
                  //   _glutenFree,
                  //   (bool newValue) {
                  //     setState(() {
                  //       _glutenFree = newValue;
                  //     });
                  //   },
                  // ),
                  SwitchListTile(
                      title: const Text("Glutten Free"),
                      subtitle: const Text("Only include gluten free meals."),
                      value: _glutenFree,
                      onChanged: (newValue) {
                        setState(() {
                          _glutenFree = newValue;
                        });
                      }),
                  SwitchListTile(
                      title: const Text("Lactose Free"),
                      subtitle: const Text("Only include lactose free meals."),
                      value: _lactoseFree,
                      onChanged: (newValue) {
                        setState(() {
                          _lactoseFree = newValue;
                        });
                      }),
                  SwitchListTile(
                      title: const Text("Vegetarian"),
                      subtitle: const Text("Only include vegetarian meals."),
                      value: _vegetarian,
                      onChanged: (newValue) {
                        setState(() {
                          _vegetarian = newValue;
                        });
                      }),
                  SwitchListTile(
                      title: const Text("Vegan"),
                      subtitle: const Text("Only include Vegan meals."),
                      value: _vegan,
                      onChanged: (newValue) {
                        setState(() {
                          _vegan = newValue;
                        });
                      }),
                ],
              ),
            )
          ],
        ));
  }
}
