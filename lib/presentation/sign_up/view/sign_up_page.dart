import 'package:ecommerce_app/presentation/l10n/l10n.dart';
import 'package:ecommerce_app/presentation/sign_in/sign_in.dart';
import 'package:ecommerce_app/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:ecommerce_app/presentation/utils/helpers/snackbar.dart';
import 'package:ecommerce_app/presentation/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleWidget(text: 'Sign Up'),
            const SizedBox(height: 48),
            const NameTextField(),
            const SizedBox(height: 16),
            const EmailTextField(),
            const SizedBox(height: 16),
            const PasswordTextField(),
            const SizedBox(height: 48),
            const SignUpButton(),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go(SignInView.route),
              child: const Text('Go to Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CustomTextField(
          label: 'Name',
          hintText: 'e.g. Talha',
          initialValue: state.name.value,
          inputFormatters: [LengthLimitingTextInputFormatter(50)],
          errorMessage: state.nameError(context.l10n),
          onChanged: (value) =>
              context.read<SignUpBloc>().add(SignUpNameChanged(name: value)),
        );
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextField(
          label: 'Email',
          hintText: 'e.g. test@test.com',
          initialValue: state.email.value,
          inputFormatters: [LengthLimitingTextInputFormatter(150)],
          errorMessage: state.email.displayError?.message(context.l10n),
          onChanged: (value) =>
              context.read<SignUpBloc>().add(SignUpEmailChanged(email: value)),
        );
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
              .read<SignUpBloc>()
              .add(SignUpPasswordChanged(password: value)),
        );
      },
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
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
          text: 'Sign Up',
          onPressed: state.isValid
              ? () => context.read<SignUpBloc>().add(SignUpFormSubmitted())
              : null,
        );
      },
    );
  }
}
