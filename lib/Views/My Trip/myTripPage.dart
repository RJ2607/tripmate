import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/views/My%20Trip/trips%20view/individualTrip.dart';

import 'trips view/groupTrip.dart';

class MyTab extends GetxController {
  late TabController controller;

  final List<Tab> tabs = [
    Tab(text: 'Individual Trip'),
    Tab(text: 'Group Trip'),
  ];

  void initController(TickerProvider vsync) {
    controller = TabController(length: tabs.length, vsync: vsync);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

class MyTrip extends StatefulWidget {
  MyTrip({super.key});

  @override
  State<MyTrip> createState() => _MyTripState();
}

class _MyTripState extends State<MyTrip> with SingleTickerProviderStateMixin {
  MyTab myTab = Get.put(MyTab());

  @override
  void initState() {
    super.initState();
    myTab = Get.put(MyTab());
    myTab.initController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: TabBar(
          labelColor: Theme.of(context).colorScheme.primaryContainer,
          unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          controller: myTab.controller,
          tabs: myTab.tabs,
        ),
        title: Text(
          'My Trips',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        extendedIconLabelSpacing: 0,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        tooltip: 'Add Trips',
        label: const Text('Add Trips'),
        onPressed: () {
          Navigator.pushNamed(context, '/addTrips');
        },
        icon: const Icon(Bootstrap.plus),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TabBarView(
            physics: const ScrollPhysics(),
            controller: myTab.controller,
            children: [
              IndividualTrip(),
              GroupTrip(),
            ],
          )),
    );
  }
}
