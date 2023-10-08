import 'package:ecommerce_app/domain/auth_repository/repository.dart';
import 'package:ecommerce_app/presentation/sign_in/sign_in.dart';
import 'package:ecommerce_app/presentation/sign_in/view/sign_in_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  static String route = '/signIn';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(
        authRepository: GetIt.I<AuthRepository>(),
      ),
      child: const SignInPage(),
    );
  }
}
