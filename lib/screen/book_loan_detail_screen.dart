import 'package:app/repository/app_repository.dart';
import 'package:app/utils/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../auto_route/auto_route.gr.dart';
import '../model/order_book_list/order_book_response.dart';

@RoutePage()
class BookLoanDetailScreen extends StatefulWidget {
  final OrderBook orderBook;
  final VoidCallback? onBack;
  const BookLoanDetailScreen({super.key, required this.orderBook, this.onBack});

  @override
  State<BookLoanDetailScreen> createState() => _BookLoanDetailScreenState();
}

class _BookLoanDetailScreenState extends State<BookLoanDetailScreen> {
  var appRepository = GetIt.I.get<AppRepository>();

  void callAPICancelBorrowBook(int orderId) async {
    try {
      await appRepository.cancelBorrowBook(orderId);
      context.loaderOverlay.hide();

      context.router.navigate(const BookLoanManagerRoute());
      widget.onBack?.call();
    } catch (error) {
      context.loaderOverlay.hide();

      showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
              message: "Có lỗi xảy ra. Vui lòng thử lại sau!"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Thông Tin Chi Tiết"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                // book name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.library_books,
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Tên sách: ",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        widget.orderBook.bookName,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(),
                ),

                // author
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.person_2,
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Tác giả: ",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        widget.orderBook.author,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),

                // Giá tiền
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.payments,
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Giá tiền sách: ",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        NumberFormat.currency(locale: "vi_VN")
                            .format(widget.orderBook.price),
                        style: const TextStyle(
                            fontSize: 16, color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),

                // Ngày đăng ký mượn
                Visibility(
                  visible: widget.orderBook.status == Constants.REQUESTED,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                ),
                Visibility(
                  visible: widget.orderBook.status == Constants.REQUESTED,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Ngày đăng ký mượn: ",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          widget.orderBook.requestAt,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ),

                // Ngày xác nhận mượn
                Visibility(
                  visible: widget.orderBook.status == Constants.APPROVED,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                ),
                Visibility(
                  visible: widget.orderBook.status == Constants.APPROVED,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Ngày xác nhận yêu cầu: ",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          widget.orderBook.approveAt,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ),

                // Thời gian bắt đầu mượn
                Visibility(
                  visible: widget.orderBook.status == Constants.BORROWED,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                ),
                Visibility(
                  visible: widget.orderBook.status == Constants.BORROWED,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Thời gian bắt đầu mượn: ",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          widget.orderBook.borrowAt,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ),

                // Thời gian kết thúc mượn
                Visibility(
                  visible: widget.orderBook.status == Constants.BORROWED,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                ),
                Visibility(
                  visible: widget.orderBook.status == Constants.BORROWED,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Thời gian hẹn trả: ",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          widget.orderBook.dueDate,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ),

                // Ngày hủy yêu cầu
                Visibility(
                  visible: widget.orderBook.status == Constants.CANCELED,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                ),
                Visibility(
                  visible: widget.orderBook.status == Constants.CANCELED,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Ngày Hủy Yêu Cầu: ",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          widget.orderBook.cancelAt,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(),
                ),

                Visibility(
                  visible: widget.orderBook.status == Constants.REQUESTED,
                  child: Material(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext contextDialog) {
                            return AlertDialog(
                              title: const Text('Thông báo'),
                              content: const Text(
                                  'Bạn xác nhận muốn hủy yêu cầu mượn sách này?',
                                  style: TextStyle(height: 1.5)),
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
                                    callAPICancelBorrowBook(
                                        widget.orderBook.id);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          'Hủy Yêu Cầu',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),

                // BarCode
                const SizedBox(
                  height: 24,
                ),
                Visibility(
                  visible: widget.orderBook.status == Constants.APPROVED,
                  child: SizedBox(
                    height: 220,
                    child: SfBarcodeGenerator(
                      value: widget.orderBook.url,
                      symbology: QRCode(),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.orderBook.status == Constants.APPROVED,
                  child: const SizedBox(
                    height: 16,
                  ),
                ),
                Visibility(
                  visible: widget.orderBook.status == Constants.APPROVED,
                  child: const Text(
                    "Mã QRCode mượn sách của bạn",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Visibility(
                  visible: widget.orderBook.status == Constants.APPROVED,
                  child: const SizedBox(
                    height: 8,
                  ),
                ),
                Visibility(
                  visible: widget.orderBook.status == Constants.APPROVED,
                  child: const Text(
                    "Vui lòng đưa mã QRCode này cho nhân viên cửa hàng khi làm thủ tục mược sách.",
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey, height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
