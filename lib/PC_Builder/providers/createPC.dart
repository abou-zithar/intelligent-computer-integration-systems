library CreatePc;

import 'Models.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'Models.dart';
import 'dart:math';

class CreatePc {
  var weight = 0;

  List<ModelProvider> cpuhardware_list = [];
  List<ModelProvider> gpuhardware_list = [];
  List<ModelProvider> casehardware_list = [];
  List<ModelProvider> mBhardware_list = [];
  List<ModelProvider> rAMhardware_list = [];
  List<ModelProvider> storagehardware_list = [];
  List<ModelProvider> coolerhardware_list = [];
  List<ModelProvider> powersupplayhardware_list = [];
  List<String> points = [];

  int findfilter(String? overhead) {
    if (overhead == 'High') {
      return 3;
    } else if (overhead == 'Very High') {
      return 5;
    } else if (overhead == 'Mediam') {
      return 2;
    } else if (overhead == 'Low') {
      // print('easy');
    }
    // print(weight);
    return 0;
  }

  findType(List<String>? prop) {
    if (prop![1] == 'Color') {
      return 'MB';
    } else if (prop[1] == 'Cores') {
      return 'CPU';
    } else if (prop[1] == 'ER') {
      return 'PowerSupply';
    } else if (prop[1] == 'GPU_Chip') {
      return 'GPU';
    } else if (prop[1] == 'Brand') {
      return 'Cooler';
    } else if (prop[1] == 'Capacity') {
      return 'Storage';
    } else if (prop[1] == 'Speed') {
      return 'RAM';
    } else if (prop[1] == 'Type') {
      return 'Case';
    }
  }

  void filter_Hardware(ModelProvider hardware, String hardwareType) {
    if (hardwareType == 'CPU') {
      cpuhardware_list.add(hardware);
    } else if (hardwareType == 'GPU') {
      gpuhardware_list.add(hardware);
    } else if (hardwareType == 'MB') {
      mBhardware_list.add(hardware);
    } else if (hardwareType == 'PowerSupply') {
      powersupplayhardware_list.add(hardware);
    } else if (hardwareType == 'Cooler') {
      coolerhardware_list.add(hardware);
    } else if (hardwareType == 'Storage') {
      storagehardware_list.add(hardware);
    } else if (hardwareType == 'RAM') {
      rAMhardware_list.add(hardware);
    } else if (hardwareType == 'Case') {
      casehardware_list.add(hardware);
    }
  }

  void completeHardware_lists(int applications_final_weight) {
    // send the prop names with the rest of arrguments to the funcation???
    checkTheHardware_list(cpuhardware_list, 'CPU_2', 'Cores', 'TDP', 'Socket',
        'Price', 'Name', applications_final_weight);
    checkTheHardware_list(gpuhardware_list, 'GPU', 'GPU_Chip', 'GPU_Clock',
        'Memory', 'Price', 'Product_Name', applications_final_weight);
    checkTheHardware_list(casehardware_list, 'Case', 'Type', 'Color',
        'Side Panel Window', 'Price', 'Name', applications_final_weight);
    checkTheHardware_list(
        mBhardware_list,
        'Motherboard',
        'Memory_Max',
        'Memory_Slots',
        'Memory_Slots',
        'Prices',
        'Name',
        applications_final_weight);

    checkTheHardware_list(
        rAMhardware_list,
        'Memory',
        'Speed',
        'First_word_latency',
        'Modules',
        'Prices',
        'Name',
        applications_final_weight);

    checkTheHardware_list(storagehardware_list, 'Storage', 'Capacity',
        'Form_Factor', 'Type', 'Price', 'Name', applications_final_weight);

    checkTheHardware_list(coolerhardware_list, 'CPU Cooler', 'LGA 115x, 1200',
        'AMD AM4', 'RGB Sync', 'Price', 'Model', applications_final_weight);

    checkTheHardware_list(
        powersupplayhardware_list,
        'Power Supply',
        'Wattage',
        'Efficiency Rating',
        'Moduler',
        'Price',
        'Name',
        applications_final_weight);
  }

  checkTheHardware_list(
      List<ModelProvider> hardwarelist,
      String type,
      String prop1,
      String prop2,
      String prop3,
      String price,
      String name,
      int applicationsFinalWeight) async {
    while (true) {
      if (hardwarelist.length == 1) {
        // return this single item as the choice one after check the comptipilty with others items
        filterByApplication(hardwarelist, applicationsFinalWeight, type);
        break;
      } else if (1 < hardwarelist.length && hardwarelist.length < 5 ||
          hardwarelist.length == 0) {
        //get five hardware from the same type from backend
        CollectionReference hardwareref =
            FirebaseFirestore.instance.collection(type);
        var quearySnapShot = await hardwareref.orderBy(name).limit(5).get();

        List<QueryDocumentSnapshot> listdocs = quearySnapShot.docs;

        listdocs.forEach((element) {
          // print(element.get('Name'));
          if (element.exists) {
            var rng = new Random();
            var rating;
            // print(element.data());
            var randomm = rng.nextDouble();
            if (randomm > .5) {
              rating = rng.nextDouble() + 4;
            } else {
              rating = rng.nextDouble() + 3;
            }
            // adding items from the data base to the hardware list
            hardwarelist.add(ModelProvider(
              id: element.id,
              title: element.get(name) as String,
              imagePath: '',
              price: element.get(price) as String,
              discription: '',
              rating: rating,
              type: SWHW.hardware,
              prop1: [element.get(prop1) as String, prop1],
              prop2: [element.get(prop2) as String, prop2],
              prop3: [element.get(prop3) as String, prop3],
            ));
          } else {
            print('not exist');
          }
        });
        filterByApplication(hardwarelist, applicationsFinalWeight, type);
        break;
      } else if (hardwarelist.length >= 5) {
        filterByApplication(hardwarelist, applicationsFinalWeight, type);
        break;
      } else {
        break;
      }
    }
  }

  void filterByApplication(List<ModelProvider> hardwarelist,
      int applicationsFinalWeight, String hardwareType) {
    if (hardwareType == 'CPU_2') {
      ;
      ModelProvider cpu =
          getBestCPU(filterCPU(hardwarelist, applicationsFinalWeight));

      print(cpu.title);
    } else if (hardwareType == 'Motherboard') {
      filterMB(hardwarelist, applicationsFinalWeight);
    } else if (hardwareType == 'GPU') {
      filterGPU(hardwarelist, applicationsFinalWeight);
    } else if (hardwareType == 'Power Supply') {
      filterPowerSupply(hardwarelist, applicationsFinalWeight);
    } else if (hardwareType == 'CPU Cooler') {
      // not affected
    } else if (hardwareType == 'Storage') {
      filterStorage(hardwarelist, applicationsFinalWeight);
    } else if (hardwareType == 'Memory') {
      filterRAM(hardwarelist, applicationsFinalWeight);
    } else if (hardwareType == 'Case') {
      // not affected
    }
  }

  List<ModelProvider> filterCPU(
    List<ModelProvider> hardwarelist,
    int applicationsFinalWeight,
  ) {
    if (hardwarelist.length == 1) {
      // the final hradware part
    }
    for (var i = 0; i < hardwarelist.length; i++) {
      if (applicationsFinalWeight < 5) {
        if (int.parse(hardwarelist[i].prop1![0]) < 6) {
          cpuhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 10) {
        if (int.parse(hardwarelist[i].prop1![0]) < 8) {
          cpuhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 15) {
        if (int.parse(hardwarelist[i].prop1![0]) < 10) {
          cpuhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight > 15) {
        if (int.parse(hardwarelist[i].prop1![0]) < 12) {
          cpuhardware_list.removeAt(i);
        }
      }
    }
    return cpuhardware_list;
  }

  List<ModelProvider> filterMB(
    List<ModelProvider> hardwarelist,
    int applicationsFinalWeight,
  ) {
    for (var i = 0; i < hardwarelist.length; i++) {
      // print(int.parse(mBhardware_list[i].prop1![0]));
      if (hardwarelist.length == 1) {
        // the final hradware part
      }
      if (applicationsFinalWeight < 5) {
        if (int.parse(hardwarelist[i].prop1![0]) < 8) {
          mBhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 10) {
        if (int.parse(hardwarelist[i].prop1![0]) < 16) {
          mBhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 15) {
        if (int.parse(hardwarelist[i].prop1![0]) < 32) {
          mBhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight > 15) {
        if (int.parse(hardwarelist[i].prop1![0]) < 64) {
          mBhardware_list.removeAt(i);
        }
      }
    }
    return mBhardware_list;
  }

  List<ModelProvider> filterGPU(
    List<ModelProvider> hardwarelist,
    int applicationsFinalWeight,
  ) {
    if (hardwarelist.length == 1) {
      // the final hradware part
    }
    for (var i = 0; i < hardwarelist.length; i++) {
      // print(gpuhardware_list[i].prop3![0]);
      if (applicationsFinalWeight < 5) {
        if (int.parse(hardwarelist[i].prop3![0]) < 2) {
          gpuhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 10) {
        if (int.parse(hardwarelist[i].prop3![0]) < 4) {
          gpuhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 15) {
        if (int.parse(hardwarelist[i].prop3![0]) < 6) {
          gpuhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight > 15) {
        if (int.parse(hardwarelist[i].prop3![0]) < 8) {
          gpuhardware_list.removeAt(i);
        }
      }
    }
    return gpuhardware_list;
  }

  List<ModelProvider> filterPowerSupply(
    List<ModelProvider> hardwarelist,
    int applicationsFinalWeight,
  ) {
    if (hardwarelist.length == 1) {
      // the final hradware part
    }
    for (var i = 0; i < hardwarelist.length; i++) {
      // print(powersupplayhardware_list[i].prop1![0]);
      if (applicationsFinalWeight < 5) {
        if (int.parse(hardwarelist[i].prop1![0]) < 500) {
          powersupplayhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 10) {
        if (int.parse(hardwarelist[i].prop1![0]) < 800) {
          powersupplayhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 15) {
        if (int.parse(hardwarelist[i].prop1![0]) < 900) {
          powersupplayhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight > 15) {
        if (int.parse(hardwarelist[i].prop1![0]) < 1000) {
          powersupplayhardware_list.removeAt(i);
        }
      }
    }
    return powersupplayhardware_list;
  }

  List<ModelProvider> filterStorage(
    List<ModelProvider> hardwarelist,
    int applicationsFinalWeight,
  ) {
    // print(applicationsFinalWeight);
    for (var i = 0; i < hardwarelist.length; i++) {
      // print(double.parse(hardwarelist[i].prop1![0]) * 1000);
      if (hardwarelist.length == 1) {
        // the final hradware part
      }
      if (applicationsFinalWeight < 5) {
        if (double.parse(hardwarelist[i].prop1![0]) * 1000 < 750) {
          // print('removed');
          storagehardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 10) {
        if (double.parse(hardwarelist[i].prop1![0]) * 1000 < 1000) {
          // print('removed');
          storagehardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 15) {
        if (double.parse(hardwarelist[i].prop1![0]) * 1000 < 1500) {
          // print('removed');
          storagehardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight > 15) {
        if (double.parse(hardwarelist[i].prop1![0]) * 1000 < 2000) {
          // print('removed');
          storagehardware_list.removeAt(i);
        }
      }
    }
    return storagehardware_list;
  }

  List<ModelProvider> filterRAM(
    List<ModelProvider> hardwarelist,
    int applicationsFinalWeight,
  ) {
    // print(applicationsFinalWeight);
    String number;
    String value;

    for (var i = 0; i < hardwarelist.length; i++) {
      number = hardwarelist[i].prop3![0][0];
      if (hardwarelist[i].prop3![0][5] == 'G') {
        value = hardwarelist[i].prop3![0][4];
      } else {
        value = hardwarelist[i].prop3![0][4] + hardwarelist[i].prop3![0][5];
      }
      var capicity = int.parse(number) * int.parse(value);
      // print(capicity);

      if (hardwarelist.length == 1) {
        // the final hradware part
      }
      if (applicationsFinalWeight < 5) {
        if (capicity < 4) {
          rAMhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 10) {
        if (capicity < 8) {
          rAMhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight < 15) {
        if (capicity < 16) {
          rAMhardware_list.removeAt(i);
        }
      } else if (applicationsFinalWeight > 15) {
        if (capicity < 32) {
          rAMhardware_list.removeAt(i);
        }
      }
    }
    return rAMhardware_list;
  }

  ModelProvider getBestCPU(List<ModelProvider> cpuhardware_list) {
    print(cpuhardware_list);

    int value = 0;

    if (cpuhardware_list.length == 1) return cpuhardware_list[0];

    for (var i = 0; i < cpuhardware_list.length; i++) {
      for (var j = 1; j < cpuhardware_list.length; j++) {
        if (int.parse(cpuhardware_list[i].prop1![0]) >
            int.parse(cpuhardware_list[j].prop1![0])) {
          cpuhardware_list[i].points += 1;
        } else {
          cpuhardware_list[j].points += 1;
        }

        if (int.parse(cpuhardware_list[i].prop2![0]) >
            int.parse(cpuhardware_list[j].prop2![0])) {
          cpuhardware_list[i].points += 1;
        } else {
          cpuhardware_list[j].points += 1;
        }

        if (double.parse(cpuhardware_list[i].price) >
            double.parse(cpuhardware_list[j].price)) {
          cpuhardware_list[j].points += 1;
        } else {
          cpuhardware_list[i].points += 1;
        }
      }
      points.add(cpuhardware_list[i].points.toString());
    }
    points.sort();
    // print(points.first);
    for (var i = 0; i < cpuhardware_list.length; i++) {
      // ignore: unrelated_type_equality_checks
      if (cpuhardware_list[i].points == points.first) {
        return cpuhardware_list[i];
      }
    }
    return cpuhardware_list[0];
  }
}
