import 'package:auto_route/auto_route.dart';

import 'auto_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(path: "/", page: LoginRoute.page),
        AutoRoute(path: "/register", page: RegisterRoute.page),
        CustomRoute(page: BookDetailRoute.page, path: "/book_detail", transitionsBuilder: TransitionsBuilders.fadeIn, durationInMilliseconds: 600),
        AutoRoute(page: CategoryBookRoute.page),
        AutoRoute(page: SearchBookRoute.page),
        AutoRoute(page: BookLoanDetailRoute.page),
        AutoRoute(
            page: MainBottomNavigationRoute.page,
            path: '/main',
            children: [
              AutoRoute(page: HomeContainerRoute.page, path: 'home'),
              AutoRoute(page: BookLoanManagerRoute.page, path: 'book_loan'),
            ]),
        AutoRoute(page: ReadBookRoute.page),
      ];
}
