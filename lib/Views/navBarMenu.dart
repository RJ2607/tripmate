import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controller/navigationController.dart';
import '../models/navigationModel.dart';
import 'Home/homeScreen.dart';
import 'My Trip/myTripPage.dart';
import 'Profile/profilePage.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final navigationController = Get.put(NavigationController());

  NavigationModel selectedBottomNav = bottomNavItemsDark.first;

  final PageController pageController =
      PageController(); // Create PageController

  void updateSelectedBtmNav(NavigationModel menu, int index) {
    if (selectedBottomNav != menu) {
      setState(() {
        selectedBottomNav = menu;
        pageController
            .jumpToPage(index); // Update PageController to change the page
        navigationController.currentIndex = index; // Sync controller index
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeScreen(),
            MyTrip(),
            Profile(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }

  SafeArea buildBottomNavBar(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.073,
            width: MediaQuery.of(context).size.width * 0.7,
            padding: EdgeInsets.only(left: 15, top: 9, right: 15, bottom: 15),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.4),
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(bottomNavItemsDark.length, (i) {
                NavigationModel navBar = bottomNavItemsDark[i];
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    updateSelectedBtmNav(
                        navBar, i); // Pass index to update page
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimateBar(
                          isActived: selectedBottomNav == navBar,
                        ),
                        Icon(
                          bottomNavItemsDark[i].icon,
                          color: selectedBottomNav == navBar
                              ? bottomNavItemsDark[i].iconActiveColor
                              : bottomNavItemsDark[i].iconColor,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed('/addTrips');
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
              child: Icon(Iconsax.add_outline, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class AnimateBar extends StatelessWidget {
  AnimateBar({
    required this.isActived,
    super.key,
  });

  bool isActived = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: MediaQuery.of(context).size.height * 0.005,
      width: isActived ? MediaQuery.of(context).size.width * 0.05 : 0,
      margin: EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColorDark,
      ),
    );
  }
}
