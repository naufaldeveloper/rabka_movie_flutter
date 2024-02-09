import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:rabka_movie/utils/colors.dart';
import 'package:rabka_movie/utils/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:rabka_movie/widgets/bottom_nav.dart';
import 'package:rabka_movie/widgets/custom_drawer.dart';
import 'package:rabka_movie/widgets/top_nav.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  List<Map<String, dynamic>> navItems = [
    {"page": "Home", "icon": Icons.home},
    {"page": "Series", "icon": Icons.tv},
    {"page": "Movies", "icon": Icons.movie},
    {"page": "Local", "icon": Icons.location_on},
  ];
  late final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: bgPrimaryColor),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      drawer: const CustomDrawer(),
      child: Scaffold(
        appBar: TopNav(advancedDrawerController: _advancedDrawerController),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: homeScreenItems,
        ),
        extendBody: true,
        bottomNavigationBar: BottomNav(
          currentPage: _page,
          navItems: navItems,
          onTap: navigationTapped,
        ),
      ),
    );
  }
}
