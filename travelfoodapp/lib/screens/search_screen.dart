import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../data/sample_restaurants.dart';
import '../widgets/restaurant_card.dart';
import 'restaurant_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Restaurant> _filteredRestaurants = List.from(sampleRestaurants);
  late List<Restaurant> _allRestaurants = List.from(sampleRestaurants);

  // Filter variables
  String _selectedCuisine = 'All';
  double _minRating = 0;
  double _maxDistance = 10;

  final List<String> _cuisines = [
    'All',
    'Italian',
    'Indian',
    'Chinese',
    'Japanese',
    'Mexican',
    'Vegetarian',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterRestaurants);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRestaurants() {
    setState(() {
      _filteredRestaurants = _allRestaurants.where((restaurant) {
        // Search by name
        final matchesSearch = restaurant.name
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());

        // Filter by cuisine
        final matchesCuisine =
            _selectedCuisine == 'All' || restaurant.cuisine == _selectedCuisine;

        // Filter by rating
        final matchesRating = restaurant.rating >= _minRating;

        // Filter by distance
        final matchesDistance = restaurant.distanceMiles <= _maxDistance;

        return matchesSearch &&
            matchesCuisine &&
            matchesRating &&
            matchesDistance;
      }).toList();
    });
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedCuisine = 'All';
      _minRating = 0;
      _maxDistance = 10;
      _filterRestaurants();
    });
  }

  void _navigateToDetails(Restaurant restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailsScreen(
          restaurant: restaurant,
          onFavoriteToggle: (updatedRestaurant) {
            setState(() {
              final index = _filteredRestaurants
                  .indexWhere((r) => r.name == updatedRestaurant.name);
              if (index != -1) {
                _filteredRestaurants[index] = updatedRestaurant;
              }
              final allIndex = _allRestaurants
                  .indexWhere((r) => r.name == updatedRestaurant.name);
              if (allIndex != -1) {
                _allRestaurants[allIndex] = updatedRestaurant;
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by restaurant name...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),

          // Filters Section (Expandable)
          ExpansionTile(
            title:
                const Text('Filters', style: TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cuisine Filter
                    const Text('Cuisine',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _cuisines
                          .map((cuisine) => FilterChip(
                            label: Text(cuisine),
                            selected: _selectedCuisine == cuisine,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCuisine = cuisine;
                                _filterRestaurants();
                              });
                            },
                            backgroundColor: Colors.grey[200],
                            selectedColor: Colors.deepOrange,
                            labelStyle: TextStyle(
                              color: _selectedCuisine == cuisine
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),

                    // Rating Filter
                    const Text('Minimum Rating',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 8),
                    Slider(
                      value: _minRating,
                      min: 0,
                      max: 5,
                      divisions: 10,
                      label: _minRating.toStringAsFixed(1),
                      activeColor: Colors.deepOrange,
                      onChanged: (value) {
                        setState(() {
                          _minRating = value;
                          _filterRestaurants();
                        });
                      },
                    ),
                    Text('${_minRating.toStringAsFixed(1)} ⭐ and above'),
                    const SizedBox(height: 20),

                    // Distance Filter
                    const Text('Maximum Distance',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 8),
                    Slider(
                      value: _maxDistance,
                      min: 0.5,
                      max: 10,
                      divisions: 19,
                      label: '${_maxDistance.toStringAsFixed(1)} mi',
                      activeColor: Colors.deepOrange,
                      onChanged: (value) {
                        setState(() {
                          _maxDistance = value;
                          _filterRestaurants();
                        });
                      },
                    ),
                    Text('Within ${_maxDistance.toStringAsFixed(1)} miles'),
                    const SizedBox(height: 16),

                    // Reset Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                        ),
                        onPressed: _resetFilters,
                        child: const Text('Reset Filters'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '${_filteredRestaurants.length} result${_filteredRestaurants.length != 1 ? 's' : ''} found',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500),
            ),
          ),

          // Results List
          Expanded(
            child: _filteredRestaurants.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off,
                          size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No restaurants found',
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try adjusting your filters',
                        style:
                            TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = _filteredRestaurants[index];
                    return RestaurantCard(
                      restaurant: restaurant,
                      onTap: () => _navigateToDetails(restaurant),
                      onFavoriteTap: () {
                        setState(() {
                          final updatedRestaurant = restaurant.copyWith(
                            isFavorite: !restaurant.isFavorite,
                          );
                          final idx = _filteredRestaurants.indexWhere(
                              (r) => r.name == restaurant.name);
                          if (idx != -1) {
                            _filteredRestaurants[idx] = updatedRestaurant;
                          }
                          final allIdx = _allRestaurants
                              .indexWhere((r) => r.name == restaurant.name);
                          if (allIdx != -1) {
                            _allRestaurants[allIdx] = updatedRestaurant;
                          }
                        });
                      },
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}