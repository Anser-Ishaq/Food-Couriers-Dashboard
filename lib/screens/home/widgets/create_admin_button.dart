import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/constants/colors/app_colors.dart';
import 'package:food_couriers_dashboard/utils.dart';

class CreateAdminButton extends StatelessWidget {
  const CreateAdminButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth! * 0.015, vertical: screenWidth! * 0.0075),
          decoration: BoxDecoration(
            gradient: AppColors.gradientPrimary,
            borderRadius: BorderRadius.circular(screenWidth! * 0.005),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'DM Sans',
              fontSize: screenWidth! * 0.0125,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),
        ),
      ),
    );
  }
}
