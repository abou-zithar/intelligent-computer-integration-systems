import '../items/Hardware_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Hardware_provider.dart';

enum FilterOPtions { Favorites, ALL }

class HardwareScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    final productsContanier = Provider.of<hardware>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOPtions selectedvalue) {
              if (selectedvalue == FilterOPtions.Favorites) {
                productsContanier.showFavoritesOnly();
              } else {
                productsContanier.showAll();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOPtions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOPtions.ALL,
              )
            ],
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('./model'),
            icon: Icon(Icons.computer),
            color: Colors.black,
          )
        ],
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90),
          child: const Text(
            'Hardware',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: HardwareGrid(),
    );
  }
}

class HardwareGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hardwaredata = Provider.of<hardware>(context);
    final hardwares = hardwaredata.items;
    return GridView.builder(
      primary: false,
      padding: const EdgeInsets.all(10.0),
      itemCount: hardwares.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: hardwares[i],
        child: Hardware_item()
        //hardwares[i].icon, hardwares[i].id,
        //     hardwares[i].Type, hardwares[i].Imageurl, hardwares[i].price
        ,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      // children: Hardware.DUMMY_Hardware.map((e) => Hardware_item(
      //     e.icon,
      //     e.Manfacturer,
      //     e.Type,
      //     e.Rating,
      //     e.Imageurl,
      //     e.Description,
      //     e.price)).toList(),
    );
  }
}
