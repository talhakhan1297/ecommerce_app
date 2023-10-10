import 'package:ecommerce_app/data/helpers/helpers.dart';
import 'package:ecommerce_app/data/products/config/config.dart';
import 'package:ecommerce_app/data/products/entities/entities.dart';

export 'package:ecommerce_app/data/products/entities/entities.dart';

part 'products_api.dart';

// ignore: one_member_abstracts
abstract class ProductsApi {
  Future<List<ProductEntity>> getProducts();
}
