import 'package:my_ecommerce_bloc_app/bootstrap.dart';
import 'package:my_ecommerce_bloc_app/data/helpers/api_config.dart';
import 'package:my_ecommerce_bloc_app/presentation/app/app.dart';

void main() {
  APIConfig.baseUrl = 'devUrl';
  bootstrap(App.new);
}
