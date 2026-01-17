import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simobile/pages/homeindexpage.dart';

import 'biodata.dart';
import 'kontak.dart';
import 'berita.dart';
import 'cuaca.dart';
import 'kalkulator.dart';
import 'about.dart';

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
    const KontakPage(),
    const BeritaPage(),
    const CuacaPage(),
    const KalkulatorPage(),
    const AboutPage(),
    const BiodataPage(),

  ];

  static const List<String> _titles = [
    'Beranda',
    'Kontak',
    'Berita',
    'Cuaca',
    'Kalkulator',
    'Tentang',
    'Biodata',
  ];

  void _onHomeAppBarTapped() {
    setState((){
      _selectedIndex = 0;
      _bottomNavIndex = -1;
    });
  }

  void _navigateToPage(int selectedIndex, int bottomNavIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
      _bottomNavIndex = bottomNavIndex;
    });
  }

  void navigateFromMoreMenu(int index) {
    Navigator.pop(context);
    setState(() {
      _selectedIndex = index;
      _bottomNavIndex = -1;
    });
  }

  void _showMoreMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Kalkulator'),
              onTap: () {
                navigateFromMoreMenu(4);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tentang'),
              onTap: () {
                navigateFromMoreMenu(5);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Biodata'),
              onTap: () {
                navigateFromMoreMenu(6);
              },
            ),
          ],
        );
      },
    );
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
          if (index == 3) {
            _showMoreMenu(context);
          } else {
            _navigateToPage(index + 1, index);
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Kontak'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Berita'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Cuaca'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lainnya'),
        ],
      ),

    );
  }
}
