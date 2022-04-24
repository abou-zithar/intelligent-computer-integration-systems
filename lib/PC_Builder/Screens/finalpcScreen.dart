import 'package:best_flutter_ui_templates/PC_Builder/Items/dispalyfinalML.dart';
import 'package:best_flutter_ui_templates/PC_Builder/providers/Models.dart';
import 'package:flutter/material.dart';
import '../request/httpget.dart';
import '../models/final_model.dart';
import '../Screens/postdetails.dart';

class FinalPC extends StatelessWidget {
  String cpu = '';
  final cpus = [];
  String gpu = '';
  final gpus = [];
  String storage = '';
  final storages = [];
  String motherboard = '';
  final motherboards = [];
  String ram = '';
  final rams = [];
  String casepc = '';
  final casepcs = [];
  String cooler = '';
  final coolers = [];
  String powersupply = '';
  final powersupplys = [];
  String price = '';
  final prices = [];
  String modeltype = '';

  static const routName = '/FinalPC';
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    final finalPClist =
        ModalRoute.of(context)!.settings.arguments as List<ModelProvider>;

    // var cpu_type = '';
    // var cpu_core = '';
    // var cpu_gen = '';
    // var clockable = '';
    // void splitcpu(String title) {
    //   cpu_type = title.substring(0, 7);

    //   if (title.toLowerCase().contains('core')) {
    //     cpu_gen = title.substring(8, 13);
    //     clockable = title.substring(13);
    //   } else {
    //     cpu_gen = title.substring(8, 12);
    //     clockable = title.substring(12);
    //   }
    // }

    // void splitgpu(String gputitle) {
    //   print(gputitle);
    // }

    // void getTheimortantdata(List<ModelProvider> list) {
    //   // 3=>gpu
    //   // 6=>cpu
    //   splitcpu(list[6].title);
    //   cpu_core = list[6].prop1![0];
    //   splitgpu(list[3].title);
    // }

    // getTheimortantdata(finalPClist);
    // print(cpu_core);

    if (finalPClist.isNotEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: Text("The PC"),
          ),
          body: SingleChildScrollView(
            child: Row(children: [
              Expanded(
                child: Column(
                  children: [
                    FutureBuilder(
                      future: httpService.getPosts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PC>> snapshot) {
                        List<PC>? posts = snapshot.data;
                        splitmodels(posts);

                        if (snapshot.hasData) {
                          return MLoutput(
                            cpus: cpus,
                            gpus: gpus,
                            powersupplys: powersupplys,
                            rams: rams,
                            coolers: coolers,
                            storages: storages,
                            motherboards: motherboards,
                            casepcs: casepcs,
                            price: prices,
                            type: modeltype,
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ]),
          ));
    } else {
      return Scaffold(body: CircularProgressIndicator());
    }
  }

  splitmodels(list) {
    var strList = list[0].line.toString().split(' ');
    // print(strList);
    for (var i = 0; i < strList.length; i++) {
      if (strList[i].toLowerCase() == '') {
        strList.removeAt(i);
      }
      if (strList[i].toLowerCase() == 'intel' ||
          strList[i].toLowerCase() == 'amd') {
        cpu = strList[i] +
            ' ' +
            strList[i + 1] +
            ' ' +
            strList[i + 2] +
            ' ' +
            strList[i + 3] +
            ' ' +
            strList[i + 4] +
            ' ' +
            strList[i + 5] +
            ' ' +
            strList[i + 6] +
            ' GHz.';

        cpus.add(cpu);
      }

      if (strList[i].toLowerCase() == 'rtx' ||
          strList[i].toLowerCase() == 'gtx' ||
          strList[i].toLowerCase() == 'gt' ||
          strList[i].toLowerCase() == 'rt') {
        gpu = strList[i] +
            ' ' +
            strList[i + 1] +
            ' ' +
            strList[i + 2] +
            ' ' +
            strList[i + 3] +
            'GB ';

        gpus.add(gpu);
      }

      if (strList[i].toLowerCase() == 'ssd' ||
          strList[i].toLowerCase() == 'hdd') {
        storage = strList[i - 1] + ' ' + strList[i] + ' ';
        storages.add(storage);
      }

      if (strList[i].toLowerCase() == 'msi' ||
          strList[i].toLowerCase() == 'asus' ||
          strList[i].toLowerCase() == 'gigabyte') {
        motherboard =
            strList[i] + ' ' + strList[i + 1] + ' ' + strList[i + 2] + ' ';
        motherboards.add(motherboard);
      }

      if (strList[i].toLowerCase() == 'ddr4') {
        ram = strList[i - 2] + ' ' + strList[i - 1] + ' ' + strList[i] + ' ';
        rams.add(ram);

        casepc = strList[i + 1];

        casepcs.add(casepc);

        cooler =
            strList[i + 2] + ' ' + strList[i + 3] + ' ' + strList[i + 4] + ' ';

        coolers.add(cooler);
      }

      if ((strList[i].toLowerCase() == 't' ||
              strList[i].toLowerCase() == 'f') &&
          (strList[i + 1].toLowerCase() == 't' ||
              strList[i + 1].toLowerCase() == 'f')) {
        powersupply = strList[i + 2] + ' ' + 'W';

        powersupplys.add(powersupply);

        price = strList[i + 3];
        prices.add(price);
      }

      if (strList[i].toLowerCase() == 'gaming' ||
          strList[i].toLowerCase() == 'business' ||
          strList[i].toLowerCase() == 'general') {
        modeltype = strList[i];
      }
    }

    // print(cpus);
    // print(gpus);
    // print(storages);
    // print(motherboards);
    // print(rams);
    // print(casepcs);
    // print(coolers);
    // print(powersupplys);
    // print(prices);
    // print(modeltype);
  }
}
