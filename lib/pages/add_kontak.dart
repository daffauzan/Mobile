// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddKontakDialog extends StatefulWidget {
  const AddKontakDialog({super.key});

  @override
  State<AddKontakDialog> createState() => _AddKontakDialogState();
}

class _AddKontakDialogState extends State<AddKontakDialog> {
  final nama = TextEditingController();
  final email = TextEditingController();
  final telp = TextEditingController();
  bool loading = false;

  Future<void> save() async {
    if (nama.text.isEmpty || email.text.isEmpty || telp.text.isEmpty) return;

    setState(() => loading = true);

    await FirebaseFirestore.instance.collection('kontak').add({
      'nama': nama.text,
      'email': email.text,
      'no_telp': telp.text,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Tambah Kontak"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nama, decoration: const InputDecoration(labelText: "Nama")),
          TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
          TextField(controller: telp, decoration: const InputDecoration(labelText: "No Telp")),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: loading ? null : save,
          child: const Text("Simpan"),
        ),
      ],
    );
  }
}
