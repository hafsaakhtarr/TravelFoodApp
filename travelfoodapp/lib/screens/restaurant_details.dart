import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final Restaurant restaurant;
  final Function(Restaurant) onFavoriteToggle;

  const RestaurantDetailsScreen({
    Key? key,
    required this.restaurant,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  State<RestaurantDetailsScreen> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  late Restaurant _currentRestaurant;

  @override
  void initState() {
    super.initState();
    _currentRestaurant = widget.restaurant;
  }

  void _toggleFavorite() {
    setState(() {
      _currentRestaurant = _currentRestaurant.copyWith(
        isFavorite: !_currentRestaurant.isFavorite,
      );
    });
    widget.onFavoriteToggle(_currentRestaurant);
  }

  String _getImagePath(String cuisine) {
    switch (cuisine.toLowerCase()) {
      case 'chinese':
        return 'assets/images/chinese.jpeg';
      case 'indian':
        return 'assets/images/indian.jpeg';
      case 'vegetarian':
        return 'assets/images/veg.jpeg';
      case 'italian':
        return 'assets/images/pasta.jpeg';
      default:
        return 'assets/images/pasta.jpeg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _currentRestaurant.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _currentRestaurant.isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
        title: const Text('Restaurant Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey[300],
              child: Image.asset(
                _getImagePath(_currentRestaurant.cuisine),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 80,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),

            // Restaurant Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Cuisine
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _currentRestaurant.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _currentRestaurant.cuisine,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Rating and Distance
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        '${_currentRestaurant.rating}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Icon(Icons.location_on, color: Colors.deepOrange),
                      const SizedBox(width: 8),
                      Text(
                        '${_currentRestaurant.distanceMiles} miles away',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Divider(color: Colors.grey[300]),

            // Quick Info Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Restaurant Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoTile(
                    Icons.restaurant_menu,
                    'Cuisine',
                    _currentRestaurant.cuisine,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoTile(
                    Icons.star_rate,
                    'Rating',
                    '${_currentRestaurant.rating} out of 5.0',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoTile(
                    Icons.directions_walk,
                    'Distance',
                    '${_currentRestaurant.distanceMiles} miles',
                  ),
                ],
              ),
            ),

            Divider(color: Colors.grey[300]),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Actions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _toggleFavorite,
                      icon: Icon(
                        _currentRestaurant.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: Text(
                        _currentRestaurant.isFavorite
                            ? 'Remove from Favorites'
                            : 'Add to Favorites',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentRestaurant.isFavorite
                            ? Colors.red
                            : Colors.deepOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.deepOrange, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}