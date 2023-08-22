import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../auto_route/auto_route.gr.dart';
import '../repository/app_repository.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var appRepositoy = GetIt.I.get<AppRepository>();
  var _obscureTextPass = true;
  final _userNameControlled = TextEditingController();
  final _passWordControlled = TextEditingController();
  bool _isEmptyUserName = false;
  bool _isEmptyPass = false;

  void login() async {
    try {
      await appRepositoy.login(
          _userNameControlled.text, _passWordControlled.text);
      context.loaderOverlay.hide();
      context.router.replaceAll([const MainBottomNavigationRoute()]);
    } catch (ex) {
      context.loaderOverlay.hide();
      print(ex);
      if (ex is DioException && ex.response != null && ex.response!.data is Map) {
        Map<String, dynamic> errorData = ex.response!.data;

        String errorMessage = '';
        errorData.forEach((key, value) {
          if (value.isNotEmpty) {
            errorMessage += '${value.toString()} ';
          }
        });

        if (errorMessage.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: errorMessage),
          );
          return;
        } else {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(message: "Có lỗi xảy ra!"),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text(
                  "Đăng Nhập",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Đăng nhập tài khoản của bạn!",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 64),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    onChanged: (value) {
                      if (_isEmptyUserName && value.isNotEmpty) {
                        setState(() {
                          _isEmptyUserName = false;
                        });
                      }
                    },
                    controller: _userNameControlled,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)),
                      labelText: "Tên tài khoản*",
                      hintText: "Nhập tên tài khoản",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.person),
                      errorText: _isEmptyUserName
                          ? "Vui lòng nhập tên tài khoản!"
                          : null,
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    onChanged: (value) {
                      if (_isEmptyPass && value.isNotEmpty) {
                        setState(() {
                          _isEmptyPass = false;
                        });
                      }
                    },
                    textInputAction: TextInputAction.done,
                    controller: _passWordControlled,
                    obscureText: _obscureTextPass,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)),
                      labelText: "Mật khẩu*",
                      hintText: "Nhập mật khẩu",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextPass = !_obscureTextPass;
                          });
                        },
                        child: _obscureTextPass
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      errorText:
                          _isEmptyPass ? "Vui lòng nhập mật khẩu!" : null,
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Material(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _userNameControlled.text.isEmpty
                              ? _isEmptyUserName = true
                              : _isEmptyUserName = false;
                          _passWordControlled.text.isEmpty
                              ? _isEmptyPass = true
                              : _isEmptyPass = false;
                        });

                        if (!_isEmptyUserName && !_isEmptyPass) {
                          print("call api login");
                          context.loaderOverlay.show();
                          login();
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          'Đăng Nhập',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Chưa có tài khoản?",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      InkWell(
                        onTap: () {
                          context.router.navigate(const RegisterRoute());
                        },
                        child: const Text(" Đăng ký",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userNameControlled.dispose();
    _passWordControlled.dispose();
  }
}
