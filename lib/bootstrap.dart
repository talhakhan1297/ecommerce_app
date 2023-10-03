import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ecommerce_bloc_app/domain/auth_repository/repository.dart';
import 'package:my_ecommerce_bloc_app/presentation/app/app.dart';
import 'package:my_ecommerce_bloc_app/presentation/router/router.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function(AppBloc) builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final authRepository = AuthRepositoryImpl();

  final appBloc = AppBloc(authRepository: authRepository);

  GetIt.I
    ..registerSingleton(authRepository)
    ..registerSingleton(AppRouter(appBloc: appBloc));

  runApp(await builder(appBloc));
}
