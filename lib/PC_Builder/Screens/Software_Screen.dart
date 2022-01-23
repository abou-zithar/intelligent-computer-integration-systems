import 'package:best_flutter_ui_templates/PC_Builder/providers/software.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/software_provider.dart';
import '../Items/Software_item.dart';

enum FilterOPtions { Favorites, ALL }

class Software_scresen extends StatelessWidget {
  static const routName = '/software-info';
  @override
  Widget build(BuildContext context) {
    final softwaredata = Provider.of<software>(context, listen: false);
    final soft = softwaredata.items;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOPtions selectedvalue) {
              if (selectedvalue == FilterOPtions.Favorites) {
                softwaredata.showFavoritesOnly();
              } else {
                softwaredata.showAll();
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
          IconButton(onPressed: null, icon: Icon(Icons.computer))
        ],
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90),
          child: const Text(
            'Software',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: softGrip(soft: soft),
    );
    ;
  }
}

class softGrip extends StatelessWidget {
  const softGrip({
    Key? key,
    required this.soft,
  }) : super(key: key);

  final List<Software> soft;

  @override
  Widget build(BuildContext context) {
    final softwaredata = Provider.of<software>(context, listen: false);

    softwaredata.catchApplications();
    return GridView.builder(
      primary: false,
      padding: const EdgeInsets.all(10.0),
      itemCount: soft.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: soft[i],
        child: software_item()
        // soft[i].title, soft[i].version,
        //   soft[i].discription, soft[i].imagePath, soft[i].rating

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
