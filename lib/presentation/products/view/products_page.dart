import 'package:ecommerce_app/domain/products_repository/models/models.dart';
import 'package:ecommerce_app/presentation/app/app.dart';
import 'package:ecommerce_app/presentation/cart/cart.dart';
import 'package:ecommerce_app/presentation/products/bloc/products_bloc.dart';
import 'package:ecommerce_app/presentation/utils/widgets/api_state_widgets/api_state_widget.dart';
import 'package:ecommerce_app/presentation/utils/widgets/widgets.dart';
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
              padding: const EdgeInsets.all(16),
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
    final textTheme = Theme.of(context).textTheme;
    final titleMedium = textTheme.titleMedium;
    final bodySmall = textTheme.bodySmall;
    final labelMedium = textTheme.labelMedium;
    final labelLarge = textTheme.labelLarge;
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                data.image ?? '',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              data.titleText,
              textAlign: TextAlign.center,
              style: titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            if (data.description != null) ...[
              Text(
                data.description!,
                textAlign: TextAlign.center,
                style: bodySmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 8),
            ],
            if (data.category != null) ...[
              Chip(
                label: Text(data.category!, style: labelMedium),
                visualDensity: VisualDensity.compact,
              ),
              const SizedBox(height: 8),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data.priceText, style: labelLarge),
                if (data.ratingText != null)
                  Text(data.ratingText!, style: labelLarge),
              ],
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Add to cart',
              onPressed: () =>
                  context.read<CartBloc>().add(AddItemEvent(data.toCartItem)),
            ),
          ],
        ),
      ),
    );
  }
}
