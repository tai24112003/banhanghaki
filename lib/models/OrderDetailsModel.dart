class OrderDetails {
  final int id;
  final int OrderID;
  final int quantity;
  final int productID;

  OrderDetails({
    required this.id,
    required this.OrderID,
    required this.quantity,
    required this.productID,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['ID'] as int,
      OrderID: json['OrderID'] as int,
      quantity: json['Quantity'] ?? 0 as int,
      productID: json['ProductID'] as int,
    );
  }
}
