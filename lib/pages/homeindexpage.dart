import 'package:flutter/material.dart';

class HomeIndexPage extends StatelessWidget {
  const HomeIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherData = {
      'name': 'Bandung',
      'temperature': 32,
      'humidity': 70,
      'wind': 12,
      'condition': 'Cerah Berawan',
      'icon': Icons.wb_sunny_outlined,
    };

    final newsList = [
      {'title': 'Berita 1', 'snippet': 'Ini cuplikan berita 1...'},
      {'title': 'Berita 2', 'snippet': 'Ini cuplikan berita 2...'},
      {'title': 'Berita 3', 'snippet': 'Ini cuplikan berita 3...'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari berita...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(weatherData['icon'] as IconData, size: 48, color: Colors.orange),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weatherData['name'] as String,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${weatherData['temp']}°C - ${weatherData['desc']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Berita Terkini',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
          ),
          const SizedBox(height: 12),

          Column(
            children: newsList.map((news) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: const Offset(0, 2)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news['title'] ?? 'No Title',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      news['snippet'] ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}