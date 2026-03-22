import 'package:flutter/material.dart';
import 'restaurant.dart';
import 'restaurant_details_screen.dart';
 
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
 
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}
 
class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<String> _collections = ['Must-Try', 'Budget-Friendly', 'Special Occasion'];
  late String _selectedCollection = _collections[0];
  final List<Restaurant> _favoriteRestaurants = [];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Collections Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: _collections
                  .map((collection) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(collection),
                      selected: _selectedCollection == collection,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedCollection = collection;
                          }
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Colors.orangeAccent,
                      labelStyle: TextStyle(
                        color: _selectedCollection == collection ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ))
                  .toList(),
            ),
          ),
          // Favorites List
          Expanded(
            child: _favoriteRestaurants.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No favorites yet',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Save restaurants to your favorites',
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _favoriteRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = _favoriteRestaurants[index];
                    return _buildFavoriteCard(restaurant);
                  },
                ),
          ),
        ],
      ),
    );
  }
 