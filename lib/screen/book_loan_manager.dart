import 'package:app/auto_route/auto_route.gr.dart';
import 'package:app/model/order_book_list/order_book_response.dart';
import 'package:app/repository/app_repository.dart';
import 'package:app/utils/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class BookLoanManagerScreen extends StatefulWidget {
  const BookLoanManagerScreen({Key? key}) : super(key: key);

  @override
  State<BookLoanManagerScreen> createState() => _BookLoanManagerScreenState();
}

class _BookLoanManagerScreenState extends State<BookLoanManagerScreen>
    with AutoRouteAwareStateMixin<BookLoanManagerScreen> {
  List<OrderBook>? orderBookList;
  var appRepository = GetIt.I.get<AppRepository>();

  Future<void> callAPIGetOrderBookList() async {
    try {
      var newOrderBookList = await appRepository.getOrderBookList();

      setState(() {
        orderBookList = newOrderBookList;
      });
    } catch (e) {
      // Handle the API call error
      print('API call failed: $e');
    }
  }

  @override
  void didInitTabRoute(TabPageRoute? previousRoute) {
    print(previousRoute?.path);
    callAPIGetOrderBookList();
  }

// only override if this is a tab page
  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {
    print(previousRoute.path);
    callAPIGetOrderBookList();
  }

// only override if this is a stack page
  @override
  void didPopNext() {
    print("didPopNext");
  }

// only override if this is a stack page
  @override
  void didPushNext() {
    print("didPushNext");
  }

  @override
  Widget build(BuildContext context) {
    if (orderBookList != null) {
      final orderBookListRequested = orderBookList!
          .where((element) => element.status == Constants.REQUESTED)
          .toList();

      final orderBookListApproved = orderBookList!
          .where((element) => element.status == Constants.APPROVED)
          .toList();

      final orderBookListBorrowed = orderBookList!
          .where((element) => element.status == Constants.BORROWED)
          .toList();

      final orderBookListReturned = orderBookList!
          .where((element) => element.status == Constants.RETURNED)
          .toList();

      final orderBookListCanceled = orderBookList!
          .where((element) => element.status == Constants.CANCELED)
          .toList();

      final orderBookListOverDue = orderBookList!
          .where((element) => element.status == Constants.OVER_DUE)
          .toList();

      return Scaffold(
        appBar: AppBar(
          title: const Text("Thông Tin Mượn Trả Sách"),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: callAPIGetOrderBookList,
          child: orderBookList!.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Image.asset("lib/assets/images/img_no_data.png",
                          cacheHeight: 260),
                      const Text(
                        "Chưa có dữ liệu!",
                        style: TextStyle(fontSize: 24, color: Colors.grey),
                      )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // REQUESTED
                      Visibility(
                        visible: orderBookListRequested.isNotEmpty,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Chờ Xác Nhận",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: orderBookListRequested.isNotEmpty,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderBookListRequested.length,
                          itemBuilder: (context, index) {
                            final orderBookRequested =
                                orderBookListRequested[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: ListTile(
                                title: Text(orderBookRequested.bookName),
                                subtitle: Text(orderBookRequested.author),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.amber, width: 1.5),
                                  ),
                                  child: Text(
                                    orderBookRequested.status,
                                    style: const TextStyle(color: Colors.amber),
                                  ),
                                ),
                                onTap: () {
                                  // navigate book loan detail screen
                                  context.router.navigate(BookLoanDetailRoute(
                                      orderBook: orderBookRequested,
                                      onBack: callAPIGetOrderBookList));
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      // APPROVE
                      Visibility(
                        visible: orderBookListApproved.isNotEmpty,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Đã Xác Nhận",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: orderBookListApproved.isNotEmpty,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderBookListApproved.length,
                          itemBuilder: (context, index) {
                            final orderBookAppRove =
                                orderBookListApproved[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: ListTile(
                                title: Text(orderBookAppRove.bookName),
                                subtitle: Text(orderBookAppRove.author),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.blue, width: 1.5),
                                  ),
                                  child: Text(
                                    orderBookAppRove.status,
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                                onTap: () {
                                  // Handle tap on list item

                                  context.router.navigate(BookLoanDetailRoute(
                                      orderBook: orderBookAppRove));
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      // BORROWED
                      Visibility(
                        visible: orderBookListBorrowed.isNotEmpty,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Đang Mượn",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: orderBookListBorrowed.isNotEmpty,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderBookListBorrowed.length,
                          itemBuilder: (context, index) {
                            final orderBookBorrowed =
                                orderBookListBorrowed[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: ListTile(
                                title: Text(orderBookBorrowed.bookName),
                                subtitle: Text(orderBookBorrowed.author),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.greenAccent, width: 1.5),
                                  ),
                                  child: Text(
                                    orderBookBorrowed.status,
                                    style: const TextStyle(
                                        color: Colors.greenAccent),
                                  ),
                                ),
                                onTap: () {
                                  // Handle tap on list item
                                  context.router.navigate(BookLoanDetailRoute(
                                      orderBook: orderBookBorrowed));
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      // RETURNED
                      Visibility(
                        visible: orderBookListReturned.isNotEmpty,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Đã Trả",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: orderBookListReturned.isNotEmpty,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderBookListReturned.length,
                          itemBuilder: (context, index) {
                            final orderBookReturned =
                                orderBookListReturned[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: ListTile(
                                title: Text(orderBookReturned.bookName),
                                subtitle: Text(orderBookReturned.author),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.amber, width: 1.5),
                                  ),
                                  child: Text(
                                    orderBookReturned.status,
                                    style: const TextStyle(color: Colors.amber),
                                  ),
                                ),
                                onTap: () {
                                  // Handle tap on list item
                                  context.router.navigate(BookLoanDetailRoute(
                                      orderBook: orderBookReturned));
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      // CANCELED
                      Visibility(
                        visible: orderBookListCanceled.isNotEmpty,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Hủy Yêu Cầu",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: orderBookListCanceled.isNotEmpty,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderBookListCanceled.length,
                          itemBuilder: (context, index) {
                            final orderBookCanceled =
                                orderBookListCanceled[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: ListTile(
                                title: Text(orderBookCanceled.bookName),
                                subtitle: Text(orderBookCanceled.author),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.red, width: 1.5),
                                  ),
                                  child: Text(
                                    orderBookCanceled.status,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                                onTap: () {
                                  // Handle tap on list item
                                  context.router.navigate(BookLoanDetailRoute(
                                      orderBook: orderBookCanceled));
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      // OVER_DUE
                      Visibility(
                        visible: orderBookListOverDue.isNotEmpty,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Quá Hạn",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: orderBookListOverDue.isNotEmpty,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderBookListOverDue.length,
                          itemBuilder: (context, index) {
                            final orderBookOverdue =
                                orderBookListOverDue[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: ListTile(
                                title: Text(orderBookOverdue.bookName),
                                subtitle: Text(orderBookOverdue.author),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.amber, width: 1.5),
                                  ),
                                  child: Text(
                                    orderBookOverdue.status,
                                    style: const TextStyle(color: Colors.amber),
                                  ),
                                ),
                                onTap: () {
                                  // Handle tap on list item
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
    } else {
      return const Center(
        child: Text("Loading......."),
      );
    }
  }
}
