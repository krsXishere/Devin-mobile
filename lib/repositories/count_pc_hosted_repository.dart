import 'dart:developer';
import 'package:dio/dio.dart';
import '../models/count_pc_model.dart';
import '../common/global.dart' as global;

class CountPCHostedRepository {
  final Dio? _dio;

  CountPCHostedRepository({
    Dio? dio,
  }) : _dio = dio;

  Future<CountPCModel?> getDataCountPC(int id) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    try {
      String apiURL = "${global.apiHosted}/count/$id";
      var response = await (_dio ?? Dio()).get(
        apiURL,
      );
      log(response.data.toString());

      return CountPCModel.getData(response.data);
    } catch (e) {
      return null;
    }
  }
}
