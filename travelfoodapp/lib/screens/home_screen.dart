import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<String> selectedDietary;
  final List<String> selectedCuisines;

  const HomeScreen({
    super.key,
    required this.selectedDietary,
    required this.selectedCuisines,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your selected preferences:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('Dietary: ${selectedDietary.join(', ') == '' ? 'None' : selectedDietary.join(', ')}'),
            Text('Cuisines: ${selectedCuisines.join(', ') == '' ? 'None' : selectedCuisines.join(', ')}'),
            const SizedBox(height: 20),
            const Text('Recommended places will show here soon.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
