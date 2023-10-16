import 'package:ecommerce_app/common/cache_client/cache_client.dart';
import 'package:ecommerce_app/data/helpers/helpers.dart';
import 'package:ecommerce_app/domain/auth_repository/repository.dart';
import 'package:ecommerce_app/domain/products_repository/repository.dart';
import 'package:ecommerce_app/presentation/app/app.dart';
import 'package:ecommerce_app/presentation/products/products.dart';
import 'package:ecommerce_app/presentation/products/view/products_page.dart';
import 'package:ecommerce_app/presentation/sign_in/sign_in.dart';
import 'package:ecommerce_app/presentation/sign_in/view/sign_in_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';

import '../test/helpers/helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('End to end test', () {
    testWidgets('Start App, fill and submit sign up form and find products',
        (tester) async {
      APIConfig.baseUrl = 'https://mocki.io/v1';
      await HiveCacheClient.initializeCache();

      GetIt.I
        ..registerSingleton<AuthRepository>(AuthRepositoryImpl())
        ..registerSingleton<ProductsRepository>(ProductsRepositoryImpl());

      await tester.pumpAndSettle();

      await tester.pumpApp(App());

      await tester.pumpAndSettle();

      expect(find.byType(AppView), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(SignInView), findsOneWidget);
      expect(find.byType(SignInPage), findsOneWidget);

      await tester.enterText(find.byType(EmailTextField), 'testuser@test.com');
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(PasswordTextField), '12345678');
      await tester.pumpAndSettle();
      await tester.tap(find.byType(SignInButton));
      await tester.pumpAndSettle();

      expect(find.byType(ProductsView), findsOneWidget);
      expect(find.byType(ProductsPage), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byType(ProductCard), findsWidgets);
    });
  });
}
