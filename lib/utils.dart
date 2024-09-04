import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/constants/colors/app_colors.dart';
import 'package:food_couriers_dashboard/firebase_options.dart';
import 'package:food_couriers_dashboard/sevices/auth_service.dart';
import 'package:food_couriers_dashboard/sevices/database_service.dart';
import 'package:food_couriers_dashboard/sevices/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

Future<void> setupFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
  getIt.registerSingleton<AuthService>(
    AuthService(),
  );
  getIt.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
}

DeviceScreenType? deviceType;
double? screenWidth;
double? screenHeight;

TextStyle commonTextStyle(double fontSize, FontWeight fontWeight) {
  return TextStyle(
    fontFamily: 'DM Sans',
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: 1.1,
    letterSpacing: -0.03 * fontSize,
    color: AppColors.textDarkColor,
  );
}

String formatDate(DateTime dateTime) {
  return DateFormat('EEEE, MMMM d, y h:mm a').format(dateTime);
}
