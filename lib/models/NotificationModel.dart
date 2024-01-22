class Notifications {
  final int id;
  final String name;
  final String content;
  final String notificationType;
  final int userID;

  Notifications({
    required this.id,
    required this.name,
    required this.content,
    required this.notificationType,
    required this.userID,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['ID'] as int,
      name: json['Name'] ?? "",
      content: json['Content'] ?? "",
      notificationType: json['NotificationType'] ?? "",
      userID: json['UserID'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'Content': content,
      'NotificationType': notificationType,
      'UserID': userID,
    };
  }
}
