import 'package:app/repository/app_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../repository/app_repository_impl.dart';


class MainModul {
  static void init() {
    final dio = Dio();
  
    dio.options.baseUrl = "https://dienban.huutuananh.com/";
    dio.options.connectTimeout = const Duration(milliseconds: 30000) ;
    dio.options.receiveTimeout = const Duration(milliseconds: 30000) ;
    dio.options.sendTimeout = const Duration(milliseconds: 1800000);

    dio.interceptors.add(LogInterceptor());

    final appRepository = AppRepositoryImpl(dio: dio);

    GetIt.I.registerSingleton<AppRepository>(appRepository);
  }
}