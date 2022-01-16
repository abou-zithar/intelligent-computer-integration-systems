class pcModel {
  pcModel(
      {this.CPUid = '',
      this.Caseid = '',
      this.GPUid = '',
      this.MotherBoardid = '',
      this.RAMid = '',
      this.Storageid = '',
      this.id = '',
      this.Price = 0.0,
      this.Rate = 0.0,
      this.Title = ''});

  final String id;
  final String CPUid;
  final String GPUid;
  final String RAMid;
  final String Storageid;
  final String Caseid;
  final String MotherBoardid;
  final double Price;
  final double Rate;
  final String Title;
  static List<pcModel> ModelsList = <pcModel>[
    pcModel(
        CPUid: 'intel',
        GPUid: 'rtx3060',
        RAMid: '16GB',
        Rate: 4.9,
        Storageid: '1T',
        Title: 'model 1',
        Price: 12000.32,
        Caseid: 'mid',
        id: '1'),
    pcModel(
        CPUid: 'AMD',
        GPUid: 'rtx3060',
        RAMid: '32GB',
        Rate: 4.9,
        Storageid: '2T',
        Title: 'model 2',
        Price: 43000.32,
        Caseid: 'large',
        id: '2'),
  ];
}
