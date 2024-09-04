import 'package:food_couriers_dashboard/constants/routes/routes.dart';
import 'package:food_couriers_dashboard/screens/create_admin/create_admin_screen.dart';
import 'package:food_couriers_dashboard/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GoRouter _router = GoRouter(
    initialLocation: '/${Routes.home}',
    routes: [
      GoRoute(
        name: Routes.home,
        path: '/${Routes.home}',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: Routes.createAdmin,
        path: '/${Routes.createAdmin}',
        builder: (context, state) => const CreateAdminScreen(),
      ),
    ],
  );

  GoRouter get router => _router;
}
