import '../providers/Models.dart' show SWHW;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Models.dart';

class ModelItem extends StatelessWidget {
  final String id;
  final String productid;
  final String price;
  final String title;
  final SWHW type;
  final double rating;

  ModelItem(
      {required this.id,
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
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Models>(context).removeItem(productid);
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: FittedBox(child: Text('$id')),
              ),
              title: Text('$title'),
              trailing:
                  type == SWHW.hardware ? Text('💲$price') : Text('⭐${rating}'),
            ),
          ),
        ),
      ),
    );
  }
}
