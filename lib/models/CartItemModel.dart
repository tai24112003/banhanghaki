import 'package:bangiayhaki/models/Product.dart';

class CartItemModel {
  final int id;
  final int idCart;
  final Product product;
  int quantity;
  final String status;

  CartItemModel(
      {required this.id,
      required this.idCart,
      required this.product,
      required this.quantity,
      required this.status});

  set setQuantity(int gt) {
    if (gt >= 0) quantity = gt;
  }

  Map<String, dynamic> toJson() {
    return {
      'ItemId': id,
      'CartID': idCart,
      'Product': product.toJson(),
      'CartQuan': quantity,
      'CartStatus': status,
    };
  }

  @override
  String toString() {
    return 'CartItemModel { '
        'id: $id, '
        'idCart: $idCart, '
        'product: $product, '
        'quantity: $quantity, '
        'status: $status'
        ' }';
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        id: json['ItemId'] ?? "0" as int,
        idCart: json['CartID'] ?? "0" as int,
        product: Product.fromJson({
          "ID": json['ProductID'],
          "Category": json['CategoryID'],
          "ProductName": json['ProductName'],
          "Image": json['Image'],
          "Quantity": json['Quantity'],
          "Price": json['Price'],
          "Description": json['Description'],
          "Status": json['ProStatus'],
        }),
        quantity: json['CartQuan'] ?? "0" as int,
        status: json['CartStatus'] ?? "");
  }
}
