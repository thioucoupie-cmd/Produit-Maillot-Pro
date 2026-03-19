import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:produit_maillot_pro/features/cart/models/cart_item.dart';
import 'package:produit_maillot_pro/features/catalogue/models/product.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(Product product, String size) {
    final existingIndex = state.indexWhere(
      (item) => item.product.id == product.id && item.selectedSize == size,
    );

    if (existingIndex != -1) {
      final updatedItem = state[existingIndex].copyWith(
        quantity: state[existingIndex].quantity + 1,
      );
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex) updatedItem else state[i],
      ];
    } else {
      state = [...state, CartItem(product: product, selectedSize: size)];
    }
  }

  void removeItem(String productId, String size) {
    state = state.where(
      (item) => !(item.product.id == productId && item.selectedSize == size),
    ).toList();
  }

  void updateQuantity(String productId, String size, int quantity) {
    if (quantity <= 0) {
      removeItem(productId, size);
      return;
    }
    state = [
      for (final item in state)
        if (item.product.id == productId && item.selectedSize == size)
          item.copyWith(quantity: quantity)
        else
          item,
    ];
  }

  double get totalAmount {
    return state.fold(0, (previousValue, element) => previousValue + element.total);
  }

  int get itemCount {
    return state.fold(0, (previousValue, element) => previousValue + element.quantity);
  }

  void clearCart() {
    state = [];
  }
}
