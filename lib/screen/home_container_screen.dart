import 'package:app/screen/home.dart';
import 'package:app/screen/category_book_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../auto_route/auto_route.gr.dart';
import '../model/book/book_response.dart';
import '../model/category/category_response.dart';
import '../model/home/home_response.dart';
import '../repository/app_repository.dart';

@RoutePage()
class HomeContainerScreen extends StatefulWidget {
  const HomeContainerScreen({super.key});

  @override
  State<HomeContainerScreen> createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen>
    with SingleTickerProviderStateMixin {
  var appRepositoy = GetIt.I.get<AppRepository>();
  List<Category>? categories;
  List<Book>? books;
  List<HomeData>? homeDatas;
  late TabController _tabController;

  void getDataFromAPI() async {
    var newCategory = await appRepositoy.getCategoryList();
    var newBook = await appRepositoy.getBookList();
    var newDataHome = await appRepositoy.getDataHome();

    setState(() {
      categories = newCategory;
      books = newBook;
      homeDatas = newDataHome;

      _tabController =
          TabController(length: newCategory.length + 1, vsync: this);
    });
  }

  @override
  void initState() {
    super.initState();
    getDataFromAPI();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (categories != null && books != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 110,
          title: Column(
            children: [
              Row(
                children: [
                  Image.asset("lib/assets/images/logo_app.png",
                      width: 64, height: 64),
                  const Text(
                    "Thư Viện Điện Bàn",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                ],
              ),
              SearchContainer(
                book: books,
              ),
            ],
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            controller: _tabController,
            isScrollable: true,
            tabs: [
              const Tab(text: "Trang chủ"),
              for (var category in categories!) Tab(text: category.title),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            HomeScreen(
              categorys: categories ?? [],
              books: books ?? [],
              homeDatas: homeDatas ?? [],
            ),
            for (var category in categories!)
              CategoryBookScreen(
                bookList: books!.where((element) => element.id == category.id).toList(),
              ),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text("Loading......."),
      );
    }
  }
}

class SearchContainer extends StatelessWidget {
  final List<Book>? book;

  const SearchContainer({Key? key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
      child: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            // navigate search screen
            if (book != null) {
              context.router.navigate(SearchBookRoute(bookList: book ?? []));
            }
          },
          child: Container(
            height: 44,
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.black),
                borderRadius: BorderRadius.circular(24)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Tìm kiếm sách",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
