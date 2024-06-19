import 'package:clima_exito/presentation/views/cities_screen.dart';
import 'package:clima_exito/presentation/views/curren_city_view.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final views = [
      const CurrentCityView(),
      const CitiesView()
    ];

    return SafeArea(
      child: Scaffold(
        body: Padding(padding: EdgeInsets.all(26), child: views[selectedIndex]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (valueSelected) {
            setState(() {
              selectedIndex = valueSelected;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'),
          
                      BottomNavigationBarItem(
                icon: Icon(Icons.location_city),
                label: 'City'),
          ],
        ),
      ),
    );
  }
}

