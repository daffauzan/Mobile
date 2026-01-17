import 'package:flutter/material.dart';
import 'package:simobile/services/api_cuaca.dart';
import 'package:fl_chart/fl_chart.dart';

class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> {
  String selectedCity = "Bandung";
  bool loading = false;

  double suhu = 0;
  double angin = 0;
  int kelembaban = 0;
  String kondisi = "-";

  List<double> hourlyTemps = [];

  @override
  void initState() {
    super.initState();
    loadWeather();
    loadForecast();
  }

  Future<void> loadWeather() async {
    setState(() => loading = true);

    final data = await ApiCuaca.fetchCurrent(selectedCity);

    setState(() {
      suhu = data['temp'];
      angin = data['wind'];
      kelembaban = data['humidity'];
      kondisi = ApiCuaca.weatherLabel(data['code']);
      loading = false;
    });
  }

  Future<void> loadForecast() async {
    hourlyTemps = await ApiCuaca.fetchHourlyTemp(selectedCity);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              initialValue: selectedCity,
              decoration: const InputDecoration(
                labelText: "Pilih Kota",
                border: OutlineInputBorder(),
              ),
              items: ApiCuaca.cities.keys.map((city) {
                return DropdownMenuItem(value: city, child: Text(city));
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  selectedCity = val;
                  loadWeather();
                  loadForecast();
                }
              },
            ),
          ),

          // ===== Kartu utama =====
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: loading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      Text(
                        selectedCity,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "${suhu.toStringAsFixed(1)}°C",
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(kondisi, style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _infoTile(Icons.water_drop, "Kelembaban", "$kelembaban%"),
                          _infoTile(Icons.air, "Angin", "$angin km/h"),
                        ],
                      )
                    ],
                  ),
          ),
          if (hourlyTemps.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Prakiraan Suhu 24 Jam – $selectedCity",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 12),

                  AspectRatio(
                    aspectRatio: 1.8,
                    child: LineChart(
                      LineChartData(
                        minY: hourlyTemps.reduce((a, b) => a < b ? a : b) - 2,
                        maxY: hourlyTemps.reduce((a, b) => a > b ? a : b) + 2,
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (spots) {
                              return spots.map((spot) {
                                return LineTooltipItem(
                                  "${spot.y.toStringAsFixed(1)}°C\nJam ${spot.x.toInt()}:00",
                                  const TextStyle(color: Colors.black),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 3,
                              getTitlesWidget: (value, _) => Text(
                                "${value.toInt().toString().padLeft(2, '0')}:00",
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, _) => Text(
                                "${value.toInt()}°C",
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(
                              hourlyTemps.length,
                              (i) => FlSpot(i.toDouble(), hourlyTemps[i]),
                            ),
                            isCurved: true,
                            barWidth: 3,
                            color: Colors.purple,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.purple.withValues(alpha: 0.2),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.purple),
        const SizedBox(height: 4),
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
