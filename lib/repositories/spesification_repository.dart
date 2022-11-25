import 'package:dio/dio.dart';
import '../models/spesification_model.dart';

class SpesificationRepository {
  final Dio? _dio;

  SpesificationRepository({Dio? dio}) : _dio = dio;

  Future<SpesificationModel?> getDataSpesification(String id) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    try {
      String apiURL = "http://192.100.103.58:8000/api/spesifikasi/$id";
      var response = await (_dio ?? Dio()).get(apiURL);
      return SpesificationModel.getData(response.data);
    } catch (e) {
      return null;
    }
  }
}
