import 'dart:typed_data';

class Product {
  final int? id;
  final int quantity;
  final int idCategory;
  final List<int> image;
  final String name;
  final double price;
  final String description;

  Product({
    required this.id,
    required this.image,
    required this.idCategory,
    required this.name,
    required this.quantity,
    required this.price,
    required this.description,
  });
  @override
  String toString() {
    return 'Product {'
        ' ID: $id,'
        ' Quantity: $quantity,'
        ' CategoryID: $idCategory,'
        // ' Image: ${image.toString()},'
        ' ProductName: $name,'
        ' Price: $price,'
        ' Description: $description'
        ' }';
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    dynamic imageValue = json['Image'];
    List<int> imageData = _getImageBytes(imageValue);

    return Product(
      id: json['ID'] as int?,
      quantity: json['Quantity'] ?? 0,
      idCategory: json['CategoryID'] ?? 0,
      image: imageData,
      name: json['ProductName'] ?? "",
      price: (json['Price'] as num?)?.toDouble() ?? 0.0,
      description: json['Description'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CategoryID': idCategory,
      // 'Image': image,
      'Quantity': quantity,
      'ProductName': name,
      'Price': price,
      'Description': description,
    };
  }

  static List<int> _getImageBytes(dynamic imageData) {
    if (imageData != null && imageData['data'] is List<dynamic>) {
      List<dynamic> dataList = imageData['data'];
      return dataList.map<int>((value) => value as int).toList();
    } else {
      return [];
    }
  }
}
