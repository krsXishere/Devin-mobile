import 'package:devin/models/count_pc_model.dart';
import 'package:devin/repositories/count_pc_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/count_pc_hosted_repository.dart';

var countPCRepository = Provider(
  (ref) => CountPCRepository(),
);

var countPCProvider =
    FutureProvider.autoDispose.family<CountPCModel?, int>((ref, id) async {
  var countPC = await ref.watch(countPCRepository).getDataCountPC(id);
  ref.keepAlive();

  return countPC;
});

var countPCHostedRepository = Provider(
  (ref) => CountPCHostedRepository(),
);

var countPCHostedProvider =
    FutureProvider.autoDispose.family<CountPCModel?, int>((ref, id) async {
  var countPC = await ref.watch(countPCHostedRepository).getDataCountPC(id);
  ref.keepAlive();

  return countPC;
});
