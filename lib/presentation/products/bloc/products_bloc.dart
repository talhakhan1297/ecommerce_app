import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/common/custom_exception.dart';
import 'package:ecommerce_app/domain/products_repository/repository.dart';
import 'package:ecommerce_app/presentation/utils/helpers/api_state.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({
    required ProductsRepository productsRepository,
  })  : _productsRepository = productsRepository,
        super(const ProductsState()) {
    on<FetchProductsEvent>(_onFetchProductsEvent);
  }

  final ProductsRepository _productsRepository;

  Future<void> _onFetchProductsEvent(
    FetchProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(productApiState: state.productApiState.toLoading()));

    try {
      final data = await _productsRepository.getProducts();

      emit(
        state.copyWith(
          productApiState: state.productApiState.toLoaded(data: data),
        ),
      );
    } on CustomException catch (e) {
      emit(
        state.copyWith(
          productApiState: state.productApiState.toFailure(error: e.message),
        ),
      );
    } catch (_) {
      emit(state.copyWith(productApiState: state.productApiState.toFailure()));
    }
  }
}
