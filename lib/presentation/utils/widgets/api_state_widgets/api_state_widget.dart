import 'package:ecommerce_app/presentation/utils/helpers/api_state.dart';
import 'package:ecommerce_app/presentation/utils/widgets/api_state_widgets/api_state_widget.dart';
import 'package:flutter/material.dart';

export 'app_error.dart';
export 'app_progress_indicator.dart';

class APIStateWidget<T> extends StatelessWidget {
  const APIStateWidget({
    required this.apiState,
    required this.emptyErrorMessage,
    required this.successWidget,
    this.initialWidget,
    this.loadingWidget,
    this.failureWidget,
    this.onInitialState,
    this.onSuccessState,
    this.onRetry,
    super.key,
  });

  final APIState<T> apiState;
  final String emptyErrorMessage;
  final Widget successWidget;
  final Widget? failureWidget;
  final Widget? loadingWidget;
  final Widget? initialWidget;
  final void Function()? onInitialState;
  final void Function()? onSuccessState;
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    switch (apiState.state) {
      case APICallState.initial:
        return _buildInitialWidget();
      case APICallState.loading:
        return _buildLoadingWidget();
      case APICallState.loaded:
        onSuccessState?.call();
        if (apiState.isEmpty) {
          return _buildFailureWidget(emptyErrorMessage);
        }
        return successWidget;
      case APICallState.failure:
        return _buildFailureWidget();
    }
  }

  Widget _buildFailureWidget([String? errorMessage]) {
    return failureWidget ??
        AppError(
          message: apiState.error ?? errorMessage ?? 'Something went wrong!',
          retry: onRetry,
        );
  }

  Widget _buildLoadingWidget() => loadingWidget ?? const AppProgress();

  Widget _buildInitialWidget() {
    onInitialState?.call();
    return initialWidget ?? const SizedBox(key: Key('Initial_SizedBox'));
  }
}
