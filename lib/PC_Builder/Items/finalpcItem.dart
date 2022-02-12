import 'package:best_flutter_ui_templates/PC_Builder/Screens/Software_info_screen.dart';

import '../providers/Models.dart' show SWHW;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Models.dart';
import '../Screens/Hardware_info_screen.dart';

class FinalPCItem extends StatelessWidget {
  final String counter;
  final String id;
  final String productid;
  final String price;
  final String title;
  final SWHW type;
  final double rating;

  FinalPCItem(
      {required this.counter,
      required this.id,
      required this.productid,
      required this.price,
      required this.title,
      required this.type,
      this.rating = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dismissible(
        key: ValueKey(id),
        background: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
        ),
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text('Are you Sure?'),
                    content: Text('Do you want to remove the item'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text('No')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                          child: Text('Yes'))
                    ],
                  ));
        },
        direction: DismissDirection.none,
        onDismissed: (direction) {
          // solved problem;
          Provider.of<Models>(context, listen: false).removeItem(productid);
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(HardwareInfoScreen.routName, arguments: id);
                },
                leading: CircleAvatar(
                  child: FittedBox(child: Text('$counter')),
                ),
                title: Text('$title'),
                trailing: Text('💲$price')),
          ),
        ),
      ),
    );
  }
}
