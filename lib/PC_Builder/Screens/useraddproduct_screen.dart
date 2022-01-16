import 'package:best_flutter_ui_templates/PC_Builder/providers/Hardware_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Hardware_provider.dart';
import '../Items/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hardwaredata = Provider.of<hardware>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('your product'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (_, i) => USerProductItem(
              imageUrl: hardwaredata.items[i].Imageurl,
              title: hardwaredata.items[i].Manfacturer),
          itemCount: hardwaredata.items.length,
        ),
      ),
    );
  }
}
