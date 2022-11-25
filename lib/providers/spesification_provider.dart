import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/spesification_model.dart';
import '../repositories/spesification_repository.dart';

var spesificationRepositoriesProvider = Provider(
  (ref) => (SpesificationRepository()),
);

var spesificationProvider = FutureProvider.autoDispose
    .family<SpesificationModel?, String>((ref, id) async {
  var spesification =
      ref.watch(spesificationRepositoriesProvider).getDataSpesification(id);
  ref.keepAlive();
  return spesification;
});
