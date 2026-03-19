class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> availableSizes;
  final String sport;
  final String team;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.availableSizes,
    required this.sport,
    required this.team,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      availableSizes: List<String>.from(map['availableSizes'] ?? []),
      sport: map['sport'] ?? '',
      team: map['team'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'availableSizes': availableSizes,
      'sport': sport,
      'team': team,
    };
  }
}
