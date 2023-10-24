import 'package:ecommerce_app/domain/auth_repository/repository.dart';
import 'package:ecommerce_app/domain/cart_repository/repository.dart';
import 'package:ecommerce_app/presentation/app/app.dart';
import 'package:ecommerce_app/presentation/cart/cart.dart';
import 'package:ecommerce_app/presentation/l10n/l10n.dart';
import 'package:ecommerce_app/presentation/router/router.dart';
import 'package:ecommerce_app/presentation/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  App({super.key});

  static final appBloc = AppBloc(authRepository: GetIt.I<AuthRepository>());
  final appRouter = AppRouter(appBloc: appBloc);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => appBloc),
        BlocProvider(
          create: (context) => CartBloc(
            cartRepository: GetIt.I<CartRepository>(),
          )..add(FetchCartEvent()),
        ),
      ],
      child: AppView(appRouter: appRouter),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({required this.appRouter, super.key});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    final themeMode = context.select((AppBloc bloc) => bloc.state.themeMode);
    return MaterialApp.router(
      themeMode: themeMode,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
