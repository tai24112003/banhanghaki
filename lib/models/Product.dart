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
    idCategory: json['CategoryID'] ?? 0 as int, 
   image: (json['Image'] != null && json['Image']['data'] is List<dynamic>)
        ? (json['Image']['data'] as List<dynamic>).cast<int>().toList()
        : List<int>.empty(),
    name: json['ProductName'] ?? "",
    price: (json['Price'] as num?)?.toDouble() ?? 0.0,
    description: json['Description'] ?? "",
  );
}

Map<String, dynamic> toJson() {
  return {
    'ID': id,
    'CategoryID': idCategory,
    'Image': image,
    'Quantity': quantity,
    'ProductName': name,
    'Price': price,
    'Description': description,
  };
}

}
