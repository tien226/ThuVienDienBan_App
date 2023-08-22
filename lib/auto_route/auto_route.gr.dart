// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/model/book/book_response.dart' as _i15;
import 'package:app/model/category/category_response.dart' as _i16;
import 'package:app/model/home/home_response.dart' as _i17;
import 'package:app/model/order_book_list/order_book_response.dart' as _i14;
import 'package:app/screen/book_detail_screen.dart' as _i1;
import 'package:app/screen/book_loan_detail_screen.dart' as _i2;
import 'package:app/screen/book_loan_manager.dart' as _i3;
import 'package:app/screen/category_book_screen.dart' as _i4;
import 'package:app/screen/home.dart' as _i6;
import 'package:app/screen/home_container_screen.dart' as _i5;
import 'package:app/screen/login.dart' as _i7;
import 'package:app/screen/main_bottom_nav.dart' as _i8;
import 'package:app/screen/read_book_screen.dart' as _i9;
import 'package:app/screen/register.dart' as _i10;
import 'package:app/screen/search_book_screen.dart' as _i11;
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    BookDetailRoute.name: (routeData) {
      final args = routeData.argsAs<BookDetailRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BookDetailScreen(
          key: args.key,
          bookId: args.bookId,
        ),
      );
    },
    BookLoanDetailRoute.name: (routeData) {
      final args = routeData.argsAs<BookLoanDetailRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BookLoanDetailScreen(
          key: args.key,
          orderBook: args.orderBook,
          onBack: args.onBack,
        ),
      );
    },
    BookLoanManagerRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BookLoanManagerScreen(),
      );
    },
    CategoryBookRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryBookRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.CategoryBookScreen(
          key: args.key,
          bookList: args.bookList,
        ),
      );
    },
    HomeContainerRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeContainerScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.HomeScreen(
          key: args.key,
          categorys: args.categorys,
          books: args.books,
          homeDatas: args.homeDatas,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginScreen(),
      );
    },
    MainBottomNavigationRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.MainBottomNavigationScreen(),
      );
    },
    ReadBookRoute.name: (routeData) {
      final args = routeData.argsAs<ReadBookRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.ReadBookScreen(
          key: args.key,
          bookName: args.bookName,
          fileURL: args.fileURL,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.RegisterScreen(),
      );
    },
    SearchBookRoute.name: (routeData) {
      final args = routeData.argsAs<SearchBookRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.SearchBookScreen(
          key: args.key,
          bookList: args.bookList,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.BookDetailScreen]
class BookDetailRoute extends _i12.PageRouteInfo<BookDetailRouteArgs> {
  BookDetailRoute({
    _i13.Key? key,
    required int bookId,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          BookDetailRoute.name,
          args: BookDetailRouteArgs(
            key: key,
            bookId: bookId,
          ),
          initialChildren: children,
        );

  static const String name = 'BookDetailRoute';

  static const _i12.PageInfo<BookDetailRouteArgs> page =
      _i12.PageInfo<BookDetailRouteArgs>(name);
}

class BookDetailRouteArgs {
  const BookDetailRouteArgs({
    this.key,
    required this.bookId,
  });

  final _i13.Key? key;

  final int bookId;

  @override
  String toString() {
    return 'BookDetailRouteArgs{key: $key, bookId: $bookId}';
  }
}

/// generated route for
/// [_i2.BookLoanDetailScreen]
class BookLoanDetailRoute extends _i12.PageRouteInfo<BookLoanDetailRouteArgs> {
  BookLoanDetailRoute({
    _i13.Key? key,
    required _i14.OrderBook orderBook,
    void Function()? onBack,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          BookLoanDetailRoute.name,
          args: BookLoanDetailRouteArgs(
            key: key,
            orderBook: orderBook,
            onBack: onBack,
          ),
          initialChildren: children,
        );

  static const String name = 'BookLoanDetailRoute';

  static const _i12.PageInfo<BookLoanDetailRouteArgs> page =
      _i12.PageInfo<BookLoanDetailRouteArgs>(name);
}

class BookLoanDetailRouteArgs {
  const BookLoanDetailRouteArgs({
    this.key,
    required this.orderBook,
    this.onBack,
  });

  final _i13.Key? key;

  final _i14.OrderBook orderBook;

  final void Function()? onBack;

  @override
  String toString() {
    return 'BookLoanDetailRouteArgs{key: $key, orderBook: $orderBook, onBack: $onBack}';
  }
}

/// generated route for
/// [_i3.BookLoanManagerScreen]
class BookLoanManagerRoute extends _i12.PageRouteInfo<void> {
  const BookLoanManagerRoute({List<_i12.PageRouteInfo>? children})
      : super(
          BookLoanManagerRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookLoanManagerRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CategoryBookScreen]
class CategoryBookRoute extends _i12.PageRouteInfo<CategoryBookRouteArgs> {
  CategoryBookRoute({
    _i13.Key? key,
    required List<_i15.Book> bookList,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          CategoryBookRoute.name,
          args: CategoryBookRouteArgs(
            key: key,
            bookList: bookList,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryBookRoute';

  static const _i12.PageInfo<CategoryBookRouteArgs> page =
      _i12.PageInfo<CategoryBookRouteArgs>(name);
}

class CategoryBookRouteArgs {
  const CategoryBookRouteArgs({
    this.key,
    required this.bookList,
  });

  final _i13.Key? key;

  final List<_i15.Book> bookList;

  @override
  String toString() {
    return 'CategoryBookRouteArgs{key: $key, bookList: $bookList}';
  }
}

/// generated route for
/// [_i5.HomeContainerScreen]
class HomeContainerRoute extends _i12.PageRouteInfo<void> {
  const HomeContainerRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeContainerRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeContainerRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i12.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i13.Key? key,
    required List<_i16.Category> categorys,
    required List<_i15.Book> books,
    required List<_i17.HomeData> homeDatas,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            categorys: categorys,
            books: books,
            homeDatas: homeDatas,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i12.PageInfo<HomeRouteArgs> page =
      _i12.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    required this.categorys,
    required this.books,
    required this.homeDatas,
  });

  final _i13.Key? key;

  final List<_i16.Category> categorys;

  final List<_i15.Book> books;

  final List<_i17.HomeData> homeDatas;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, categorys: $categorys, books: $books, homeDatas: $homeDatas}';
  }
}

/// generated route for
/// [_i7.LoginScreen]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i8.MainBottomNavigationScreen]
class MainBottomNavigationRoute extends _i12.PageRouteInfo<void> {
  const MainBottomNavigationRoute({List<_i12.PageRouteInfo>? children})
      : super(
          MainBottomNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainBottomNavigationRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ReadBookScreen]
class ReadBookRoute extends _i12.PageRouteInfo<ReadBookRouteArgs> {
  ReadBookRoute({
    _i13.Key? key,
    required String bookName,
    required String fileURL,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ReadBookRoute.name,
          args: ReadBookRouteArgs(
            key: key,
            bookName: bookName,
            fileURL: fileURL,
          ),
          initialChildren: children,
        );

  static const String name = 'ReadBookRoute';

  static const _i12.PageInfo<ReadBookRouteArgs> page =
      _i12.PageInfo<ReadBookRouteArgs>(name);
}

class ReadBookRouteArgs {
  const ReadBookRouteArgs({
    this.key,
    required this.bookName,
    required this.fileURL,
  });

  final _i13.Key? key;

  final String bookName;

  final String fileURL;

  @override
  String toString() {
    return 'ReadBookRouteArgs{key: $key, bookName: $bookName, fileURL: $fileURL}';
  }
}

/// generated route for
/// [_i10.RegisterScreen]
class RegisterRoute extends _i12.PageRouteInfo<void> {
  const RegisterRoute({List<_i12.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SearchBookScreen]
class SearchBookRoute extends _i12.PageRouteInfo<SearchBookRouteArgs> {
  SearchBookRoute({
    _i13.Key? key,
    required List<_i15.Book> bookList,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          SearchBookRoute.name,
          args: SearchBookRouteArgs(
            key: key,
            bookList: bookList,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchBookRoute';

  static const _i12.PageInfo<SearchBookRouteArgs> page =
      _i12.PageInfo<SearchBookRouteArgs>(name);
}

class SearchBookRouteArgs {
  const SearchBookRouteArgs({
    this.key,
    required this.bookList,
  });

  final _i13.Key? key;

  final List<_i15.Book> bookList;

  @override
  String toString() {
    return 'SearchBookRouteArgs{key: $key, bookList: $bookList}';
  }
}
