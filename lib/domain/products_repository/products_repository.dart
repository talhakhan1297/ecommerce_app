part of 'repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  ProductsRepositoryImpl({
    ProductsApi? productsApi,
  }) : _api = productsApi ?? ProductsApiImpl();

  final ProductsApi _api;

  @override
  Future<List<ProductModel>> getProducts() async {
    final entity = await _api.getProducts();

    return entity.map(ProductModel.fromEntity).toList();
  }
}
