import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ecommerce_bloc_app/presentation/app/app.dart';
import 'package:my_ecommerce_bloc_app/presentation/l10n/l10n.dart';
import 'package:my_ecommerce_bloc_app/presentation/router/router.dart';

class App extends StatelessWidget {
  const App({required this.appBloc, super.key});

  final AppBloc appBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green[900]!),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GetIt.I<AppRouter>().router,
    );
  }
}
