import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/constants/colors/app_colors.dart';
import 'package:food_couriers_dashboard/screens/create_admin/widgets/heading.dart';
import 'package:food_couriers_dashboard/screens/create_admin/widgets/signup_form.dart';
import 'package:food_couriers_dashboard/screens/create_admin/widgets/space.dart';
import 'package:food_couriers_dashboard/utils.dart';

class DesktopCreateAdmin extends StatelessWidget {
  const DesktopCreateAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.silver.withAlpha(140),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(screenWidth! * 0.02),
          padding: EdgeInsets.symmetric(horizontal: screenWidth! * 0.015, vertical: screenWidth! * 0.01),
          constraints: BoxConstraints(
            maxWidth: screenWidth! * 0.55,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(screenWidth! * 0.01),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading(),
              Space(),
              Space(),
              Space(),
              SignupForm(),
              Space(),
            ],
          ),
        ),
      ),
    );
  }
}