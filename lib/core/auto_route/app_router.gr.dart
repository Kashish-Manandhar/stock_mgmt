// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:stock_management/features/categories/presentation/screens/categories_screen.dart'
    as _i3;
import 'package:stock_management/features/home/presentation/dashboard_screen.dart'
    as _i4;
import 'package:stock_management/features/products/data/product_model.dart'
    as _i10;
import 'package:stock_management/features/products/presentation/screens/add_products_screen.dart'
    as _i1;
import 'package:stock_management/features/products/presentation/screens/product_detail_screen.dart'
    as _i5;
import 'package:stock_management/features/products/presentation/screens/product_screen.dart'
    as _i6;
import 'package:stock_management/features/sales/presentation/add_sales_screen.dart'
    as _i2;
import 'package:stock_management/features/sales/presentation/sales_screen.dart'
    as _i7;

/// generated route for
/// [_i1.AddProductsScreen]
class AddProductsRoute extends _i8.PageRouteInfo<AddProductsRouteArgs> {
  AddProductsRoute({
    _i9.Key? key,
    _i10.Product? product,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          AddProductsRoute.name,
          args: AddProductsRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'AddProductsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddProductsRouteArgs>(
          orElse: () => const AddProductsRouteArgs());
      return _i1.AddProductsScreen(
        key: args.key,
        product: args.product,
      );
    },
  );
}

class AddProductsRouteArgs {
  const AddProductsRouteArgs({
    this.key,
    this.product,
  });

  final _i9.Key? key;

  final _i10.Product? product;

  @override
  String toString() {
    return 'AddProductsRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i2.AddSalesScreen]
class AddSalesRoute extends _i8.PageRouteInfo<void> {
  const AddSalesRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AddSalesRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddSalesRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddSalesScreen();
    },
  );
}

/// generated route for
/// [_i3.CategoriesScreen]
class CategoriesRoute extends _i8.PageRouteInfo<void> {
  const CategoriesRoute({List<_i8.PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.CategoriesScreen();
    },
  );
}

/// generated route for
/// [_i4.DashboardScreen]
class DashboardRoute extends _i8.PageRouteInfo<void> {
  const DashboardRoute({List<_i8.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i5.ProductDetailScreen]
class ProductDetailRoute extends _i8.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i9.Key? key,
    required _i10.Product product,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ProductDetailRoute.name,
          args: ProductDetailRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>();
      return _i5.ProductDetailScreen(
        key: args.key,
        product: args.product,
      );
    },
  );
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({
    this.key,
    required this.product,
  });

  final _i9.Key? key;

  final _i10.Product product;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i6.ProductScreen]
class ProductRoute extends _i8.PageRouteInfo<void> {
  const ProductRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ProductRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.ProductScreen();
    },
  );
}

/// generated route for
/// [_i7.SalesScreen]
class SalesRoute extends _i8.PageRouteInfo<void> {
  const SalesRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SalesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SalesRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SalesScreen();
    },
  );
}
