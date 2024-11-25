import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_management/core/constants/hive_constants.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';
import 'package:stock_management/firebase_options.dart';

import 'app.dart';
import 'core/di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  configureDependencies();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CategoriesModelImplAdapter());

  // await Hive.openBox<Product>(HiveConstants.productBox);
  await Hive.openBox<CategoriesModel>(HiveConstants.categoryBox);

  getIt<FirebaseFirestore>().settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const MyApp());
}
