import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_couriers_dashboard/constants/colors/app_colors.dart';
import 'package:food_couriers_dashboard/provider/admindata_provider.dart';
import 'package:food_couriers_dashboard/provider/auth_provider.dart';
import 'package:food_couriers_dashboard/provider/userdata_provider.dart';
import 'package:food_couriers_dashboard/sevices/navigation_service.dart';
import 'package:food_couriers_dashboard/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

Future<void> main() async {
  await setup();
  runApp(MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(desktop: 1025, tablet: 501, watch: 201),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.primary,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: AppColors.primary,
    ),
  );
  await setupFirebase();
  await registerServices();
}

class MyApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;
  MyApp({super.key}) {
    _navigationService = _getIt<NavigationService>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primarySwatch = MaterialColor(
      0xFFD61355,
      <int, Color>{
        50: Color(0xFFFDE6EE),
        100: Color(0xFFFBC0D3),
        200: Color(0xFFF78AAE),
        300: Color(0xFFF25589),
        400: Color(0xFFEE306F),
        500: Color(0xFFD61355),
        600: Color(0xFFCB114E),
        700: Color(0xFFA50E41),
        800: Color(0xFF800B34),
        900: Color(0xFF5A0727),
      },
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserdataProvider(context)),
        ChangeNotifierProvider(create: (_) => AdmindataProvider()),
      ],
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(1920, 1152),
          builder: (context, child) {
            return MaterialApp.router(
              title: 'Food Couriers Dashboard',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
                primarySwatch: primarySwatch,
                useMaterial3: true,
              ),
              routerConfig: _navigationService.router,
            );
          },
        );
      },
    );
  }
}
