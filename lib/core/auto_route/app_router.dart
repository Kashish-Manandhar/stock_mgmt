import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'app_router.gr.dart';

@injectable
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: DashboardWrapperRoute.page, initial: true, children: [
          AutoRoute(
            page: ProductRoute.page,
          ),
          AutoRoute(
            page: AddProductsRoute.page,
          ),
          AutoRoute(
            page: ProductDetailRoute.page,
          ),
          AutoRoute(
            page: CategoriesRoute.page,
          ),
          AutoRoute(
            page: DashboardRoute.page,
            initial: true,
          ),
          AutoRoute(
            page: AddSalesRoute.page,
          ),
          AutoRoute(
            page: SalesRoute.page,
          ),
        ]),
      ];
}
