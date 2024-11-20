import 'package:flutter/material.dart';
import 'package:medconnect/configs/custom_colors.dart';
import 'package:medconnect/views/home_page.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  static const routeName = '/bottomNavigator';

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> with SingleTickerProviderStateMixin {
  late TabController? _tabController;

  List<Widget> pages = <Widget>[
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  List<BottomNavigationBarItem> iconsPage = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home_outlined),
    ),
    const BottomNavigationBarItem(
      label: 'Agenda',
      icon: Icon(Icons.calendar_month_outlined),
    ),
    const BottomNavigationBarItem(
      label: 'Configuração',
      icon: Icon(Icons.settings),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_tabController!.index],
      bottomNavigationBar: BottomNavigationBar(
        items: iconsPage,
        iconSize: 36,
        selectedItemColor: CustomColors.secondary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        unselectedItemColor: CustomColors.primary,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        currentIndex: _tabController!.index,
        onTap: (int index) => setState(() => _tabController!.index = index),
      ),
    );
  }
}
