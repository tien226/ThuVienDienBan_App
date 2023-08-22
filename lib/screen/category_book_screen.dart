import 'package:app/repository/app_repository.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../auto_route/auto_route.gr.dart';
import '../model/book/book_response.dart';

@RoutePage()
class CategoryBookScreen extends StatelessWidget {
  final List<Book> bookList;
  const CategoryBookScreen({super.key, required this.bookList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: bookList.isEmpty ? Center(child: Column(
        children: [
          Image.asset("lib/assets/images/img_no_data.png", cacheHeight: 260),
          const Text("Chưa có dữ liệu!", style: TextStyle(fontSize: 24, color: Colors.grey),)
        ],
      ),) : CustomScrollView(
        primary: false,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            sliver: BookWidget(bookList: bookList),
          )
        ],
      ),
    );
  }
}

class BookWidget extends StatelessWidget {
  final appRepository = GetIt.I.get<AppRepository>();
  final List<Book> bookList;
  BookWidget({super.key, required this.bookList});

  // void callAPIGetBookDetail(
  //     BuildContext context, int bookId, int indexBooksLocal) async {
  //   try {
  //     var bookFromAPI = await appRepository.getBookDetail(bookId);
  //     context.router.navigate(BookDetailRoute(book: bookFromAPI));
  //   } catch (e) {
  //     print(e);
  //     context.router.navigate(BookDetailRoute(book: bookList[indexBooksLocal]));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2;
    final double itemWidth = size.width / 2;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: (itemWidth / itemHeight),
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: bookList.length,
        (context, index) {
          return GestureDetector(
            onTap: () {
              // callAPIGetBookDetail(context, bookList[index].id, index);
              context.router.navigate(BookDetailRoute(bookId: bookList[index].id));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width,
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                      image: NetworkImage(bookList[index].thumbnail ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookList[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      bookList[index].authors.map((e) => e.name).join(", "),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
