import 'package:ecommerce_app/domain/auth_repository/repository.dart';
import 'package:ecommerce_app/presentation/sign_up/sign_up.dart';
import 'package:ecommerce_app/presentation/sign_up/view/sign_up_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  static String route = '/signUp';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        authRepository: GetIt.I<AuthRepository>(),
      ),
      child: const SignUpPage(),
    );
  }
}
