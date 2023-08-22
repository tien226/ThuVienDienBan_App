import 'package:app/model/book/book_response.dart';
import 'package:app/model/borrow_book/borrow_book_response.dart';
import 'package:app/model/category/category_response.dart';
import 'package:app/model/home/home_response.dart';
import 'package:app/model/login/login_response.dart';
import 'package:app/model/order_book_list/order_book_response.dart';
import 'package:app/model/register/register_response.dart';
import 'package:app/repository/app_repository.dart';
import 'package:app/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRepositoryImpl extends AppRepository {
  final String ACCESS_TOKEN_KEY = "access_token";
  final Dio dio;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  AppRepositoryImpl({required this.dio});

// API LOGIN
  @override
  Future<LoginResponse> login(String userName, String passWord) async {
    try {
      final result = await dio.post("api/v1/account/user/login/",
          data: {"username": userName, "password": passWord});

      if (result.statusCode == 200) {
        final ressultFromJson = LoginResponse.fromJson(result.data);
        await _saveAccessTokenTolocal(ressultFromJson.token);
        return ressultFromJson;
      }

      throw Exception('Login failed: ${result.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }

// API RGISTER ACCOUNT
  @override
  Future<RegisterResponse> registerAccount(
      String password, String name, String phoneNumber, String email) async {
    try {
      final result = await dio.post(
        "api/v1/account/user/signup/",
        data: {
          "password": password,
          "phone_number": phoneNumber,
          "email": email,
          "username": name
        },
      );

      if (result.statusCode == 200) {
        final ressultFromJson = RegisterResponse.fromJson(result.data);
        return ressultFromJson;
      }

      throw Exception('Register failed: ${result.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveAccessTokenTolocal(String token) async {
    try {
      final pref = await _prefs;
      await pref.setString(ACCESS_TOKEN_KEY, token);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> _getAccessTokenTolocal() async {
    final pref = await _prefs;
    return pref.getString(ACCESS_TOKEN_KEY) ?? "";
  }

// API GET CATEGORY LIST
  @override
  Future<List<Category>> getCategoryList() async {
    try {
      final formatAuthorization = await _formatAuthorizationHeader();

      final result = await dio.get("api/v1/library/category/",
          options: Options(headers: {"Authorization": formatAuthorization}));

      if (result.statusCode == 200) {
        final List<Category> categories = (result.data as List)
            .map((item) => Category.fromJson(item))
            .toList();
        return categories;
      }

      throw Exception('Get category list failed: ${result.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _formatAuthorizationHeader() async {
    final token = await _getAccessTokenTolocal();
    return "JWT $token";
  }

// GET BOOK LIST
  @override
  Future<List<Book>> getBookList() async {
    try {
      final formatAuthorization = await _formatAuthorizationHeader();

      final result = await dio.get("api/v1/library/book/",
          options: Options(headers: {"Authorization": formatAuthorization}));

      if (result.statusCode == 200) {
        Map<String, dynamic> response = result.data;
        List<dynamic> items = response['items'];

        final List<Book> books =
            items.map((item) => Book.fromJson(item)).toList();
        return books;
      }

      throw Exception('Get book list failed: ${result.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }

  // GET BOOK ITEM DETAILS
  @override
  Future<Book> getBookDetail(int bookId) async {
    try {
      final formatAuthorization = await _formatAuthorizationHeader();

      final result = await dio.get(
        "api/v1/library/book/$bookId",
        options: Options(
          headers: {"Authorization": formatAuthorization},
        ),
        // queryParameters: {"book_id": bookId},
      );

      if (result.statusCode == 200) {
        final ressultFromJson = Book.fromJson(result.data);
        return ressultFromJson;
      }

      throw Exception('Get book details failed: ${result.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Book>> callAPISearchBook(String bookName) async {
    try {
      final formatAuthorization = await _formatAuthorizationHeader();

      final result = await dio.get(
        "api/v1/library/book/",
        options: Options(
          headers: {"Authorization": formatAuthorization},
        ),
        queryParameters: {"search": bookName},
      );

      if (result.statusCode == 200) {
        Map<String, dynamic> response = result.data;
        List<dynamic> items = response['items'];

        final List<Book> books =
            items.map((item) => Book.fromJson(item)).toList();
        return books;
      }

      throw Exception('Get book list search failed: ${result.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }

// GET DATA HOME RESPONSE
  @override
  Future<List<HomeData>> getDataHome() async {
    try {
      final formatAuthorization = await _formatAuthorizationHeader();

      final result = await dio.get("api/v1/library/book/home/",
          options: Options(headers: {"Authorization": formatAuthorization}));

      if (result.statusCode == 200) {
        List<dynamic> resultList = result.data;
        return resultList.map((e) => HomeData.fromJson(e)).toList();
      }

      throw Exception('Get Data Home failed: ${result.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }

// BORROW BOOK
  @override
  Future<BorrowBookResponse> callAPIrequestBorrowBook(int bookId) async {
    try {
      final formatAuthorization = await _formatAuthorizationHeader();

      final result = await dio.post(
        "api/v1/library/mobile/order/",
        options: Options(
          headers: {"Authorization": formatAuthorization},
        ),
        data: {"book": bookId},
      );

      if (result.statusCode == 200 || result.statusCode == 201) {
        final ressultFromJson = BorrowBookResponse.fromJson(result.data);
        return ressultFromJson;
      }

      throw Exception('Request borrow book failed: ${result.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }

// GET ORDER BOOK
  @override
  Future<List<OrderBook>> getOrderBookList() async {
    try {
      final formatAuthorization = await _formatAuthorizationHeader();

      final result = await dio.get("api/v1/library/mobile/order/",
          options: Options(headers: {"Authorization": formatAuthorization}));

      if (result.statusCode == 200) {
        Map<String, dynamic> response = result.data;
        List<dynamic> items = response['items'];

        final List<OrderBook> books =
            items.map((item) => OrderBook.fromJson(item)).toList();
        return books;
      }

      throw Exception('Get order book list failed: ${result.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }

// CANCEL ORDER BOOK
  @override
  Future<OrderBook> cancelBorrowBook(int orderId) async {
    try {
      final formatAuthorization = await _formatAuthorizationHeader();

      final result = await dio.put(
        "api/v1/library/mobile/order/$orderId/",
        options: Options(
          headers: {"Authorization": formatAuthorization},
        ),
        data: {"status": Constants.CANCELED},
      );

      if (result.statusCode == 200) {
        final ressultFromJson = OrderBook.fromJson(result.data);
        return ressultFromJson;
      }

      throw Exception('Cancel borrow book failed: ${result.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }
}
