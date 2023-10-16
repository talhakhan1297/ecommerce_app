// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/domain/products_repository/repository.dart';
import 'package:ecommerce_app/presentation/app/bloc/app_bloc.dart';
import 'package:ecommerce_app/presentation/products/products.dart';
import 'package:ecommerce_app/presentation/products/view/products_page.dart';
import 'package:ecommerce_app/presentation/utils/helpers/api_state.dart';
import 'package:ecommerce_app/presentation/utils/widgets/api_state_widgets/api_state_widget.dart';
import 'package:ecommerce_app/presentation/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/network_image_mock.dart';

class MockProductsBloc extends MockBloc<ProductsEvent, ProductsState>
    implements ProductsBloc {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

extension on WidgetTester {
  Future<void> pumpProductsPage(ProductsBloc bloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: bloc,
          child: ProductsPage(),
        ),
      ),
    );
  }
}

void main() {
  late ProductsBloc productsBloc;
  late AppBloc appBloc;

  setUp(() {
    productsBloc = MockProductsBloc();
    appBloc = MockAppBloc();
  });

  group('ProductsView', () {
    final mockProducts = List.generate(
      5,
      (i) => ProductModel(
        id: i,
        title: 'accusamus beatae ad facilis cum similique qui sunt',
        price: 10.0,
        description: 'accusamus beatae ad facilis cum similique qui sunt',
        category: 'testCat',
        image: '',
        rating: RatingModel(rate: 4.5, count: 10),
      ),
    );

    testWidgets(
      'renders AppBar with title text',
      (tester) async {
        when(() => productsBloc.state).thenReturn(const ProductsState());
        await tester.pumpProductsPage(productsBloc);

        expect(find.byType(AppBar), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(AppBar),
            matching: find.text('Products'),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'calls add(LogoutRequested()) on press of logout button',
      (tester) async {
        when(() => productsBloc.state).thenReturn(const ProductsState());
        await tester.pumpWidget(
          MaterialApp(
            home: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: productsBloc),
                BlocProvider.value(value: appBloc),
              ],
              child: ProductsPage(),
            ),
          ),
        );

        expect(find.byType(IconButton), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(IconButton),
            matching: find.byIcon(Icons.logout_rounded),
          ),
          findsOneWidget,
        );

        await tester.tap(find.byType(IconButton));

        verify(() => appBloc.add(LogoutRequested())).called(1);
      },
    );

    testWidgets(
        'renders SizedBox '
        'when products status is initial', (tester) async {
      when(() => productsBloc.state).thenReturn(const ProductsState());
      await tester.pumpProductsPage(productsBloc);
      expect(find.byKey(Key('Initial_SizedBox')), findsOneWidget);
    });

    testWidgets(
        'renders AppProgress '
        'when products status is loading', (tester) async {
      when(() => productsBloc.state).thenReturn(
        ProductsState(
          productApiState:
              APIState<List<ProductModel>>(state: APICallState.loading),
        ),
      );
      await tester.pumpProductsPage(productsBloc);
      expect(find.byType(AppProgress), findsOneWidget);
    });

    testWidgets(
        'renders Empty Products Message '
        'when products status is success but with 0 photos', (tester) async {
      when(() => productsBloc.state).thenReturn(
        ProductsState(
          productApiState:
              APIState<List<ProductModel>>(state: APICallState.loaded),
        ),
      );
      await tester.pumpProductsPage(productsBloc);
      expect(find.text('No products found!'), findsOneWidget);
    });

    testWidgets(
        'calls add(FetchProductsEvent()) on press of retry button '
        'when products status is success but with 0 photos', (tester) async {
      when(() => productsBloc.state).thenReturn(
        ProductsState(
          productApiState:
              APIState<List<ProductModel>>(state: APICallState.loaded),
        ),
      );
      await tester.pumpProductsPage(productsBloc);
      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(PrimaryButton),
          matching: find.text('Try again'),
        ),
        findsOneWidget,
      );

      await tester.tap(find.byType(PrimaryButton));

      verify(() => productsBloc.add(FetchProductsEvent())).called(1);
    });

    testWidgets(
        'renders ProductCard '
        'when products status is success with mockProducts', (tester) async {
      when(() => productsBloc.state).thenReturn(
        ProductsState(
          productApiState: APIState<List<ProductModel>>(
            state: APICallState.loaded,
            data: mockProducts,
          ),
        ),
      );
      await tester.pumpProductsPage(productsBloc);
      expect(find.byType(ProductCard), findsWidgets);
    });

    testWidgets(
        'renders AppError '
        'when products status is failure', (tester) async {
      when(() => productsBloc.state).thenReturn(
        ProductsState(
          productApiState:
              APIState<List<ProductModel>>(state: APICallState.failure),
        ),
      );
      await tester.pumpProductsPage(productsBloc);
      expect(find.byType(AppError), findsOneWidget);
    });

    testWidgets(
        'calls add(FetchProductsEvent()) on press of retry button '
        'when products status is failure', (tester) async {
      when(() => productsBloc.state).thenReturn(
        ProductsState(
          productApiState:
              APIState<List<ProductModel>>(state: APICallState.failure),
        ),
      );
      await tester.pumpProductsPage(productsBloc);
      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(PrimaryButton),
          matching: find.text('Try again'),
        ),
        findsOneWidget,
      );

      await tester.tap(find.byType(PrimaryButton));

      verify(() => productsBloc.add(FetchProductsEvent())).called(1);
    });

    testWidgets('renders ProductCard Image', (tester) async {
      await mockNetworkImagesFor(
        () async => tester.pumpWidget(
          MaterialApp(home: ProductCard(data: mockProducts.first)),
        ),
      );
      await tester.pump();
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders ProductCard Image errorBuilder on error',
        (tester) async {
      await mockNetworkImagesErrorFor(
        () async => tester.pumpWidget(
          MaterialApp(home: ProductCard(data: mockProducts.first)),
        ),
      );
      await tester.pump();
      expect(find.byIcon(Icons.image), findsOneWidget);
    });
  });
}
