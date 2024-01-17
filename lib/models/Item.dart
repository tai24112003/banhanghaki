class Product {
  final int id;
  final int quantity;
  final String color;
  final int idCategory;

  final String image;
  final String name;
  final double price;
  final String description;

  Product(
      {required this.id,
      required this.image,
      required this.idCategory,
      required this.name,
      required this.quantity,
      required this.color,
      required this.price,
      required this.description});
}
