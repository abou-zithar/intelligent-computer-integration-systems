import 'Models.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:math';

List<ModelProvider> datapc = [];

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

  List<int> points = [];

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
    if (prop![1] == 'Max') {
      return 'MB';
    } else if (prop[1] == 'Cores') {
      return 'CPU';
    } else if (prop[1] == 'Wattage') {
      return 'PowerSupply';
    } else if (prop[1] == 'Chip') {
      return 'GPU';
    } else if (prop[1] == 'Brand') {
      return 'Cooler';
    } else if (prop[1] == 'Capacity') {
      return 'Storage';
    } else if (prop[1] == 'CAS_l') {
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

  void completeHardware_lists(int applicationsFinalWeight) {
    // send the prop names with the rest of arrguments to the funcation???
    checkTheHardware_list(cpuhardware_list, 'CPU_2', 'Cores', 'TDP', 'Socket',
        'Price', 'Name', applicationsFinalWeight);

    checkTheHardware_list(mBhardware_list, 'Motherboard', 'Memory_Max',
        'Memory_Slots', 'Socket', 'Prices', 'Name', applicationsFinalWeight);

    checkTheHardware_list(gpuhardware_list, 'GPU', 'GPU_Chip', 'GPU_Clock',
        'Memory', 'Price', 'Product_Name', applicationsFinalWeight);

    checkTheHardware_list(casehardware_list, 'Case', 'Type', 'Color',
        'Side Panel Window', 'Price', 'Name', applicationsFinalWeight);

    checkTheHardware_list(
        rAMhardware_list,
        'Memory',
        'CAS_latency',
        'First_word_latency',
        'Modules',
        'Prices',
        'Name',
        applicationsFinalWeight);

    checkTheHardware_list(storagehardware_list, 'Storage', 'Capacity',
        'Form_Factor', 'Type', 'Price', 'Name', applicationsFinalWeight);

    checkTheHardware_list(coolerhardware_list, 'CPU Cooler', 'LGA 115x, 1200',
        'AMD AM4', 'RGB Sync', 'Price', 'Model', applicationsFinalWeight);

    checkTheHardware_list(
        powersupplayhardware_list,
        'Power Supply',
        'Wattage',
        'Efficiency Rating',
        'Moduler',
        'Price',
        'Name',
        applicationsFinalWeight);
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
      // print(hardwarelist);
      ModelProvider cpu =
          getBestCPU(filterCPU(hardwarelist, applicationsFinalWeight));
      // print(cpu.prop1);

      datapc.add(cpu);

      // print(cpu.title);
      // thebestcpu = cpu;

    } else if (hardwareType == 'Motherboard') {
      // hardwarelist = checkcompatibility(hardwarelist, thebestcpu!);
      // print(hardwarelist);
      ModelProvider motherBored =
          getBestmotherbored(filterMB(hardwarelist, applicationsFinalWeight));
      datapc.add(motherBored);
    }
    //the gpu is over with check
    else if (hardwareType == 'GPU') {
      ModelProvider gpu =
          getBestGPU(filterGPU(hardwarelist, applicationsFinalWeight));
      datapc.add(gpu);
    } else if (hardwareType == 'Power Supply') {
      ModelProvider powerSupply = getBestpowersupplay(
          filterPowerSupply(hardwarelist, applicationsFinalWeight));

      datapc.add(powerSupply);
    } else if (hardwareType == 'CPU Cooler') {
      // not affected

      ModelProvider cooler = getBestcooler(hardwarelist);
      datapc.add(cooler);
    } else if (hardwareType == 'Storage') {
      ModelProvider storage =
          getBeststorage(filterStorage(hardwarelist, applicationsFinalWeight));
      datapc.add(storage);
    } else if (hardwareType == 'Memory') {
      ModelProvider ram =
          getBestRam(filterRAM(hardwarelist, applicationsFinalWeight));
      datapc.add(ram);
    } else if (hardwareType == 'Case') {
      // not affected

      ModelProvider pcCase = getBestCase(hardwarelist);
      datapc.add(pcCase);
    }
  }

  List<ModelProvider> filterCPU(
    List<ModelProvider> hardwarelist,
    int applicationsFinalWeight,
  ) {
    if (hardwarelist.length == 1) {
      return cpuhardware_list;
    }

    for (var i = 0; i < hardwarelist.length; i++) {
      // print(hardwarelist);
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
      // print(applicationsFinalWeight);
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
    var capicity;

    for (var i = 0; i < hardwarelist.length; i++) {
      // print('hardwarelist[i].prop3![0]');
      // print(hardwarelist[i].prop3![0]);
      if (hardwarelist[i].prop3![0] == '') {
        capicity = 16;
      }
      number = hardwarelist[i].prop3![0][0];

      if (hardwarelist[i].prop3![0][5] == 'G') {
        value = hardwarelist[i].prop3![0][4];
      } else {
        value = hardwarelist[i].prop3![0][4] + hardwarelist[i].prop3![0][5];
      }
      capicity = int.parse(number) * int.parse(value);
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

  ModelProvider getBestCPU(List<ModelProvider> cpuhardwareList) {
    // print(cpuhardware_list);

    if (cpuhardwareList.length == 1) return cpuhardwareList[0];

    for (var i = 0; i < cpuhardwareList.length; i++) {
      for (var j = 1; j < cpuhardwareList.length; j++) {
        if (int.parse(cpuhardwareList[i].prop1![0]) >
            int.parse(cpuhardwareList[j].prop1![0])) {
          cpuhardwareList[i].points += 1;
        } else {
          cpuhardwareList[j].points += 1;
        }

        if (int.parse(cpuhardwareList[i].prop2![0]) >
            int.parse(cpuhardwareList[j].prop2![0])) {
          cpuhardwareList[j].points += 1;
        } else {
          cpuhardwareList[i].points += 1;
        }

        if (double.parse(cpuhardwareList[i].price) >
            double.parse(cpuhardwareList[j].price)) {
          cpuhardwareList[j].points += 1;
        } else {
          cpuhardwareList[i].points += 1;
        }
      }
    }
    for (var i = 0; i < cpuhardwareList.length; i++) {
      points.add(cpuhardwareList[i].points);
    }

    points.sort();

    for (var i = 0; i < cpuhardwareList.length; i++) {
      // ignore: unrelated_type_equality_checks

      if (cpuhardwareList[i].points == points.last) {
        return cpuhardwareList[i];
      }
    }

    return cpuhardwareList[0];
  }

  ModelProvider getBestmotherbored(List<ModelProvider> mBhardwareList) {
    List<int> points = [];

    if (mBhardwareList.length == 1) return mBhardwareList[0];

    for (var i = 0; i < mBhardwareList.length; i++) {
      for (var j = 1; j < mBhardwareList.length; j++) {
        if (int.parse(mBhardwareList[i].prop1![0]) >
            int.parse(mBhardwareList[j].prop1![0])) {
          mBhardwareList[i].points += 1;
        } else {
          mBhardwareList[j].points += 1;
        }

        if (int.parse(mBhardwareList[i].prop2![0]) >
            int.parse(mBhardwareList[j].prop2![0])) {
          mBhardwareList[i].points += 1;
        } else {
          mBhardwareList[j].points += 1;
        }

        if (double.parse(mBhardwareList[i].price) >
            double.parse(mBhardwareList[j].price)) {
          mBhardwareList[j].points += 1;
        } else {
          mBhardwareList[i].points += 1;
        }
      }
    }

    for (var i = 0; i < mBhardwareList.length; i++) {
      points.add(mBhardwareList[i].points);
    }
    points.sort();

    // print(points);

    for (var i = 0; i < mBhardwareList.length; i++) {
      // ignore: unrelated_type_equality_checks

      if (mBhardwareList[i].points < points.last) {
        mBhardwareList.removeAt(i);

        // return cpuhardwareList[i];
      }
    }

    // print(savedi);
    return mBhardwareList[0];
  }

  checkcompatibility(
      List<ModelProvider> hardwareList, ModelProvider hardwareitem) {
    var compatibility = false;
    for (var i = 0; i < hardwareList.length; i++) {
      if (hardwareitem.prop3![0].contains(hardwareList[i].prop3![0])) {
        // print(hardwareitem.prop3![0]);
        // print(hardware_list[i].prop3![0]);
        compatibility = true;
        // print('yes');
      } else {
        // print(hardwareitem.prop3![0]);
        // print(hardware_list[i].prop3![0]);
        hardwareList.removeAt(i);
      }
    }

    if (!compatibility || hardwareList.length == 0) {
      // please change the hardware there are not compatibility
    }

    return hardwareList;
  }

  getBestGPU(List<ModelProvider> gpuhardwareList) {
    // print(gpuhardwareList);
    List<int> points = [];

    if (gpuhardwareList.length == 1) return gpuhardwareList[0];

    for (var i = 0; i < gpuhardwareList.length; i++) {
      for (var j = 1; j < gpuhardwareList.length; j++) {
        if (int.parse(gpuhardwareList[i].prop3![0]) >
            int.parse(gpuhardwareList[j].prop3![0])) {
          gpuhardwareList[i].points += 1;
        } else {
          gpuhardwareList[j].points += 1;
        }

        if (int.parse(gpuhardwareList[i].prop2![0]) >
            int.parse(gpuhardwareList[j].prop2![0])) {
          gpuhardwareList[i].points += 1;
        } else {
          gpuhardwareList[j].points += 1;
        }

        if (double.parse(gpuhardwareList[i].price) >
            double.parse(gpuhardwareList[j].price)) {
          gpuhardwareList[j].points += 1;
        } else {
          gpuhardwareList[i].points += 1;
        }
      }
    }
    for (var i = 0; i < gpuhardwareList.length; i++) {
      points.add(gpuhardwareList[i].points);
    }
    points.sort();

    // print(points);
    for (var i = 0; i < gpuhardwareList.length; i++) {
      // ignore: unrelated_type_equality_checks

      if (gpuhardwareList[i].points == points.last) {
        return gpuhardwareList[i];

        // return cpuhardwareList[i];
      }
    }

    // print(savedi);
  }

  ModelProvider getBestRam(List<ModelProvider> ramHardwareList) {
    List<int> points = [];
    String number;
    String value;
    var others_capability;
    var main_capability;

    if (ramHardwareList.length == 1) return ramHardwareList[0];

    for (var i = 0; i < ramHardwareList.length; i++) {
      number = ramHardwareList[i].prop3![0][0];
      if (ramHardwareList[i].prop3![0][5] == 'G') {
        value = ramHardwareList[i].prop3![0][4];
      } else {
        value =
            ramHardwareList[i].prop3![0][4] + ramHardwareList[i].prop3![0][5];
      }
      main_capability = int.parse(value) * int.parse(number);
      // print(main_capability);
      for (var j = 1; j < ramHardwareList.length; j++) {
        number = ramHardwareList[i].prop3![0][0];
        if (ramHardwareList[i].prop3![0][5] == 'G') {
          value = ramHardwareList[i].prop3![0][4];
        } else {
          value =
              ramHardwareList[i].prop3![0][4] + ramHardwareList[i].prop3![0][5];
        }
        others_capability = int.parse(value) * int.parse(number);
        // print(others_capability);

        if (int.parse(ramHardwareList[i].prop1![0]) >
            int.parse(ramHardwareList[j].prop1![0])) {
          ramHardwareList[j].points += 1;
        } else {
          ramHardwareList[i].points += 1;
        }

        if (main_capability > others_capability) {
          ramHardwareList[i].points += 1;
        } else {
          ramHardwareList[j].points += 1;
        }

        if (double.parse(ramHardwareList[i].price) >
            double.parse(ramHardwareList[j].price)) {
          ramHardwareList[j].points += 1;
        } else {
          ramHardwareList[i].points += 1;
        }
      }
    }
    for (var i = 0; i < ramHardwareList.length; i++) {
      points.add(ramHardwareList[i].points);
    }
    points.sort();
    // print(points);

    for (var i = 0; i < ramHardwareList.length; i++) {
      // ignore: unrelated_type_equality_checks

      if (ramHardwareList[i].points == points.last) {
        return ramHardwareList[i];

        // return cpuhardwareList[i];
      }
    }

    // print(savedi);
    return ramHardwareList[0];
  }

  ModelProvider getBeststorage(List<ModelProvider> storageHardwareList) {
    List<int> points = [];

    if (storageHardwareList.length == 1) return storageHardwareList[0];

    for (var i = 0; i < storageHardwareList.length; i++) {
      for (var j = 1; j < storageHardwareList.length; j++) {
        if (double.parse(storageHardwareList[i].prop1![0]) >
            double.parse(storageHardwareList[j].prop1![0])) {
          storageHardwareList[j].points += 1;
        } else {
          storageHardwareList[i].points += 1;
        }

        if (storageHardwareList[i].prop3![0] == 'SSD') {
          storageHardwareList[i].points += 2;
        }

        if (double.parse(storageHardwareList[i].price) >
            double.parse(storageHardwareList[j].price)) {
          storageHardwareList[j].points += 1;
        } else {
          storageHardwareList[i].points += 1;
        }
      }
    }

    for (var i = 0; i < storageHardwareList.length; i++) {
      points.add(storageHardwareList[i].points);
    }
    points.sort();
    // print(points);

    for (var i = 0; i < storageHardwareList.length; i++) {
      // ignore: unrelated_type_equality_checks

      if (storageHardwareList[i].points == points.last) {
        return storageHardwareList[i];

        // return cpuhardwareList[i];
      }
    }

    // print(savedi);
    return storageHardwareList[0];
  }

  ModelProvider getBestpowersupplay(
      List<ModelProvider> powersupplayhardwareList) {
    List<int> points = [];

    if (powersupplayhardwareList.length == 1)
      return powersupplayhardwareList[0];

    for (var i = 0; i < powersupplayhardwareList.length; i++) {
      for (var j = 1; j < powersupplayhardwareList.length; j++) {
        if (int.parse(powersupplayhardwareList[i].prop1![0]) <
            int.parse(powersupplayhardwareList[j].prop1![0])) {
          powersupplayhardwareList[i].points += 1;
        } else {
          powersupplayhardwareList[j].points += 1;
        }

        if (double.parse(powersupplayhardwareList[i].price) >
            double.parse(powersupplayhardwareList[j].price)) {
          powersupplayhardwareList[j].points += 1;
        } else {
          powersupplayhardwareList[i].points += 1;
        }
      }
    }
    for (var i = 0; i < powersupplayhardwareList.length; i++) {
      points.add(powersupplayhardwareList[i].points);
    }

    points.sort();

    // print(points);
    for (var i = 0; i < powersupplayhardwareList.length; i++) {
      // ignore: unrelated_type_equality_checks

      if (powersupplayhardwareList[i].points == points.last) {
        return powersupplayhardwareList[i];
      }
    }

    return powersupplayhardwareList[0];
  }

  ModelProvider getBestCase(List<ModelProvider> casehardwareList) {
    List<int> points = [];

    if (casehardwareList.length == 1) return casehardwareList[0];

    for (var i = 0; i < casehardwareList.length; i++) {
      for (var j = 1; j < casehardwareList.length; j++) {
        if (double.parse(casehardwareList[i].price) >
            double.parse(casehardwareList[j].price)) {
          casehardwareList[j].points += 1;
        } else {
          casehardwareList[i].points += 1;
        }
      }
    }
    for (var i = 0; i < casehardwareList.length; i++) {
      points.add(casehardwareList[i].points);
    }

    points.sort();

    // print(points);
    for (var i = 0; i < casehardwareList.length; i++) {
      // ignore: unrelated_type_equality_checks

      if (casehardwareList[i].points == points.last) {
        return casehardwareList[i];
      }
    }

    return casehardwareList[0];
  }

  ModelProvider getBestcooler(List<ModelProvider> coolerhardwareList) {
    List<int> points = [];

    if (coolerhardwareList.length == 1) return coolerhardwareList[0];

    for (var i = 0; i < coolerhardwareList.length; i++) {
      for (var j = 1; j < coolerhardwareList.length; j++) {
        if (coolerhardwareList[i].prop3![0] == 'Yes') {
          coolerhardwareList[i].points += 1;
        } else {
          coolerhardwareList[j].points += 1;
        }

        if (double.parse(coolerhardwareList[i].price) >
            double.parse(coolerhardwareList[j].price)) {
          coolerhardwareList[j].points += 1;
        } else {
          coolerhardwareList[i].points += 1;
        }
      }
    }
    for (var i = 0; i < coolerhardwareList.length; i++) {
      points.add(coolerhardwareList[i].points);
    }

    points.sort();

    // print(points);
    for (var i = 0; i < coolerhardwareList.length; i++) {
      // ignore: unrelated_type_equality_checks

      if (coolerhardwareList[i].points == points.last) {
        return coolerhardwareList[i];
      }
    }

    return coolerhardwareList[0];
  }

  List<ModelProvider> getpcdata() {
    return datapc;
  }

  resetdatapc() {
    datapc = [];
  }
}
