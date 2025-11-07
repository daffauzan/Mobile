import 'package:flutter/material.dart';

class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> {
  final List<Map<String, dynamic>> _cities = [
    {
      'name': 'Bandung',
      'temperature': 32,
      'humidity': 70,
      'wind': 12,
      'condition': 'Cerah Berawan',
      'icon': Icons.wb_sunny_outlined,
    },
    {
      'name': 'Tasikmalaya',
      'temperature': 25,
      'humidity': 80,
      'wind': 9,
      'condition': 'Berawan',
      'icon': Icons.cloud_outlined,
    },
    {
      'name': 'Jakarta',
      'temperature': 34,
      'humidity': 68,
      'wind': 15,
      'condition': 'Panas Terik',
      'icon': Icons.wb_twilight_outlined,
    },
    {
      'name': 'Garut',
      'temperature': 28,
      'humidity': 75,
      'wind': 10,
      'condition': 'Hujan Ringan',
      'icon': Icons.water_drop_outlined,
    },
    {
      'name': 'Sumedang',
      'temperature': 30,
      'humidity': 77,
      'wind': 11,
      'condition': 'Cerah',
      'icon': Icons.wb_sunny,
    },
  ];

  final List<Map<String, dynamic>> _forecast = [
    {"day": "Senin", "temp": 32, "icon": Icons.wb_sunny, "desc": "Cerah"},
    {"day": "Selasa", "temp": 31, "icon": Icons.cloud, "desc": "Berawan"},
    {"day": "Rabu", "temp": 30, "icon": Icons.water_drop, "desc": "Hujan Ringan"},
    {"day": "Kamis", "temp": 33, "icon": Icons.wb_twilight, "desc": "Panas"},
    {"day": "Jumat", "temp": 29, "icon": Icons.storm, "desc": "Petir"},
  ];

  @override
  Widget build(BuildContext context) {
    final mainCity = _cities.first;
    final otherCities = _cities.sublist(1);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======= Kota Utama =======
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  mainCity['name'],
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 8),
                Icon(mainCity['icon'], size: 64, color: Colors.orange),
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
                  mainCity['condition'],
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _infoTile(Icons.water_drop, 'Kelembaban',
                        '${mainCity['humidity']}%'),
                    _infoTile(Icons.air, 'Angin', '${mainCity['wind']} km/h'),
                  ],
                ),
              ],
            ),
          ),

          // ======= Prediksi Cuaca =======
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Prakiraan 5 Hari ke Depan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _forecast.map((item) {
                        return Container(
                          width: 120, // sesuaikan lebar card
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item['day'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8),
                              Icon(item['icon'], color: Colors.orange, size: 32),
                              const SizedBox(height: 8),
                              Text(
                                '${item['temp']}°C',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['desc'],
                                style: const TextStyle(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),


          // ======= Kota Lainnya =======
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Kota Lainnya",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: otherCities.length,
              itemBuilder: (context, index) {
                final city = otherCities[index];
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        city['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Icon(city['icon'], color: Colors.orange, size: 36),
                      const SizedBox(height: 6),
                      Text(
                        '${city['temperature']}°C',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        city['condition'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.purple),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
