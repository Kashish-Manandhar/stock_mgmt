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
            title: const Text('Categories'),
            onTap: () => context.router.navigate(const CategoriesRoute()),
          ),
          ListTile(
            title: const Text('Products'),
            onTap: () => context.router.navigate(const ProductsWrapperRoute()),
          ),
          ListTile(
            title: const Text('Sales'),
            onTap: () => context.router.navigate(const SalesRoute()),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () => context.router.navigate(const ProfileRoute()),
          ),
          ListTile(
            title: const Text('Reports'),
            onTap: () => context.router.navigate(const ReportsRoute()),
          ),
        ],
      ),
    );
  }
}
