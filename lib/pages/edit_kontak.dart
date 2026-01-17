// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditKontakDialog extends StatefulWidget {
  final String id;
  final QueryDocumentSnapshot data;

  const EditKontakDialog({super.key, required this.id, required this.data});

  @override
  State<EditKontakDialog> createState() => _EditKontakDialogState();
}

class _EditKontakDialogState extends State<EditKontakDialog> {
  late TextEditingController nama;
  late TextEditingController email;
  late TextEditingController telp;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    nama = TextEditingController(text: widget.data['nama']);
    email = TextEditingController(text: widget.data['email']);
    telp = TextEditingController(text: widget.data['no_telp']);
  }

  Future<void> update() async {
    setState(() => loading = true);

    await FirebaseFirestore.instance
        .collection('kontak')
        .doc(widget.id)
        .update({
      'nama': nama.text,
      'email': email.text,
      'no_telp': telp.text,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Kontak"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nama, decoration: const InputDecoration(labelText: "Nama")),
          TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
          TextField(controller: telp, decoration: const InputDecoration(labelText: "No Telp")),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
        ElevatedButton(onPressed: loading ? null : update, child: const Text("Simpan")),
      ],
    );
  }
}
