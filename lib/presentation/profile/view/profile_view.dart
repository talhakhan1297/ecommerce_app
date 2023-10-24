import 'package:ecommerce_app/domain/auth_repository/repository.dart';
import 'package:ecommerce_app/presentation/app/app.dart';
import 'package:ecommerce_app/presentation/profile/profile.dart';
import 'package:ecommerce_app/presentation/profile/view/profile_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static String route = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        authRepository: GetIt.I<AuthRepository>(),
        state: context.read<AppBloc>().state.user.toState(),
      ),
      child: const ProfilePage(),
    );
  }
}
