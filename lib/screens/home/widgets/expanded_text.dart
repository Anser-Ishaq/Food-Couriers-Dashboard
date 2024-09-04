import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/utils.dart';

class ExpandedText extends StatelessWidget {
  const ExpandedText({
    super.key,
    this.flex = 1,
    required this.text,
  });

  final int? flex;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex!,
      child: Text(
        text,
        style: commonTextStyle(screenWidth! * 0.01, FontWeight.w500),
      ),
    );
  }
}
