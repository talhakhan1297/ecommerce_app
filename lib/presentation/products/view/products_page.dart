import 'package:ecommerce_app/domain/products_repository/models/models.dart';
import 'package:ecommerce_app/presentation/app/app.dart';
import 'package:ecommerce_app/presentation/products/bloc/products_bloc.dart';
import 'package:ecommerce_app/presentation/utils/widgets/api_state_widgets/api_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

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
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return APIStateWidget(
            apiState: state.productApiState,
            emptyErrorMessage: 'No products found!',
            onRetry: () =>
                context.read<ProductsBloc>().add(FetchProductsEvent()),
            successWidget: ListView.separated(
              itemCount: state.products.length,
              itemBuilder: (context, index) =>
                  ProductCard(data: state.products[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            ),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({required this.data, super.key});

  final ProductModel data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            data.image ?? '',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.image),
          ),
          Text(data.title ?? 'Untitled'),
          Text(data.description ?? ''),
          Text(data.price?.toString() ?? 'Unknown'),
          Text(data.category ?? ''),
          Text(data.rating?.rate?.toString() ?? ''),
          Text(data.rating?.count?.toString() ?? ''),
        ],
      ),
    );
  }
}
