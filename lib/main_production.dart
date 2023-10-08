import 'package:ecommerce_app/bootstrap.dart';
import 'package:ecommerce_app/data/helpers/api_config.dart';
import 'package:ecommerce_app/presentation/app/app.dart';

void main() {
  APIConfig.baseUrl = 'https://mocki.io/v1';
  bootstrap(App.new);
}
