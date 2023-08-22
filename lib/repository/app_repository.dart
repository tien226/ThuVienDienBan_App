import 'package:app/model/borrow_book/borrow_book_response.dart';
import 'package:app/model/home/home_response.dart';
import 'package:app/model/order_book_list/order_book_response.dart';

import '../model/book/book_response.dart';
import '../model/category/category_response.dart';
import '../model/login/login_response.dart';
import '../model/register/register_response.dart';

abstract class AppRepository {
  Future<LoginResponse> login(String userName, String passWord);
  Future<RegisterResponse> registerAccount(
      String password, String name, String phoneNumber, String email);
  Future<List<Category>> getCategoryList();
  Future<List<Book>> getBookList();
  Future<Book> getBookDetail(int bookId);
  Future<List<Book>> callAPISearchBook(String bookName);
  Future<List<HomeData>> getDataHome();
  Future<BorrowBookResponse> callAPIrequestBorrowBook(int bookId);
  Future<List<OrderBook>> getOrderBookList();
  Future<OrderBook> cancelBorrowBook(int orderId); 
}
