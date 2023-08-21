// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/foundation.dart';
import 'package:flutter_user_interface/models/station_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetCountingProduct {
  Future conting() async {
    Uri url = Uri.parse("http://172.20.10.7/ENA2/pickplace.php?method=count");
    var response = await http.get(url,
        headers: <String, String>{'Content-Type': 'application/json'});
    var data = json.decode(response.body)['data'];
    String verified = data['verified'];
    String stamped = data['stamped'];
    String mulai = data['mulai'];
    String cycle = data['cycle'];
    return {'verified':verified,'stamped': stamped, 'mulai': mulai, 'cycle':cycle};
  }
}

class ResetCounting {
  static Future reset() async {
    Uri url = Uri.parse("http://172.20.10.7/ENA2/pickplace.php?method=reset");
    var response = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return true;
    }else{
      return false;
    }
  }
}

class AmountBK{
  Future getAmount() async {
    Uri url = Uri.parse("http://172.20.10.7/ENA2/pickplace.php?method=getAmount");
    var response = await http.get(url,
        headers: <String, String>{'Content-Type': 'application/json'});
    var data = json.decode(response.body)['data'];
    String amount = data[0]['amount'];
    return {'amount': amount};
  }

  static Future tambahBK(String jumlah) async {
    Uri url = Uri.parse("http://172.20.10.7/ENA2/pickplace.php?method=tambah");
    var response = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({
          "value": jumlah
        }));
    if (response.statusCode == 200) {
      return true;
    }else{
      return false;
    }
  }
}

class IndikatorPlant{
  Future indikator() async {
    Uri url = Uri.parse("http://172.20.10.7/ENA2/indikator.php");
    var response = await http.get(url,
        headers: <String, String>{'Content-Type': 'application/json'});
    Iterable it = (json.decode(response.body) as Map<String, dynamic>)['data'];
    List<IndikatorModel> getIndikator= it.map((e) => IndikatorModel.FromJSON(e)).toList();
    return getIndikator;
  }
}

class HistoryCount {
  Future history()async {
    Uri url = Uri.parse("http://172.20.10.7/ENA2/pickplace.php?method=history");

    var response = await http.get(url,
        headers: <String, String>{'Content-Type': 'application/json'});
    Iterable it = (json.decode(response.body) as Map<String, dynamic>)['data'];
    List<HistoryModel> getHistory= it.map((e) => HistoryModel.FromJSON(e)).toList();
    return getHistory;
  }

  Future historyFilter(String startDate, String endDate) async {
    Uri url = Uri.parse("http://172.20.10.7/ENA2/pickplace.php?method=history&startDate=$startDate&endDate=$endDate");
    var response = await http.get(url,
        headers: <String, String>{'Content-Type': 'application/json'});
    Iterable it = (json.decode(response.body) as Map<String, dynamic>)['data'];
    List<HistoryModel> getHistory= it.map((e) => HistoryModel.FromJSON(e)).toList();
    return getHistory;
  }
}

class EMGHistory {
  Future historyEMG() async {
    Uri url = Uri.parse("http://172.20.10.7/ENA2/emg.php");
    var response = await http.get(url,
        headers: <String, String>{'Content-Type': 'application/json'});
    Iterable it = (json.decode(response.body) as Map<String, dynamic>)['data'];
    List<EMGHistoryModel> getHistory= it.map((e) => EMGHistoryModel.FromJSON(e)).toList();
    return getHistory;
  }

}