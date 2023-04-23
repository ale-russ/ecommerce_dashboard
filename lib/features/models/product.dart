import 'dart:convert';

class Product {
  final String? name;
  final String? price;
  final String? imageURL;
  final String? description;

  Product({
    this.name,
    this.price,
    this.imageURL,
    this.description,
  });
  Product copyWith({
    String? name,
    String? price,
    String? imageURL,
    String? description,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      imageURL: imageURL ?? this.imageURL,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'imageURL': imageURL,
      'description': description
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      imageURL: map['imageURL'] != null ? map['imageURL'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'products(name: $name, price: $price, imageURL: $imageURL, description: $description)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
    return other.name == name &&
        other.price == price &&
        other.imageURL == imageURL &&
        other.description == description;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        price.hashCode ^
        imageURL.hashCode ^
        description.hashCode;
  }
}
