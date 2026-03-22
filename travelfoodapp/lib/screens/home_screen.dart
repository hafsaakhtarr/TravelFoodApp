import 'package:flutter/material.dart';
import '../data/sample_restaurants.dart';
import '../widgets/restaurant_card.dart';

class HomeScreen extends StatefulWidget {
  final List<String> selectedDietary;
  final List<String> selectedCuisines;

  const HomeScreen({
    super.key,
    required this.selectedDietary,
    required this.selectedCuisines,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Search restaurants...............',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              if (widget.selectedDietary.isNotEmpty ||
                  widget.selectedCuisines.isNotEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...widget.selectedDietary.map(
                        (item) => Chip(label: Text(item)),
                      ),
                      ...widget.selectedCuisines.map(
                        (item) => Chip(label: Text(item)),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: sampleRestaurants.length,
                  itemBuilder: (context, index) {
                    return RestaurantCard(
                      restaurant: sampleRestaurants[index],
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}