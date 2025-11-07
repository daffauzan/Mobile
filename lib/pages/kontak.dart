import 'package:flutter/material.dart';

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> kontakList = List.generate(
      15,
      (index) => {
        "nama": "Kim Jong Un ${index + 1}",
        "nomor": "08${index + 1111111111}",
        "gambar": "assets/images/kim_jong_un.png",
      },
    );

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
      itemCount: kontakList.length,
      itemBuilder: (context, index) {
        final contact = kontakList[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(contact["gambar"]!),
            ),
            title: Text(
              contact["nama"]!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(contact["nomor"]!),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.black54
            ),
          ),
        );
      },
    );
  }
}
