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
        idCategory: json['Category'] ?? 0 as int,
        image: json['Image'] ?? List<int>.empty() as List<int>,
        name: json['ProductName'],
        price: json['Price'].toDouble(),
        description: json['Description'] ?? "");
  }
}
