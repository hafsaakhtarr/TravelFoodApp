import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../widgets/restaurant_card.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Restaurant> favoriteRestaurants;
  final ValueChanged<Restaurant> onFavoriteToggle;

  const FavoritesScreen({
    super.key,
    required this.favoriteRestaurants,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (favoriteRestaurants.isEmpty) {
      return const Center(
        child: Text(
          'No favorites added yet.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: favoriteRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = favoriteRestaurants[index];
                return RestaurantCard(
                  restaurant: restaurant,
                  onFavoriteTap: () => onFavoriteToggle(restaurant),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}