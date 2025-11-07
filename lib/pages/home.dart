import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Halaman yang kamu buat
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
    const Center(child: Text('Halaman Beranda')),
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
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _pages[_selectedIndex],
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            bool isSelected = _bottomNavIndex == index;
            final labels = ['Biodata','Kontak','Berita','Cuaca','Kalkulator'];
            final icons = [Icons.person, Icons.contact_phone, Icons.newspaper, Icons.cloud, Icons.calculate];

            return GestureDetector(
              onTap: () {
                _navigateToPage(index + 1, index);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icons[index], color: isSelected ? Colors.purple : Colors.grey),
                  const SizedBox(height: 2),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: isSelected ? Colors.purple : Colors.grey,
                      fontSize: isSelected ? 14 : 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    child: Text(labels[index]),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
