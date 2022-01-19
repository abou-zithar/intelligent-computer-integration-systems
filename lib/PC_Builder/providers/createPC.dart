import 'Models.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePc {
  late int weight = 0;

  List<ModelProvider> cpuhardware_list = [];
  List<ModelProvider> gpuhardware_list = [];
  List<ModelProvider> casehardware_list = [];
  List<ModelProvider> mBhardware_list = [];
  List<ModelProvider> rAMhardware_list = [];
  List<ModelProvider> storagehardware_list = [];
  List<ModelProvider> coolerhardware_list = [];
  List<ModelProvider> powersupplayhardware_list = [];

  int findfilter(String? overhead) {
    if (overhead == 'High') {
      weight += 2;
    } else if (overhead == 'Very High') {
      weight += 3;
    } else if (overhead == 'Mediam') {
      weight += 1;
    } else if (overhead == 'Low') {
      // print('easy');
    }
    return weight;
  }

  findType(List<String>? prop) {
    if (prop![1] == 'Color') {
      return 'MB';
    } else if (prop[1] == 'Socket') {
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
    print(hardwareType);
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

  void completeHardware_lists() {
    checkTheHardware_list(cpuhardware_list, 'CPU_2');
    checkTheHardware_list(gpuhardware_list, 'GPU');
    checkTheHardware_list(casehardware_list, 'Case');
    checkTheHardware_list(mBhardware_list, 'Motherboard');
    checkTheHardware_list(rAMhardware_list, 'Memory');
    checkTheHardware_list(storagehardware_list, 'Storage');
    checkTheHardware_list(coolerhardware_list, 'CPU Cooler');
    checkTheHardware_list(powersupplayhardware_list, 'Power Supply');
  }

  void checkTheHardware_list(List<ModelProvider> hardwarelist, String type) {
    if (hardwarelist.length < 5) {
      //get five hardware from the same type from backend
    } else if (hardwarelist.length >= 5) {
      filterByApplication(hardwarelist, weight);
    }
  }

  void filterByApplication(List<ModelProvider> hardwarelist, int weight) {}
}
