import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/screens/create_admin/responsive/desktop_create_admin.dart';
import 'package:food_couriers_dashboard/screens/create_admin/responsive/mobile_create_admin.dart';
import 'package:food_couriers_dashboard/screens/create_admin/responsive/tablet_create_admin.dart';
import 'package:food_couriers_dashboard/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CreateAdminScreen extends StatelessWidget {
  const CreateAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    deviceType = getDeviceType(MediaQuery.of(context).size);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return ScreenTypeLayout.builder(
      mobile: (context) => const MobileCreateAdmin(),
      tablet: (context) => const TabletCreateAdmin(),
      desktop: (context) => const DesktopCreateAdmin(),
    );
  }
}