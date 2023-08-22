import 'package:app/model/book/book_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import '../auto_route/auto_route.gr.dart';
import '../model/category/category_response.dart';
import '../model/home/home_response.dart';
import '../repository/app_repository.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  final List<Category> categorys;
  final List<Book> books;
  final List<HomeData> homeDatas;

  const HomeScreen(
      {super.key,
      required this.categorys,
      required this.books,
      required this.homeDatas});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var appRepositoy = GetIt.I.get<AppRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BookWidget(
          categoryList: widget.categorys,
          bookList: widget.books,
          homeDataList: widget.homeDatas,
          appRepository: appRepositoy),
    );
  }
}

class CategoryWidget extends SliverPersistentHeaderDelegate {
  int selectedItem = 0;
  final List<Category> categoryList;

  CategoryWidget({required this.categoryList});

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            selectedItem = index;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryList[index].title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          selectedItem == index ? Colors.black : Colors.grey),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 2,
                  width: 32,
                  color:
                      selectedItem == index ? Colors.black : Colors.transparent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookWidget extends StatelessWidget {
  final List<Category> categoryList;
  final List<Book> bookList;
  final List<HomeData> homeDataList;
  final AppRepository appRepository;

  const BookWidget(
      {super.key,
      required this.bookList,
      required this.categoryList,
      required this.homeDataList,
      required this.appRepository});

  HomeData getBooksTopRead() {
    return homeDataList[1];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            CarouselSliderWidget(
                homeDataSlide: homeDataList, appRepository: appRepository),
            const SizedBox(height: 32),
            CategoryTopList(
                homeDataCategories: homeDataList, appRepository: appRepository),
            const SizedBox(height: 32),
            CategoryLatestList(
                homeDataCategories: homeDataList, appRepository: appRepository),
          ],
        ),
      ),
    );
  }
}

class CarouselSliderWidget extends StatelessWidget {
  final List<HomeData> homeDataSlide;
  final AppRepository appRepository;
  const CarouselSliderWidget(
      {super.key, required this.homeDataSlide, required this.appRepository});

  List<BookHome> getHomeDataSlides() {
    return homeDataSlide[0].bookListHome;
  }

  // void navigateBookDetailScreen(BuildContext context, int bookId) async {
  //   try {
  //     var book = await appRepository.getBookDetail(bookId);
  //     context.router.navigate(BookDetailRoute(book: book));
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final List<BookHome> homeDataSlides = getHomeDataSlides();

    return CarouselSlider(
      items: homeDataSlides.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                // navigateBookDetailScreen(context, item.id);
                context.router.navigate(BookDetailRoute(bookId: item.id));
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(item.thumbnail),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      gradient: const LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        item.categoryName,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    right: 16,
                    bottom: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          item.author,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 220, 217, 217),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),

      //Slider Container properties
      options: CarouselOptions(
        height: 130,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.decelerate,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.7,
      ),
    );
  }
}

class CategoryTopList extends StatelessWidget {
  final List<HomeData> homeDataCategories;
  final AppRepository appRepository;
  const CategoryTopList(
      {super.key,
      required this.homeDataCategories,
      required this.appRepository});

  HomeData getHomeDataCategoriesTop() {
    return homeDataCategories[1];
  }

  @override
  Widget build(BuildContext context) {
    final HomeData homeDataTop = getHomeDataCategoriesTop();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Text(
            homeDataTop.title,
            style: const TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
            child: Row(
              children: homeDataTop.bookListHome.map((e) {
                return GestureDetector(
                  onTap: () {
                    // navigateBookDetailScreen(context, e.id);
                    context.router.navigate(BookDetailRoute(bookId: e.id));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 120,
                        height: 180,
                        margin: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          image: DecorationImage(
                            image: NetworkImage(e.thumbnail),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              e.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              e.author,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}

class CategoryLatestList extends StatelessWidget {
  final List<HomeData> homeDataCategories;
  final AppRepository appRepository;
  const CategoryLatestList(
      {super.key,
      required this.homeDataCategories,
      required this.appRepository});

  HomeData getHomeDataCategoriesLatest() {
    return homeDataCategories[2];
  }

  @override
  Widget build(BuildContext context) {
    final HomeData homeDataLatest = getHomeDataCategoriesLatest();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Text(
            homeDataLatest.title,
            style: const TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
            child: Row(
              children: [
                Row(
                  children: homeDataLatest.bookListHome.map((e) {
                    return GestureDetector(
                      onTap: () {
                        // navigateBookDetailScreen(context, e.id);
                        context.router.navigate(BookDetailRoute(bookId: e.id));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 120,
                            height: 180,
                            margin: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              image: DecorationImage(
                                image: NetworkImage(e.thumbnail),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  e.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  e.author,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
