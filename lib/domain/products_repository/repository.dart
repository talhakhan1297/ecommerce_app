import 'package:ecommerce_app/data/products_api/api.dart';
import 'package:ecommerce_app/domain/products_repository/models/models.dart';

export 'package:ecommerce_app/domain/products_repository/models/models.dart';

part 'products_repository.dart';

// ignore: one_member_abstracts
abstract class ProductsRepository {
  Future<List<ProductModel>> getProducts();
}
