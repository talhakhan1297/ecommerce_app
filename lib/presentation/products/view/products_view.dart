import 'package:ecommerce_app/presentation/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  static String route = '/products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () => context.read<AppBloc>().add(LogoutRequested()),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
    );
  }
}
