import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/screens/home/responsive/desktop_home.dart';
import 'package:food_couriers_dashboard/screens/home/responsive/mobile_home.dart';
import 'package:food_couriers_dashboard/screens/home/responsive/tablet_home.dart';
import 'package:food_couriers_dashboard/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    deviceType = getDeviceType(MediaQuery.of(context).size);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return ScreenTypeLayout.builder(
      mobile: (context) => const MobileHome(),
      tablet: (context) => const TabletHome(),
      desktop: (context) => const DesktopHome(),
    );
  }
}