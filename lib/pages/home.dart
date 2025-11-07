import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simobile/pages/homeindexpage.dart';

import 'biodata.dart';
import 'kontak.dart';
import 'berita.dart';
import 'cuaca.dart';
import 'kalkulator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; 
  int _bottomNavIndex = -1; 

  static final List<Widget> _pages = [
    const HomeIndexPage(),
    const BiodataPage(),
    const KontakPage(),
    const BeritaPage(),
    const CuacaPage(),
    const KalkulatorPage(),
  ];

  static const List<String> _titles = [
    'Beranda',
    'Biodata',
    'Kontak',
    'Berita',
    'Cuaca',
    'Kalkulator',
  ];

  void _onHomeAppBarTapped() {
    _navigateToPage(0, -1);
  }

  void _navigateToPage(int selectedIndex, int bottomNavIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
      _bottomNavIndex = selectedIndex == 0 ? -1 : bottomNavIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          onPressed: _onHomeAppBarTapped,
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex == -1 ? 0 : _bottomNavIndex,
        onTap: (index) {
          _navigateToPage(index + 1, index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Biodata'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Kontak'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Berita'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Cuaca'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Kalkulator'),
        ],
      ),

    );
  }
}
