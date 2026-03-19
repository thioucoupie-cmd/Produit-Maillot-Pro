import 'package:produit_maillot_pro/features/catalogue/models/product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final String selectedSize;

  CartItem({
    required this.product,
    this.quantity = 1,
    required this.selectedSize,
  });

  CartItem copyWith({
    Product? product,
    int? quantity,
    String? selectedSize,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }

  double get total => product.price * quantity;
}
