import 'package:go_router/go_router.dart';
import 'package:ecommerce_app/presentation/products/products.dart';
import 'package:ecommerce_app/presentation/sign_in/sign_in.dart';
import 'package:ecommerce_app/presentation/sign_up/sign_up.dart';

class AppRoutes {
  AppRoutes._();

  static final String initial = ProductsView.route;

  static List<GoRoute> get list => [
        GoRoute(
          path: SignUpView.route,
          builder: (_, __) => const SignUpView(),
        ),
        GoRoute(
          path: SignInView.route,
          builder: (_, __) => const SignInView(),
        ),
        GoRoute(
          path: ProductsView.route,
          builder: (_, __) => const ProductsView(),
        ),
      ];
}
