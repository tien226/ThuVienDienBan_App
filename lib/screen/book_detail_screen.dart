import 'dart:ui';

import 'package:app/auto_route/auto_route.gr.dart';
import 'package:app/model/book/book_response.dart';
import 'package:app/repository/app_repository.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

@RoutePage()
class BookDetailScreen extends StatefulWidget {
  final int bookId;
  const BookDetailScreen({
    super.key,
    required this.bookId,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  var appRepository = GetIt.I.get<AppRepository>();
  Book? book;

  void getDataBookDetail(int bookId) async {
    try {
      var newBook = await appRepository.getBookDetail(bookId);
      setState(() {
        book = newBook;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getDataBookDetail(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return book != null
        ? Stack(children: [
            Container(
              // margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(book?.thumbnail ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0))),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    context.router.back();
                  },
                ),
              ),
              body: Body(book: book!),
            ),
          ])
        : Container(
            color: Colors.white,
          );
  }
}

class Body extends StatelessWidget {
  final appRepository = GetIt.I.get<AppRepository>();
  final Book book;
  Body({super.key, required this.book});

  void callAPIrequestBorrowBook(BuildContext context, int bookId) async {
    try {
      await appRepository.callAPIrequestBorrowBook(bookId);
      context.loaderOverlay.hide();
      context.router.navigate(const BookLoanManagerRoute());
    } catch (e) {
      context.loaderOverlay.hide();
      showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
              message: "Có lỗi xảy ra. Vui lòng kiểm tra lại!"));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoaderOverlay(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: size.height * 0.2),
                          height: size.height,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24))),
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 150,
                                height: 233,
                                // margin: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(book.thumbnail ?? ""),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Align(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  book.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 24),
                                ),
                              ),
                            ),
                            Text(
                              book.authors.map((e) => e.name).join(),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 18),
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                              endIndent: 0,
                            ),
                            IntrinsicHeight(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          book.totalAvailableBookItems
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(height: 4),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.confirmation_number,
                                                color: Colors.grey),
                                            SizedBox(width: 8),
                                            Text("Số lượng bản cứng",
                                                style: TextStyle(
                                                    color: Colors.grey))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const VerticalDivider(
                                    thickness: 0.2,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text(
                                        NumberFormat.currency(locale: "vi_VN")
                                            .format(book.price),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      const SizedBox(height: 4),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.payments,
                                              color: Colors.grey),
                                          SizedBox(width: 8),
                                          Text("Giá tiền",
                                              style:
                                                  TextStyle(color: Colors.grey))
                                        ],
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                              endIndent: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                book.description ?? "Miêu tả",
                                style: const TextStyle(height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      //  btn doc sach
                      context.router.navigate(ReadBookRoute(
                          bookName: book.title, fileURL: book.file ?? ""));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blueAccent),
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'Đọc Sách',
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // btn muon sach
                      book.isAvailable == true
                          ? showDialog(
                              context: context,
                              builder: (BuildContext contextDialog) {
                                return AlertDialog(
                                  title: const Text('Thông báo'),
                                  content: Text(
                                      'Bạn xác nhận mượn sách "${book.title}"',
                                      style: const TextStyle(height: 1.5)),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Hủy'),
                                      onPressed: () {
                                        Navigator.pop(contextDialog);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Đồng ý'),
                                      onPressed: () {
                                        Navigator.pop(contextDialog);
                                        context.loaderOverlay.show();
                                        callAPIrequestBorrowBook(
                                            context, book.id);
                                      },
                                    ),
                                  ],
                                );
                              },
                            )
                          : Container();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: book.isAvailable == true
                              ? Colors.redAccent
                              : Colors.grey),
                      height: 50,
                      alignment: Alignment.center,
                      child: book.isAvailable == true
                          ? const Text(
                              'Mượn Sách',
                              style: TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          : const Text(
                              'Hết bản cứng',
                              style: TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
