import 'dart:convert';
import 'package:http/http.dart' as http;
import '../common/global.dart' as global;

class SpesificationModel {
  String pcName, os, processor, ram, vgaCard, storage, lab, table;
  int id, code;

  SpesificationModel({
    required this.id,
    required this.pcName,
    required this.os,
    required this.processor,
    required this.ram,
    required this.vgaCard,
    required this.storage,
    required this.lab,
    required this.table,
    required this.code,
  });

  factory SpesificationModel.getData(Map<String, dynamic> object) {
    return SpesificationModel(
      id: object["data"]["id"],
      pcName: object["data"]["pc_name"],
      os: object["data"]["os"],
      processor: object["data"]["processor"],
      ram: object["data"]["ram"],
      vgaCard: object["data"]["kartu_grafik"],
      storage: object["data"]["penyimpanan"],
      lab: object["data"]["lab"],
      table: object["data"]["nomor_meja"],
      code: object["code"],
    );
  }

  static Future<SpesificationModel> sendRequest(String? id) async {
    String apiURL = "${global.apiHosted}/spesifikasi/$id";
    var repsonse = await http.get(
      Uri.parse(apiURL),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    var jsonObject = jsonDecode(repsonse.body);
    var data = (jsonObject as Map<String, dynamic>);
    return SpesificationModel.getData(data);
  }
}
