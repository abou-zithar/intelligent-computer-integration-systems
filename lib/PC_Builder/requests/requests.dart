import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class REQUEST extends StatefulWidget {
  @override
  State<REQUEST> createState() => _REQUESTState();
}

class _REQUESTState extends State<REQUEST> {
  var data;

  Future<String> getData() async {
    var apiEndpoint =
        'https://comppartsapi.herokuapp.com/'; // Replace with your own api url
    final Uri url = Uri.parse(apiEndpoint);
    var response = await http.get(url, headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body);
      print(data);
    });
    return "Success";
  }

  Widget getListItem(int i) {
    if (data == null || data.length < 1) return SizedBox.shrink();
    if (i == 0) {
      return Container(
        margin: EdgeInsets.all(4),
        child: Center(
          child: Text(
            "Titles",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Container(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            data[i]['title'].toString(),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget getList() {
    if (data == null || data.length < 1) {
      // print('data');
      return Container(
        child: Center(
          child: Text("Please wait..."),
        ),
      );
    }
    return ListView.separated(
      itemCount: data?.length,
      itemBuilder: (BuildContext context, int index) {
        return getListItem(index);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return getList();
  }
}
