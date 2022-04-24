import 'dart:math';

import 'package:best_flutter_ui_templates/PC_Builder/Items/finalpcItem.dart';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../providers/Models.dart' show ModelProvider, Models;

import '../providers/pcModel.dart';

class PCScreen extends StatelessWidget {
  static const routeName = './PCScreen';

  static getbudget(String budegt_user) {
    var budget = budegt_user as int;
  }

  // var list = [];

  @override
  Widget build(BuildContext context) {
    var counter = 0;
    var total = 0;
    List types = ['gaming', 'business', 'general'];
    var rng = new Random();
    var type = rng.nextInt(3);
    // print(type);

    final finalPClist =
        ModalRoute.of(context)!.settings.arguments as List<ModelProvider>;

    // print(finalPClist);
    final modeldata = Provider.of<Models>(context);
    final displayPC = Provider.of<PcModel>(context);

    if (finalPClist.isNotEmpty) {
      for (var i = 0; i < finalPClist.length; i++) {
        total += int.parse(finalPClist[i].price);
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Final PC',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return FinalPCItem(
                    counter: (index + 1).toString(),
                    id: finalPClist[index].id.toString(),
                    productid: finalPClist[index].id,
                    price: finalPClist[index].price.toString(),
                    title: finalPClist[index].title.toString(),
                    type: finalPClist[index].type,
                    rating: finalPClist[index].rating,
                  );
                },
                itemCount: 8,
              ),
            ),

            Padding(padding: EdgeInsets.all(10)),
            GFCard(
              boxFit: BoxFit.cover,
              image: Image.asset('assets/new_images/dollar.jpg'),
              title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/new_images/dollar.jpg'),
                  ),
                  title: Text('${'price :'}'),
                  subTitle: Text('${total.toString()}')),
            ),
            GFCard(
              boxFit: BoxFit.cover,
              image: Image.asset('assets/new_images/computer.png'),
              title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage('assets/new_images/computer.png'),
                  ),
                  title: Text('${'type :'}'),
                  subTitle: Text('${types[type].toString()}')),
            ),
            // TextButton(
            //   child: Text('Save PC'),
            //   style: TextButton.styleFrom(
            //     primary: Colors.lightBlue,
            //     backgroundColor: Colors.white,
            //     shadowColor: Colors.grey,
            //     elevation: 5,
            //   ),
            //   onPressed: () {
            //     var rng = new Random();
            //     var rating;

            //     var randomm = rng.nextDouble();
            //     if (randomm > .5) {
            //       rating = rng.nextDouble() + 4;
            //     } else {
            //       rating = rng.nextDouble() + 3;
            //     }

            //     displayPC.addpcmodel(
            //       finalPClist[0].id,
            //       finalPClist[1].id,
            //       finalPClist[2].id,
            //       finalPClist[3].id,
            //       finalPClist[4].id,
            //       finalPClist[5].id,
            //       finalPClist[6].id,
            //       finalPClist[7].id,
            //       clcuprice(finalPClist),
            //       rating,
            //       (counter++).toString(),
            //     );

            //     // print(displayPC.items);
            //   },
            // ),
          ],
        ),
      );
    } else {
      return Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      ));
    }
  }

  clcuprice(List<ModelProvider> lst) {
    num totalprice = 0;
    totalprice = num.parse(lst[0].price) +
        num.parse(lst[1].price) +
        num.parse(lst[2].price) +
        num.parse(lst[3].price) +
        num.parse(lst[4].price) +
        num.parse(lst[5].price) +
        num.parse(lst[6].price) +
        num.parse(lst[7].price);

    return totalprice;
  }
}
