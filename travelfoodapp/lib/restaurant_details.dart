import 'package:flutter/material.dart';
import 'restaurant.dart';

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
              child: Image.network(
                widget.restaurant.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(Icons.image_not_supported, size: 80, color: Colors.grey[600]),
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
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _currentRestaurant.cuisine,
                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Rating and Reviews
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        '${_currentRestaurant.rating}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${_currentRestaurant.reviewCount} reviews)',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Divider
            Divider(color: Colors.grey[300]),
 
            // Info Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
 
                  // Address
                  _buildInfoRow(Icons.location_on, 'Address', _currentRestaurant.address),
                  const SizedBox(height: 12),
 
                  // Phone
                  _buildInfoRow(Icons.phone, 'Phone', _currentRestaurant.phone),
                  const SizedBox(height: 12),
 
                  // Hours
                  _buildInfoRow(Icons.access_time, 'Hours', _currentRestaurant.hours),
                ],
              ),
            ),
 
            Divider(color: Colors.grey[300]),
 
            // Description Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _currentRestaurant.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
                  ),
                ],
              ),
            ),
 
            Divider(color: Colors.grey[300]),

           // Dietary Tags
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dietary Options',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _currentRestaurant.dietaryTags
                        .map((tag) => Chip(
                          label: Text(tag, style: const TextStyle(fontSize: 12)),
                          backgroundColor: Colors.orangeAccent[100],
                          side: BorderSide(color: Colors.orangeAccent.shade400),
                        ))
                        .toList(),
                  ),
                ],
              ),
            ),
 
            Divider(color: Colors.grey[300]),
 
            // Special Dishes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Signature Dishes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(
                    _currentRestaurant.specialDishes.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.star_half, color: Colors.amber, size: 16),
                          const SizedBox(width: 8),
                          Text(_currentRestaurant.specialDishes[index]),
                        ],
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
 
  

  
}