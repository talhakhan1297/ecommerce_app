import 'package:go_router/go_router.dart';
import 'package:my_ecommerce_bloc_app/presentation/sign_up/sign_up.dart';

class AppRoutes {
  AppRoutes._();

  static final String initial = SignUpView.route;

  static List<GoRoute> get list => [
        GoRoute(
          path: SignUpView.route,
          builder: (_, __) => const SignUpView(),
        ),
      ];
}
