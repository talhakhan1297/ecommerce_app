part of 'api.dart';

class ProductsApiImpl extends ProductsApi {
  ProductsApiImpl({APIClient? client}) : _client = client ?? APIClient();

  final APIClient _client;

  @override
  Future<List<ProductEntity>> getProducts() async {
    final data = await _client.get(handle: ProductsEndpoints.products);
    return (data as List?)
            ?.map((e) => ProductEntity.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }
}
