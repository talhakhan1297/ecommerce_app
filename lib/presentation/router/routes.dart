import 'package:ecommerce_app/presentation/cart/cart.dart';
import 'package:ecommerce_app/presentation/nav_bar/nav_bar.dart';
import 'package:ecommerce_app/presentation/products/products.dart';
import 'package:ecommerce_app/presentation/profile/profile.dart';
import 'package:ecommerce_app/presentation/sign_in/sign_in.dart';
import 'package:ecommerce_app/presentation/sign_up/sign_up.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  AppRoutes._();

  static final String initial = ProductsView.route;

  static List<RouteBase> get list => [
        GoRoute(
          path: SignUpView.route,
          builder: (_, __) => const SignUpView(),
        ),
        GoRoute(
          path: SignInView.route,
          builder: (_, __) => const SignInView(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (_, __, navigationShell) =>
              NavBarView(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: ProductsView.route,
                  pageBuilder: (_, __) =>
                      const NoTransitionPage(child: ProductsView()),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: CartView.route,
                  pageBuilder: (_, __) =>
                      const NoTransitionPage(child: CartView()),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: ProfileView.route,
                  pageBuilder: (_, __) =>
                      const NoTransitionPage(child: ProfileView()),
                ),
              ],
            ),
          ],
        ),
      ];
}
