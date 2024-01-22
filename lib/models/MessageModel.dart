class MessageModel {
  final int id;
  final String content;
  final int ToID;
  final int FromID;

  MessageModel(
      {required this.id,
      required this.content,
      required this.ToID,
      required this.FromID});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['ID'] as int,
      content: json['MessageText'] ?? "",
      ToID: json['ToID'] ?? 0 as int,
      FromID: json['FromID'] ?? 0 as int,
    );
  }
}

class MessageConvert {
  final dynamic au;
  final String cont;
  MessageConvert({
    required this.au,
    required this.cont,
  });
  factory MessageConvert.fromJson(Map<String, dynamic> json) {
    return MessageConvert(
      cont: json['MessageText'] ?? "",
      au: json['FromID'] ?? 0,
    );
  }
}
