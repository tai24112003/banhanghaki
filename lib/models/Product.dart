class Product {
  final int id;
  final int quantity;
  final int idCategory;

  final List<int> image;
  final String name;
  final double price;
  final String description;

  Product(
      {required this.id,
      required this.image,
      required this.idCategory,
      required this.name,
      required this.quantity,
      required this.price,
      required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['ID'] as int,
    quantity: json['Quantity'] ?? 0 as int,
    idCategory: json['CategoryID'] ?? 0 as int, // Thay đổi key từ 'Category' thành 'CategoryID'
    image: (json['Image'] as List<dynamic>?)?.cast<int>() ?? List<int>.empty(), // Chuyển đổi thành List<int>
    name: json['ProductName'] ?? "", // Đảm bảo giá trị không bị null
    price: (json['Price'] as num?)?.toDouble() ?? 0.0, // Chuyển đổi thành double
    description: json['Description'] ?? "",
  );
}

Map<String, dynamic> toJson() {
  return {
    'ID': id,
    'CategoryID': idCategory, // Thay đổi key thành 'CategoryID'
    'Image': image,
    'Quantity': quantity,
    'ProductName': name,
    'Price': price,
    'Description': description,
  };
}

}
