import 'package:ecommerce_app/domain/cart_repository/repository.dart';
import 'package:ecommerce_app/presentation/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/presentation/utils/widgets/api_state_widgets/api_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  static String route = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return APIStateWidget<Map<int, CartItemModel>>(
            apiState: state.getCartState,
            emptyErrorMessage: 'Your cart is empty!',
            onRetry: () => context.read<CartBloc>().add(FetchCartEvent()),
            successWidget: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) =>
                        CartItemCard(data: state.cartItems[index]),
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount: ${state.totalAmountText}'),
                      OutlinedButton(
                        onPressed: () =>
                            context.read<CartBloc>().add(ClearCartEvent()),
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  const CartItemCard({required this.data, super.key});

  final CartItemModel data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodySmall = textTheme.bodySmall;
    final labelLarge = textTheme.labelLarge;
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                data.product.image ?? '',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.product.titleText,
                    style: bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context
                            .read<CartBloc>()
                            .add(DecrementItemEvent(data.product.id!)),
                        icon: const Icon(Icons.remove),
                      ),
                      Text(data.quantity.toString(), style: labelLarge),
                      IconButton(
                        onPressed: () => context
                            .read<CartBloc>()
                            .add(IncrementItemEvent(data.product.id!)),
                        icon: const Icon(Icons.add),
                      ),
                      const Spacer(),
                      Text(data.itemTotalPriceText, style: labelLarge),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            IconButton.filledTonal(
              onPressed: () => context
                  .read<CartBloc>()
                  .add(RemoveItemEvent(data.product.id!)),
              icon: const Icon(Icons.delete_outline_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
