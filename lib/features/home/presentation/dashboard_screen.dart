import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/core/auto_route/app_router.gr.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            title: Text('Categories'),
            onTap: () => context.router.navigate(const CategoriesRoute()),
          ),
          ListTile(
            title: Text('Products'),
            onTap: () => context.router.navigate(const ProductRoute()),
          ),
          ListTile(
            title: Text('Sales'),
            onTap: () => context.router.navigate(const AddSalesRoute()),
          ),
        ],
      ),
    );
  }
}
