part of 'products_bloc.dart';

class ProductsState extends Equatable {
  const ProductsState({
    this.productApiState = const APIState<List<ProductModel>>(),
  });

  final APIState<List<ProductModel>> productApiState;

  ProductsState copyWith({
    APIState<List<ProductModel>>? productApiState,
  }) {
    return ProductsState(
      productApiState: productApiState ?? this.productApiState,
    );
  }

  List<ProductModel> get products => productApiState.data ?? [];

  @override
  List<Object> get props => [productApiState];
}
