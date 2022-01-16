import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Items/model_item.dart';
import '../providers/Models.dart' show Models, SWHW;

class ModelScreen extends StatelessWidget {
  static const routeName = './model';

  @override
  Widget build(BuildContext context) {
    final modeldata = Provider.of<Models>(context);
    final model = modeldata.items;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Model Genrator',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return ModelItem(
                id: (index + 1).toString(),
                productid: model.keys.toList()[index],
                price: model.values.toList()[index].price,
                title: model.values.toList()[index].title,
                type: model.values.toList()[index].type,
                rating: model.values.toList()[index].rating,
              );
            },
            itemCount: model.length,
          ),
        ),
        Padding(padding: EdgeInsets.all(10)),
        TextButton(
          child: Text('Create Now'),
          style: TextButton.styleFrom(
            primary: Colors.lightBlue,
            backgroundColor: Colors.white,
            shadowColor: Colors.grey,
            elevation: 5,
          ),
          onPressed: () {
            print('Pressed');
          },
        )
      ]),
    );
  }

  Widget bulidSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.lightBlue, fontWeight: FontWeight.bold, fontSize: 40),
      ),
    );
  }

  Widget buildcontainer(Widget child) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            height: 400,
            width: 500,
            child: child,
          ),
        ),
      ]),
    );
  }
}
