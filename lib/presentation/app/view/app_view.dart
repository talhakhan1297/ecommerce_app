import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ecommerce_bloc_app/domain/auth_repository/repository.dart';
import 'package:my_ecommerce_bloc_app/presentation/app/app.dart';
import 'package:my_ecommerce_bloc_app/presentation/l10n/l10n.dart';
import 'package:my_ecommerce_bloc_app/presentation/router/router.dart';

class App extends StatelessWidget {
  App({super.key});

  static final appBloc = AppBloc(authRepository: GetIt.I<AuthRepository>());
  final appRouter = AppRouter(appBloc: appBloc);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc,
      child: AppView(appRouter: appRouter),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({required this.appRouter, super.key});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green[900]!),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter.router,
    );
  }
}
