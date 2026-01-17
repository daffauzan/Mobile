// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  String gender = 'Male';
  DateTime? selectedDate;

  final nameController = TextEditingController(text: 'Daffa Fauzaan');
  final emailController = TextEditingController(text: 'daffauzan15.gmail.com');
  final aboutController = TextEditingController(text: 'Jodoh adalah cerminan mantan.');

  @override
  Widget build(BuildContext context) {
    final boxColor = const Color(0xFF940B92);

    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Avatar
            Center(
              child: CircleAvatar(
                radius: 85,
                backgroundColor: Colors.grey,
                backgroundImage: const AssetImage('assets/images/icon_me.png'),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Biodata',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            _label('Name'),
            _box(
              boxColor,
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),

            const SizedBox(height: 10),

            _label('Date of Birth'),
            _box(
              boxColor,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate != null
                          ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                          : '15/9/2002',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/calendar.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime(2002, 9, 15),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            _label('Gender'),
            _box(
              boxColor,
              Wrap(
                spacing: 12,
                children: ['Male', 'Female'].map((item) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<String>(
                        value: item,
                        groupValue: gender,
                        activeColor: Colors.white,
                        onChanged: (value) => setState(() => gender = value!),
                      ),
                      Text(item, style: const TextStyle(color: Colors.white)),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            _label('Email'),
            _box(
              boxColor,
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),

            const SizedBox(height: 10),

            _label('About'),
            _box(
              boxColor,
              TextField(
                controller: aboutController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.black)),
    );
  }

  Widget _box(Color color, Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}