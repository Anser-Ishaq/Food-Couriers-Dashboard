import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/constants/colors/app_colors.dart';
import 'package:food_couriers_dashboard/utils.dart';

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Create a new Admin',
      style: TextStyle(
        color: AppColors.primary,
        fontFamily: 'DM Sans',
        fontSize: screenWidth! * 0.015,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
    );
  }
}
