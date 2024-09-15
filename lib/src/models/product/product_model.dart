class Product {
  String id;
  String productName;
  String productCategory;
  String description;
  double price;
  double discount;
  String image;
  bool isFavorite;
  bool isAddedToCart;

  Product({
    required this.id,
    required this.productName,
    required this.productCategory,
    required this.description,
    required this.price,
    required this.discount,
    required this.image,
    this.isFavorite = false,
    this.isAddedToCart = false,
  });
}
