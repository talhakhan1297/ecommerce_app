import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:my_ecommerce_bloc_app/presentation/l10n/l10n.dart';
import 'package:my_ecommerce_bloc_app/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:my_ecommerce_bloc_app/presentation/utils/helpers/snackbar.dart';
import 'package:my_ecommerce_bloc_app/presentation/utils/widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleWidget(text: 'SignUp'),
            SizedBox(height: 48),
            NameTextField(),
            SizedBox(height: 16),
            EmailTextField(),
            SizedBox(height: 16),
            PasswordTextField(),
            SizedBox(height: 48),
            SignUpButton(),
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
              context.read<SignUpBloc>().add(NameChanged(name: value)),
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
              context.read<SignUpBloc>().add(EmailChanged(email: value)),
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
          onChanged: (value) =>
              context.read<SignUpBloc>().add(PasswordChanged(password: value)),
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
              ? () => context.read<SignUpBloc>().add(FormSubmitted())
              : null,
        );
      },
    );
  }
}
