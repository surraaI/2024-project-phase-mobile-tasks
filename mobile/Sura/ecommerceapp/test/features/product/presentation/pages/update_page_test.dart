import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerceapp/features/product/domain/entity/product_entity.dart';
import 'package:ecommerceapp/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerceapp/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerceapp/features/product/presentation/bloc/product_state.dart';
import 'package:ecommerceapp/features/product/presentation/pages/update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState> implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
    HttpOverrides.global = null;
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ProductBloc>.value(
        value: mockProductBloc,
        child: const UpdatePage(),
      ),
    );
  }

  group('UpdatePage Widget Tests', () {
    testWidgets('should display the correct widgets', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Category'), findsOneWidget);
      expect(find.text('Price'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });
  });
}
