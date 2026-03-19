import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:produit_maillot_pro/features/catalogue/models/product.dart';

final productsProvider = Provider<List<Product>>((ref) {
  return [
    Product(
      id: '1',
      name: 'Maillot Domicile 2024/25',
      description: 'Le maillot officiel domicile pour la nouvelle saison.',
      price: 45000,
      imageUrl: '',
      availableSizes: ['S', 'M', 'L', 'XL'],
      sport: 'Football',
      team: 'Sénégal',
    ),
    Product(
      id: '2',
      name: 'Maillot Extérieur 2024/25',
      description: 'Design moderne et épuré pour les matchs à l\'extérieur.',
      price: 45000,
      imageUrl: '',
      availableSizes: ['S', 'M', 'L', 'XL'],
      sport: 'Football',
      team: 'Sénégal',
    ),
    Product(
      id: '3',
      name: 'Maillot Jordan Statement',
      description: 'Édition spéciale pour les fans de basketball.',
      price: 55000,
      imageUrl: '',
      availableSizes: ['M', 'L', 'XL'],
      sport: 'Basketball',
      team: 'Stade de Mbour',
    ),
    Product(
      id: '4',
      name: 'Veste de survêtement Elite',
      description: 'Veste de performance pour l\'entraînement.',
      price: 35000,
      imageUrl: '',
      availableSizes: ['S', 'M', 'L'],
      sport: 'Training',
      team: 'Generic',
    ),
  ];
});
