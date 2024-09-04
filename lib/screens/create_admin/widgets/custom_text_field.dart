import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/constants/colors/app_colors.dart';
import 'package:food_couriers_dashboard/utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.textEditingController,
    required this.obscureText,
    required this.keyboardType,
    this.isIcon,
    this.onTap, this.validator,
  });

  final String title;
  final TextEditingController textEditingController;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool? isIcon;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: _style(FontWeight.w500),
        ),
        SizedBox(height: screenWidth! * 0.005),
        TextFormField(
          controller: textEditingController,
          style: _style(FontWeight.w400),
          obscureText: obscureText,
          keyboardType: keyboardType,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TextStyle(
              color: AppColors.silver.withAlpha(140),
            ),
            border: _commonBorder(),
            enabledBorder: _commonBorder(),
            focusedBorder: _commonBorder(),
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth! * 0.01, vertical: screenWidth! * 0.0125),
            suffixIcon: isIcon != null
                ? GestureDetector(
                    onTap: onTap,
                    child: Icon(
                      obscureText
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      size: screenWidth! * 0.0125,
                      color: AppColors.silver,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  TextStyle _style(FontWeight fontWeight) {
    return TextStyle(
      color: AppColors.textDarkColor,
      fontFamily: 'DM Sans',
      fontSize: screenWidth! * 0.01,
      fontWeight: fontWeight,
      height: 1.1,
    );
  }

  OutlineInputBorder _commonBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      borderSide: BorderSide(color: AppColors.primary.withOpacity(0.8)),
      gapPadding: 0,
    );
  }
}
