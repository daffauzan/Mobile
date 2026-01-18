import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'berita_isi.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('berita')
          .orderBy('createdAt', descending: true)
          .snapshots(),

      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("Tidak ada berita"));
        }

        final beritaList = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
          itemCount: beritaList.length,
          itemBuilder: (context, index) {
            final data = beritaList[index].data() as Map<String, dynamic>;

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
                  child: Icon(Icons.newspaper, color: Colors.white),
                ),
                title: Text(
                  data['judul'] ?? '-',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  data['isi'] ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BeritaIsiPage(data: data),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
