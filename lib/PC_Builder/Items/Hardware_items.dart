import '../providers/Models.dart';

import '../Screens/Hardware_info_screen.dart';
import '../providers/Hardware.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Hardware_item extends StatefulWidget {
  @override
  State<Hardware_item> createState() => _Hardware_itemState();
}

class _Hardware_itemState extends State<Hardware_item> {
  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore.instance.collection('CPU').snapshots().listen((data) {
    //   print(data.docs[1].data());
    // });
    final hardwareitem = Provider.of<Hardware>(context);
    final models = Provider.of<Models>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.asset(
            hardwareitem.Imageurl,
            fit: BoxFit.cover,
          ),
          onTap: () => Navigator.of(context).pushNamed(
              HardwareInfoScreen.routName,
              arguments: hardwareitem.id),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.lightBlue,
          leading: IconButton(
              onPressed: () => hardwareitem.togglefavoritestatus(),
              icon: Icon(hardwareitem.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.white),
          title: Text(
            hardwareitem.Type,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // FirebaseFirestore.instance
              //     .collection('CPU')
              //     .snapshots()
              //     .listen((data) {
              //   print(data.docs.map((docs) {
              //     print(docs['Name']);
              //   }));
              // });
              models.addItem(
                  hardwareitem.id,
                  hardwareitem.price,
                  hardwareitem.Type,
                  hardwareitem.Rating,
                  hardwareitem.Imageurl,
                  hardwareitem.color,
                  hardwareitem.swhw);
              Scaffold.of(context).hideCurrentSnackBar();

              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Added item to Model",
                ),
                action: SnackBarAction(
                  label: ' UNDO',
                  onPressed: () {
                    models.removeItem(hardwareitem.id);
                  },
                ),
                duration: Duration(seconds: 2),
              ));
            },
            color: Colors.white,
          ),
        ),
      ),
    );
    // InkWell(
    //   onTap: () => selectHardware(context),
    //   onLongPress: null,
    //   splashColor: Theme.of(context).primaryColor,
    //   borderRadius: BorderRadius.circular(15),
    //   child: Container(
    //     padding: const EdgeInsets.all(20),
    //     child: Column(
    //       children: [
    //         Image.asset(
    //           imageurl,
    //           height: 50,
    //         ),
    //         Text(title),
    //         SizedBox(
    //           height: 5,
    //         ),
    //         Row(
    //           children: [
    //             Container(
    //                 child: Text(
    //               type,
    //             )),
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width / 15,
    //             ),
    //             Text(
    //               '${Rating}',
    //             ),
    //             Icon(
    //               Icons.star,
    //               color: PCBuilderAppTheme.nearlyBlue,
    //             )
    //           ],
    //         ),
    //         SizedBox(
    //           height: 5,
    //         ),
    //         Text('$Description'),
    //         SizedBox(
    //           height: 5,
    //         ),
    //         Text('\$${price}'),
    //       ],
    //     ),
    //     decoration: BoxDecoration(
    //         color: HexColor('#f8fafb'),
    //         borderRadius: BorderRadius.circular(15)),
    //   ),
    // ),
  }
}
