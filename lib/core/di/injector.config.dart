// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/categories/data/categories_data_source.dart' as _i645;
import '../../features/categories/data/categories_local_source.dart' as _i508;
import '../../features/categories/presentation/cubit/add_category_cubit/add_category_cubit.dart'
    as _i481;
import '../../features/categories/presentation/cubit/categories_cubit/categories_cubit.dart'
    as _i71;
import '../../features/products/data/product_data_source.dart' as _i252;
import '../../features/products/data/product_local_source.dart' as _i477;
import '../../features/products/data/product_model.dart' as _i543;
import '../../features/products/presentation/cubit/add_product_cubit.dart'
    as _i165;
import '../../features/products/presentation/cubit/product_cubit/product_cubit.dart'
    as _i326;
import '../../features/sales/data/sales_data_source.dart' as _i646;
import '../auto_route/app_router.dart' as _i835;
import '../helpers/image_upload_helper.dart' as _i140;
import 'di.dart' as _i913;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModules = _$InjectableModules();
    gh.factory<_i835.AppRouter>(() => _i835.AppRouter());
    gh.factory<_i508.CategoriesLocalSource>(
        () => _i508.CategoriesLocalSource());
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => injectableModules.firebaseFireStore);
    gh.lazySingleton<_i457.FirebaseStorage>(
        () => injectableModules.firebaseStorage);
    gh.lazySingleton<_i477.ProductLocalSource>(
        () => _i477.ProductLocalSource());
    gh.factory<_i646.SalesDataSource>(
        () => _i646.SalesDataSource(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i252.ProductDataSource>(
        () => _i252.ProductDataSource(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i140.ImageUploadHelper>(
        () => _i140.ImageUploadHelper(gh<_i457.FirebaseStorage>()));
    gh.factory<_i645.CategoriesDataSource>(() => _i645.CategoriesDataSource(
          gh<_i974.FirebaseFirestore>(),
          gh<_i508.CategoriesLocalSource>(),
        ));
    gh.factoryParam<_i165.AddProductCubit, _i543.Product?, dynamic>((
      product,
      _,
    ) =>
        _i165.AddProductCubit(
          productDataSource: gh<_i252.ProductDataSource>(),
          imageUploadHelper: gh<_i140.ImageUploadHelper>(),
          product: product,
        )..feedData());
    gh.factory<_i71.CategoriesCubit>(() => _i71.CategoriesCubit(
          gh<_i508.CategoriesLocalSource>(),
          gh<_i645.CategoriesDataSource>(),
        )..fetchCategoryList());
    gh.factory<_i326.ProductCubit>(() =>
        _i326.ProductCubit(gh<_i252.ProductDataSource>())..fetchAllProducts());
    gh.factory<_i481.AddCategoryCubit>(() => _i481.AddCategoryCubit(
          gh<_i508.CategoriesLocalSource>(),
          gh<_i645.CategoriesDataSource>(),
        ));
    return this;
  }
}

class _$InjectableModules extends _i913.InjectableModules {}
