class Restaurant {
  final String name;
  final double rating;
  final double distanceMiles;
  final String cuisine;
  final bool isFavorite;

  const Restaurant({
    required this.name,
    required this.rating,
    required this.distanceMiles,
    required this.cuisine,
    this.isFavorite = false,
  });

  Restaurant copyWith({
    String? name,
    double? rating,
    double? distanceMiles,
    String? cuisine,
    bool? isFavorite,
  }) {
    return Restaurant(
      name: name ?? this.name,
      rating: rating ?? this.rating,
      distanceMiles: distanceMiles ?? this.distanceMiles,
      cuisine: cuisine ?? this.cuisine,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}