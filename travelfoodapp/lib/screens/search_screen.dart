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
  final TextEditingController _locationController = TextEditingController();
  
  late List<Restaurant> _filteredRestaurants = List.from(sampleRestaurants);
  late List<Restaurant> _allRestaurants = List.from(sampleRestaurants);

  // Filter variables
  String _selectedCuisine = 'All';
  double _minRating = 0;
  double _maxDistance = 10;
  String _selectedLocation = 'All Locations';
  double _userDistance = 5; // Default user distance in miles

  final List<String> _cuisines = [
    'All',
    'Italian',
    'Indian',
    'Chinese',
    'Japanese',
    'Mexican',
    'Vegetarian',
  ];

  // Sample locations
  final List<String> _locations = [
    'All Locations',
    'Downtown',
    'Midtown',
    'East Side',
    'West District',
    'Old Town',
    'Chinatown',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterRestaurants);
    _locationController.addListener(_filterRestaurants);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _locationController.dispose();
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

        // Filter by location (extract location from address)
        final restaurantLocation = _extractLocation(restaurant);
        final matchesLocation = _selectedLocation == 'All Locations' ||
            restaurantLocation == _selectedLocation;

        return matchesSearch &&
            matchesCuisine &&
            matchesRating &&
            matchesDistance &&
            matchesLocation;
      }).toList();
    });
  }

  String _extractLocation(Restaurant restaurant) {
    // Extract location from restaurant address
    // Example: "123 Maple St, Downtown" -> "Downtown"
    // For now, map restaurants to mock locations
    final locationMap = {
      'Pasta Bella': 'Downtown',
      'Spice Garden': 'Midtown',
      'Dragon Bowl': 'East Side',
      'Green Leaf Kitchen': 'East Side',
      'Sakura Sushi': 'Downtown',
      'Taco Fiesta': 'West District',
    };
    return locationMap[restaurant.name] ?? 'Unknown';
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _locationController.clear();
      _selectedCuisine = 'All';
      _minRating = 0;
      _maxDistance = 10;
      _selectedLocation = 'All Locations';
      _userDistance = 5;
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
            title: const Text('Filters & Location',
                style: TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location Filter
                    const Text('Location',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: _selectedLocation,
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedLocation = newValue;
                            _filterRestaurants();
                          });
                        }
                      },
                      items: _locations
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
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
                    const SizedBox(height: 20),

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

          // Quick Filter Chips (Location)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Quick Location Search',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _locations
                        .map((location) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InputChip(
                            label: Text(location),
                            selected: _selectedLocation == location,
                            onSelected: (selected) {
                              setState(() {
                                _selectedLocation = location;
                                _filterRestaurants();
                              });
                            },
                            backgroundColor: _selectedLocation == location
                                ? Colors.deepOrange
                                : Colors.grey[200],
                            labelStyle: TextStyle(
                              color: _selectedLocation == location
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ))
                        .toList(),
                  ),
                ),
              ],
            ),
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
                      Icon(Icons.location_off,
                          size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No restaurants found',
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try different location or filters',
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
                    final location = _extractLocation(restaurant);
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Location Badge
                        if (index == 0 || _extractLocation(_filteredRestaurants[index - 1]) != location)
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(
                              location,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ),
                        RestaurantCard(
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
                        ),
                      ],
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}