import 'package:flutter/material.dart';


class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          /// LOGO / HEADER
          Center(
            child: Column(
              children: const [
                SizedBox(height: 12),
                Text(
                  'SiMobile',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Versi 1.0.0',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// DESKRIPSI
          const Text(
            'Tentang Aplikasi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'SiMobile adalah aplikasi konten dan informasi yang terdiri dari fitur kalkulator, dan informasi cuaca' 
            'yang dirancang untuk membantu kehidupan sehari-hari bagi pengguna.',
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 24),

          /// FITUR
          const Text(
            'Fitur Utama',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          _featureItem(Icons.newspaper, 'Berita dan Informasi'),
          _featureItem(Icons.cloud, 'Informasi Cuaca'),
          _featureItem(Icons.contact_phone, 'Kontak'),
          _featureItem(Icons.calculate, 'Kalkulator'),

          const SizedBox(height: 24),

          const Text(
            'Pengembang',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/Barusuh.JPG'),
            ),
            title: const Text('Daffa Fauzaan'),
            subtitle: const Text('ITENAS / 152022054'),
          ),

          const SizedBox(height: 30),

          const Text(
            'API Publik',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Open Meteo \n'
            'https://api.open-meteo.com/v1/forecast',
            textAlign: TextAlign.left,
          ),

          Center(
            child: Text(
              '© 2025 SiMobile',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(title),
    );
  }
}