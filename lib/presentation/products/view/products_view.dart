import 'package:ecommerce_app/domain/products_repository/repository.dart';
import 'package:ecommerce_app/presentation/products/bloc/products_bloc.dart';
import 'package:ecommerce_app/presentation/products/view/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  static String route = '/products';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        productsRepository: GetIt.I<ProductsRepository>(),
      )..add(FetchProductsEvent()),
      child: const ProductsPage(),
    );
  }
}
