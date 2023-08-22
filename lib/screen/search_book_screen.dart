import 'package:app/auto_route/auto_route.gr.dart';
import 'package:app/repository/app_repository.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../model/book/book_response.dart';

@RoutePage()
class SearchBookScreen extends StatefulWidget {
  final List<Book> bookList;
  const SearchBookScreen({super.key, required this.bookList});

  @override
  State<SearchBookScreen> createState() => _SearchBookScreenState();
}

class _SearchBookScreenState extends State<SearchBookScreen> {
  var appRepository = GetIt.I.get<AppRepository>();
  final TextEditingController _searchController = TextEditingController();
  List<Book> _searchResult = [];

  @override
  void initState() {
    super.initState();
    _searchResult = widget.bookList;
  }

  void _performSearch(String query) {
    query = query.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        _searchResult = widget.bookList;
      });
    } else {
      appRepository.callAPISearchBook(query).then((searchResult) {
        setState(() {
          _searchResult = searchResult;
        });
      }).catchError((error) {
        final List<Book> localSearchResult = widget.bookList.where((book) {
          final title = book.title.toLowerCase();
          return title.contains(query);
        }).toList();

        setState(() {
          _searchResult = localSearchResult;
        });

        print("Error: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: (() {
            context.router.back();
          }),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: Colors.blueAccent,
        title: TextField(
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          controller: _searchController,
          onChanged: _performSearch,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Nhập tên sách tìm kiếm...",
            hintStyle: const TextStyle(color: Colors.white54),
            suffixIcon: Visibility(
              visible: _searchController.text.isNotEmpty,
              child: IconButton(
                onPressed: () {
                  _searchController.clear();
                  _performSearch("");
                },
                icon: const Icon(Icons.clear, color: Colors.white),
              ),
            ),
          ),
          textInputAction: TextInputAction.search,
        ),
        // actions: [],
        // elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView.builder(
          itemCount: _searchResult.length,
          itemBuilder: (context, index) {
            final book = _searchResult[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: ListTile(
                title: Text(book.title),
                subtitle:
                    Text(book.authors.map((author) => author.name).join(", ")),
                trailing: const Icon(Icons.navigate_next),
                onTap: () {
                  // click list item search
                  // _navigateBookDetailScreen(context, book.id);
                  context.router.navigate(BookDetailRoute(bookId: book.id));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
