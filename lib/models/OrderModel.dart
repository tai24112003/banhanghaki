class Order {
  final int id;
  final int id_account;
  final int quantity;
  final DateTime date;
  final int totalAmount;
  final String status;

  Order({
    required this.id,
    required this.id_account,
    required this.quantity,
    required this.date,
    required this.totalAmount,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['ID'] as int,
      id_account: json['UserID'] as int,
      quantity: json['Quantity'] as int,
      date: json['OrderDate'] != null
          ? DateTime.parse(json['OrderDate'])
          : DateTime.now(),
      totalAmount: json['TotalAmount'] as int,
      status: json['Status'] as String,
    );
  }
}
