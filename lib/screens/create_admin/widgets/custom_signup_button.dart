import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/constants/colors/app_colors.dart';
import 'package:food_couriers_dashboard/utils.dart';

class CustomSignupButton extends StatelessWidget {
  const CustomSignupButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth! * 0.025, vertical: screenWidth! * 0.01),
          decoration: BoxDecoration(
            gradient: AppColors.gradientPrimary,
            borderRadius: BorderRadius.circular(screenWidth! * 0.005),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: AppColors.white,
              fontFamily: 'DM Sans',
              fontSize: screenWidth! * 0.0125,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
        ),
      ),
    );
  }
}
