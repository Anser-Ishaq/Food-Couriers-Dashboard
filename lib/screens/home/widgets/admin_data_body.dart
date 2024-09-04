import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/constants/colors/app_colors.dart';
import 'package:food_couriers_dashboard/screens/home/widgets/expanded_text.dart';
import 'package:food_couriers_dashboard/screens/home/widgets/spacing.dart';
import 'package:food_couriers_dashboard/utils.dart';

class AdminDataBody extends StatelessWidget {
  const AdminDataBody({
    super.key,
    required this.imageURL,
    required this.name,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.status,
  });

  final String imageURL;
  final String name;
  final String email;
  final String phone;
  final DateTime createdAt;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth! * 0.01, vertical: screenWidth! * 0.0075),
      decoration: BoxDecoration(
        color: AppColors.silver.withAlpha(50),
        borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      ),
      child: Row(
        children: [
          _buildImage(imageURL),
          const Spacing(),
          ExpandedText(flex: 4, text: name),
          const Spacing(),
          ExpandedText(flex: 4, text: email),
          const Spacing(),
          ExpandedText(flex: 4, text: phone),
          const Spacing(),
          ExpandedText(flex: 7, text: formatDate(createdAt)),
          const Spacing(),
          _buildStatusIndicator(status),
          // const Spacing(),
          // const ExpandedText(text: ''),
        ],
      ),
    );
  }

    Widget _buildImage(String imageURL) {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: screenWidth! * 0.025,
          height: screenWidth! * 0.025,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imageURL),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

    Widget _buildStatusIndicator(String status) {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(screenWidth! * 0.005),
          decoration: BoxDecoration(
            color: status == 'Active' ? Colors.green.shade100 : Colors.red.shade100,
            borderRadius: BorderRadius.circular(screenWidth! * 0.005),
          ),
          child: Text(
            status == 'Active'  ? 'Active' : 'Inactive',
            style: commonTextStyle(
              screenWidth! * 0.01,
              FontWeight.w300,
            ).copyWith(color: status == 'Active'  ? Colors.green : Colors.red),
          ),
        ),
      ),
    );
  }
}
