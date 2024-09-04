import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/constants/colors/app_colors.dart';
import 'package:food_couriers_dashboard/screens/home/widgets/expanded_text.dart';
import 'package:food_couriers_dashboard/screens/home/widgets/spacing.dart';
import 'package:food_couriers_dashboard/utils.dart';

class AdminDataHeader extends StatelessWidget {
  const AdminDataHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth! * 0.01, vertical: screenWidth! * 0.0075),
      decoration: BoxDecoration(
        color: AppColors.silver.withAlpha(90),
        borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      ),
      child: Row(
        children: [
          ExpandedText(flex: 1, text: 'Image'.toUpperCase()),
          const Spacing(),
          ExpandedText(flex: 4, text: 'Name'.toUpperCase()),
          const Spacing(),
          ExpandedText(flex: 4, text: 'Email'.toUpperCase()),
          const Spacing(),
          ExpandedText(flex: 4, text: 'Phone'.toUpperCase()),
          const Spacing(),
          ExpandedText(flex: 7, text: 'creation date'.toUpperCase()),
          const Spacing(),
          ExpandedText(flex: 2, text: 'active'.toUpperCase()),
          // const Spacing(),
          // const ExpandedText(text: ''),
        ],
      ),
    );
  }
}
