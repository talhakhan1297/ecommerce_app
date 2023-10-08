import 'package:flutter/material.dart';

extension SnackbarContext on BuildContext {
  ScaffoldMessengerState successSnackbar(String text) =>
      ScaffoldMessenger.of(this)
        ..hideCurrentSnackBar()
        ..showSnackBar(_SnackbarsType.success(text));

  ScaffoldMessengerState errorSnackbar(String text) =>
      ScaffoldMessenger.of(this)
        ..hideCurrentSnackBar()
        ..showSnackBar(_SnackbarsType.error(text));
}

class _SnackbarsType {
  const _SnackbarsType._();

  static SnackBar success(String text) => _Snackbar.snackbar(text, Icons.check);

  static SnackBar error(String text) =>
      _Snackbar.snackbar(text, Icons.error_outline);
}

class _Snackbar {
  const _Snackbar._();

  static SnackBar snackbar(String text, IconData icon) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
