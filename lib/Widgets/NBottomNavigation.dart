import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n_hacker_news/Screens/HomePage.dart';
import 'package:n_hacker_news/Screens/OffLineNewsPage.dart';

class NBottomNavigation extends StatelessWidget {
  const NBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationContrller());
    return Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
              height: 80,
              elevation: 10,
              indicatorColor: Colors.blue,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: [
                NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                NavigationDestination(
                    icon: Icon(Icons.network_check), label: "Offline"),
                NavigationDestination(
                    icon: Icon(Icons.settings), label: "Setting"),
              ]),
        ),
        body: Obx(
          () => controller.screens[controller.selectedIndex.value],
        ));
  }
}

class NavigationContrller extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    HomePage(),
    OffLineNewsPage(),
    Container(
      color: Colors.blue,
      child: Center(child: Text("En construction")),
    ), 
  ];
}
