class CartItemModel {
  final String id;
  final String productName;
  final String category;
  final double price;
   String quantity;
  CartItemModel({
    required this.productName,
    required this.category,
    required this.price,
    required this.quantity,
    required this.id,
  });
}
