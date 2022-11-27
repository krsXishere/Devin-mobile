import 'dart:developer';

import 'package:dio/dio.dart';
import '../models/spesification_model.dart';
import '../common/global.dart' as global;

class SpesificationRepository {
  final Dio? _dio;

  SpesificationRepository({Dio? dio}) : _dio = dio;

  Future<SpesificationModel?> getDataSpesification(String id) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    try {
      String apiURL = "${global.apiHosted}/spesifikasi/$id";
      var response = await (_dio ?? Dio()).get(apiURL);
      log("${response.data}");

      return SpesificationModel.getData(response.data);
    } catch (e) {
      return null;
    }
  }
}
