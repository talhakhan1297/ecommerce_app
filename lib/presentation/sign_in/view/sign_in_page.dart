import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:ecommerce_app/presentation/l10n/l10n.dart';
import 'package:ecommerce_app/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:ecommerce_app/presentation/sign_up/sign_up.dart';
import 'package:ecommerce_app/presentation/utils/helpers/snackbar.dart';
import 'package:ecommerce_app/presentation/utils/widgets/widgets.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleWidget(text: 'SignIn'),
            const SizedBox(height: 48),
            const EmailTextField(),
            const SizedBox(height: 16),
            const PasswordTextField(),
            const SizedBox(height: 48),
            const SignInButton(),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go(SignUpView.route),
              child: const Text('Go to Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextField(
          label: 'Email',
          hintText: 'e.g. test@test.com',
          initialValue: state.email.value,
          inputFormatters: [LengthLimitingTextInputFormatter(150)],
          errorMessage: state.email.displayError?.message(context.l10n),
          onChanged: (value) =>
              context.read<SignInBloc>().add(SignInEmailChanged(email: value)),
        );
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextField(
          label: 'Password',
          hintText: 'e.g. 12345678',
          obscureText: true,
          textInputAction: TextInputAction.done,
          initialValue: state.password.value,
          inputFormatters: [LengthLimitingTextInputFormatter(51)],
          errorMessage: state.password.displayError?.message(context.l10n),
          onChanged: (value) => context
              .read<SignInBloc>()
              .add(SignInPasswordChanged(password: value)),
        );
      },
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status.isFailure) {
          context.errorSnackbar(state.errorMessage ?? 'Something went wrong!');
        }
      },
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isValid != current.isValid,
      builder: (context, state) {
        return PrimaryButton(
          isLoading: state.status.isInProgress,
          text: 'Sign In',
          onPressed: state.isValid
              ? () => context.read<SignInBloc>().add(SignInFormSubmitted())
              : null,
        );
      },
    );
  }
}
