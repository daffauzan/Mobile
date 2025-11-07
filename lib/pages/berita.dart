import 'package:flutter/material.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> beritaList = List.generate(
      15,
      (index) => {
        "judul": "Korea Utara Luncurkan Rudal ke ${index + 1} Negara",
        "tanggal": "2025-11-${(index + 1).toString().padLeft(2, '0')}",
        "author": "Kim Jong News",
      },
    );

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
      itemCount: beritaList.length,
      itemBuilder: (context, index) {
        final berita = beritaList[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const CircleAvatar(
              radius: 26,
              backgroundColor: Colors.purple,
              child: Icon(
                Icons.newspaper,
                color: Colors.white,
                size: 28,
              ),
            ),
            title: Text(
              berita["judul"]!,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Author: ${berita["author"]}"),
                Text(
                  berita["tanggal"]!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
