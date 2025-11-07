import 'package:flutter/material.dart';

class HomeIndexPage extends StatelessWidget {
  const HomeIndexPage({super.key});

  // Widget untuk info kecil di cuaca
  Widget _infoTile(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Data cuaca
    final mainCity = {
      'name': 'Bandung',
      'temperature': 32,
      'humidity': 70,
      'wind': 12,
      'condition': 'Cerah Berawan',
      'icon': Icons.wb_sunny_outlined,
    };

    // Data berita statis
    final newsList = [
      {
        "judul": "Korea Utara Luncurkan Rudal ke 1 Negara",
        "tanggal": "2025-11-01",
        "author": "Kim Jong News",
      },
      {
        "judul": "Korea Utara Luncurkan Rudal ke 2 Negara",
        "tanggal": "2025-11-02",
        "author": "Kim Jong News",
      },
      {
        "judul": "Korea Utara Luncurkan Rudal ke 3 Negara",
        "tanggal": "2025-11-03",
        "author": "Kim Jong News",
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari...',
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
            child: Column(
              children: [
                Text(
                  mainCity['name'] as String,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 8),
                Icon(mainCity['icon'] as IconData, size: 64, color: Colors.orange),
                const SizedBox(height: 8),
                Text(
                  '${mainCity['temperature']}°C',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  mainCity['condition'] as String,
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _infoTile(Icons.water_drop, 'Kelembaban', '${mainCity['humidity']}%'),
                    _infoTile(Icons.air, 'Angin', '${mainCity['wind']} km/h'),
                  ],
                ),
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

          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                return Container(
                  width: 250,
                  margin: const EdgeInsets.only(right: 12),
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
                        news['judul']!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        news['author']!,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        news['tanggal']!,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
