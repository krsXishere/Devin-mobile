class CountPCModel {
  int? id;
  String? message, data;

  CountPCModel({
    required this.id,
    required this.data,
    required this.message,
  });

  factory CountPCModel.getData(Map<String, dynamic> object) {
    return CountPCModel(
      id: object['id'],
      data: object['data'],
      message: object['message'],
    );
  }
}
