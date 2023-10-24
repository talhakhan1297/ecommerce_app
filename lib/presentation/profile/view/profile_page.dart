import 'package:ecommerce_app/presentation/app/app.dart';
import 'package:ecommerce_app/presentation/l10n/l10n.dart';
import 'package:ecommerce_app/presentation/profile/bloc/profile_bloc.dart';
import 'package:ecommerce_app/presentation/utils/helpers/snackbar.dart';
import 'package:ecommerce_app/presentation/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleWidget(text: 'Profile'),
            SizedBox(height: 48),
            ChangeThemeSegmentedButton(),
            SizedBox(height: 48),
            NameTextField(),
            SizedBox(height: 16),
            EmailTextField(),
            SizedBox(height: 48),
            SaveButton(),
            SizedBox(height: 16),
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CustomTextField(
          label: 'Name',
          hintText: 'e.g. Talha',
          initialValue: state.name.value,
          inputFormatters: [LengthLimitingTextInputFormatter(50)],
          errorMessage: state.nameError(context.l10n),
          onChanged: (value) =>
              context.read<ProfileBloc>().add(ProfileNameChanged(name: value)),
        );
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextField(
          label: 'Email',
          hintText: 'e.g. test@test.com',
          initialValue: state.email.value,
          inputFormatters: [LengthLimitingTextInputFormatter(150)],
          errorMessage: state.email.displayError?.message(context.l10n),
          onChanged: (value) => context
              .read<ProfileBloc>()
              .add(ProfileEmailChanged(email: value)),
        );
      },
    );
  }
}

class ChangeThemeSegmentedButton extends StatelessWidget {
  const ChangeThemeSegmentedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        return SegmentedButton<ThemeMode>(
          segments: ThemeMode.values
              .map(
                (mode) => ButtonSegment<ThemeMode>(
                  value: mode,
                  label: Text(mode.text),
                  icon: Icon(mode.icon),
                ),
              )
              .toList(),
          selected: <ThemeMode>{state.themeMode},
          onSelectionChanged: (selection) => context
              .read<AppBloc>()
              .add(ToggleThemeModeRequested(themeMode: selection.first)),
        );
      },
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
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
          text: 'Save Changes',
          onPressed: state.isValid
              ? () => context.read<ProfileBloc>().add(ProfileFormSubmitted())
              : null,
        );
      },
    );
  }
}
