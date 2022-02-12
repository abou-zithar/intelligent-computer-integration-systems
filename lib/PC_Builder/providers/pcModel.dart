import 'package:flutter/material.dart';

class PcModel with ChangeNotifier {
  PcModel(
      {this.CPUtitle = '',
      this.Caseid = '',
      this.GPUid = '',
      this.MotherBoardid = '',
      this.RAMid = '',
      this.Storageid = '',
      this.id = '',
      this.Price = 0.0,
      this.Rate = 0.0,
      this.Title = '',
      this.coolerid = '',
      this.powersupply = ''});

  final String id;
  final String CPUtitle;
  final String GPUid;
  final String RAMid;
  final String Storageid;
  final String Caseid;
  final String coolerid;
  final String powersupply;
  final String MotherBoardid;
  final double Price;
  final double Rate;
  final String Title;
  List<PcModel> _pcList = <PcModel>[
   
  ];
  List<PcModel> get items {
    return [..._pcList];
  }

  void addpcmodel(
      String CPUtitle,
      String caseid,
      String gpuid,
      String motherBoardid,
      String powersupplyid,
      String ramid,
      String storageid,
      String coolerid,
      double price,
      double Rate,
      String title) {
    _pcList.add(PcModel(
      CPUtitle: CPUtitle,
      Caseid: caseid,
      GPUid: gpuid,
      MotherBoardid: motherBoardid,
      RAMid: ramid,
      Storageid: storageid,
      coolerid: coolerid,
      powersupply: powersupplyid,
      Price: price,
      Rate: Rate,
      Title: title,
    ));
  }
}
