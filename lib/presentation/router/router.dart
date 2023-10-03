import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_ecommerce_bloc_app/presentation/app/app.dart';
import 'package:my_ecommerce_bloc_app/presentation/router/routes.dart';

export 'routes.dart';

class AppRouter {
  AppRouter({required this.appBloc}) {
    router = GoRouter(
      initialLocation: AppRoutes.initial,
      routes: AppRoutes.list,
      refreshListenable: AppRouterRefreshStream(appBloc.stream),
      redirect: (context, state) {
        // final appState = appBloc.state;

        // no need to redirect at all
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
