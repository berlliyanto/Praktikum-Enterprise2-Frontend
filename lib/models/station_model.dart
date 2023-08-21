// ignore_for_file: non_constant_identifier_names

class CountingModel{
  late String? countGood, countBad;

  CountingModel({this.countBad,this.countGood});

  factory CountingModel.FromJSON(Map<String,dynamic>json){
    return CountingModel(
      countBad: json['Good'],
      countGood: json['Bad']
    );
  }
}

class IndikatorModel{
  late String? emg, running, stop, izinPLC;

  IndikatorModel({this.running,this.emg, this.stop,this.izinPLC});

  factory IndikatorModel.FromJSON(Map<String,dynamic>json){
    return IndikatorModel(
      running: json['running'],
      emg: json['emg'],
      stop: json['stop'],
      izinPLC: json['izinplc'],
    );
  }
}

class HistoryModel{
  late String? tanggal, totalData, totalMasuk, totalStamped, totalVerfied,avgCycle;

  HistoryModel({this.tanggal,this.totalData,this.totalMasuk,this.totalStamped,this.totalVerfied,this.avgCycle});

  factory HistoryModel.FromJSON(Map<String, dynamic> json){
    return HistoryModel(
      tanggal: json['tanggal'],
      totalData: json['totalData'],
      totalMasuk: json['totalMasuk'],
      totalStamped: json['totalStamped'],
      totalVerfied: json['totalVerified'],
      avgCycle: json['averageCycle']
    );
  }
}

class EMGHistoryModel{
  late String? id,tanggal,emgStatus;
  EMGHistoryModel({this.id, this.emgStatus,this.tanggal});

  factory EMGHistoryModel.FromJSON(Map<String, dynamic>json){
    return EMGHistoryModel(
      id: json['id'],
      tanggal: json['tanggal'],
      emgStatus: json['emgstatus']
    );
  }
}