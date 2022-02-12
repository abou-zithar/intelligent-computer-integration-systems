import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../providers/Hardware_provider.dart';
import 'package:provider/provider.dart';
import '../Screens/Hardware_info_screen.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final hardwares = Provider.of<hardware>(context);

    final data = hardwares.items;

    List list = [];

    List ids = [];

    for (var i = 0; i < data.length; i++) {
      list.add(data[i].Type);
      ids.add(data[i].id);
    }

    return GFSearchBar(
        searchList: list,
        searchQueryBuilder: (query, list) => list.where((item) {
              return item!
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
            }).toList(),
        overlaySearchListItemBuilder: (dynamic item) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                item,
                style: const TextStyle(fontSize: 18),
              ),
            ),
        onItemSelected: (dynamic item) {
          setState(() {
            Navigator.of(context).pushNamed(HardwareInfoScreen.routName,
                arguments: getid(item, data));
            print('$item');
          });
        });
  }

  getid(String item, data) {
    for (var i = 0; i < data.length; i++) {
      if (item.toLowerCase().contains(data[i].Type.toLowerCase())) {
        return data[i].id;
      }
    }
  }
}
