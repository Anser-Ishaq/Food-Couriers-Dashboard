import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/constants/assets/assets.dart';
import 'package:food_couriers_dashboard/constants/colors/app_colors.dart';
import 'package:food_couriers_dashboard/constants/routes/routes.dart';
import 'package:food_couriers_dashboard/provider/admindata_provider.dart';
import 'package:food_couriers_dashboard/screens/home/widgets/admin_data_body.dart';
import 'package:food_couriers_dashboard/screens/home/widgets/admin_data_header.dart';
import 'package:food_couriers_dashboard/screens/home/widgets/create_admin_button.dart';
import 'package:food_couriers_dashboard/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DesktopHome extends StatelessWidget {
  const DesktopHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        margin: EdgeInsets.all(screenWidth! * 0.02),
        padding: EdgeInsets.symmetric(horizontal: screenWidth! * 0.01),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Food Couriers',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontFamily: 'Dm Sans',
                    fontSize: screenWidth! * 0.02,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
                CreateAdminButton(
                  buttonText: 'Create Admin',
                  onTap: () {
                    context.goNamed(Routes.createAdmin);
                  },
                ),
              ],
            ),
            SizedBox(height: screenHeight! * 0.02),
            const AdminDataHeader(),
            SizedBox(height: screenHeight! * 0.02),
            Flexible(
              child: Consumer<AdmindataProvider>(
                builder: (context, admindataProvider, child) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: admindataProvider.admins.length,
                    itemBuilder: (context, index) {
                      final admin = admindataProvider.admins[index];
                      return AdminDataBody(
                        imageURL: admin.imageURL ?? Assets.pfpDefault,
                        name: admin.name ?? '',
                        email: admin.email ?? '',
                        phone: admin.phone ?? '',
                        createdAt: admin.createAt!.toDate(),
                        status: admin.status ?? '',
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: screenWidth! * 0.005,
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
