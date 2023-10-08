import 'dart:async';

import 'package:ecommerce_app/presentation/app/app.dart';
import 'package:ecommerce_app/presentation/router/routes.dart';
import 'package:ecommerce_app/presentation/sign_in/sign_in.dart';
import 'package:ecommerce_app/presentation/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

export 'routes.dart';

class AppRouter {
  AppRouter({required this.appBloc}) {
    router = GoRouter(
      initialLocation: AppRoutes.initial,
      routes: AppRoutes.list,
      refreshListenable: AppRouterRefreshStream(appBloc.stream),
      redirect: (context, state) {
        final appState = appBloc.state;

        final signedIn = appState.isAuthenticated;
        final signingIn = state.matchedLocation == SignInView.route;
        final signingUp = state.matchedLocation == SignUpView.route;

        if (!signedIn && !signingIn && !signingUp) return SignInView.route;
        if (signedIn && (signingIn || signingUp)) return AppRoutes.initial;

        return null;
      },
    );
  }

  final AppBloc appBloc;

  late GoRouter router;
}

class AppRouterRefreshStream extends ChangeNotifier {
  AppRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((event) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
