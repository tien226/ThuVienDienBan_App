import 'package:app/repository/app_repository.dart';
import 'package:app/utils/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../auto_route/auto_route.gr.dart';
import '../model/login/login_response.dart';
import '../model/register/register_response.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var appRepository = GetIt.I.get<AppRepository>();
  late RegisterResponse registerResponse;
  late LoginResponse loginresponse;

  final RegExp _phoneRegex = RegExp(Constants.REGEX_PHONE_NUMBER);
  final RegExp _emailRegex = RegExp(Constants.REGEX_EMAIL);
  final RegExp _passRegex = RegExp(Constants.REGEX_PASSWORD);

  var _obscureTextPass = true;
  var _obscureTextConfirmPass = true;

  final _userNameControlled = TextEditingController();
  final _phoneControlled = TextEditingController();
  final _emailControlled = TextEditingController();
  final _passWordControlled = TextEditingController();
  final _confirmPassWordControlled = TextEditingController();

  bool _isEmptyUserName = false;
  bool _validatePhone = false;
  bool _validateEmail = false;
  bool _validatePass = false;
  bool _validateConfirmPass = false;

  var _errorMessagePhone = null;
  var _errorMessageEmail = null;
  var _errorMessagePass = null;
  var _errorMessConfirmPass = null;

  void registerAccount() async {
    try {
      registerResponse = await appRepository.registerAccount(
          _passWordControlled.text,
          _userNameControlled.text,
          _phoneControlled.text,
          _emailControlled.text);

      await appRepository.login(
          _userNameControlled.text, _passWordControlled.text);

      context.loaderOverlay.hide();
      context.router.replaceAll([const MainBottomNavigationRoute()]);
    } catch (e) {
      context.loaderOverlay.hide();
      print(e);
      if (e is DioException && e.response != null && e.response!.data is Map) {
        Map<String, dynamic> errorData = e.response!.data;

        String errorMessage = '';
        errorData.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            errorMessage += '${value.first} ';
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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              IconButton(
                  onPressed: () {
                    context.router.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32,
                  )),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "Đăng Ký Tài Khoản",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),
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
                          labelText: "Tên*",
                          hintText: "Nhập tên",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.person),
                          errorText: _isEmptyUserName
                              ? "Vui lòng nhập tên đăng ký!"
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
                          if (_validatePhone) {
                            setState(() {
                              _validatePhone = false;
                            });
                          }
                        },
                        controller: _phoneControlled,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                            labelText: "Số điện thoại",
                            hintText: "Nhập số điện thoại",
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Icon(Icons.phone),
                            errorText:
                                _validatePhone ? _errorMessagePhone : null,
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                          onChanged: (value) {
                            if (_validateEmail) {
                              setState(() {
                                _validateEmail = false;
                              });
                            }
                          },
                          controller: _emailControlled,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                              labelText: "Email",
                              hintText: "Nhập email",
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(Icons.email),
                              errorText:
                                  _validateEmail ? _errorMessageEmail : null,
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)))),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                          onChanged: (value) {
                            if (_validatePass && value.isNotEmpty) {
                              setState(() {
                                _validatePass = false;
                              });
                            }
                          },
                          controller: _passWordControlled,
                          textInputAction: TextInputAction.next,
                          obscureText: _obscureTextPass,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                              labelText: "Mật khẩu*",
                              hintText:
                                  "Gồm 8 ký tự, chứa 1 ký tự in hoa, 1 số và 1 ký tự đặc biệt",
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
                                  _validatePass ? _errorMessagePass : null,
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)))),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                            onChanged: (value) {
                              if (_validateConfirmPass && value.isNotEmpty) {
                                setState(() {
                                  _validateConfirmPass = false;
                                });
                              }
                            },
                            controller: _confirmPassWordControlled,
                            textInputAction: TextInputAction.done,
                            obscureText: _obscureTextConfirmPass,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent)),
                                labelText: "Nhập lại mật khẩu*",
                                hintText: "Nhập lại mật khẩu",
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureTextConfirmPass =
                                          !_obscureTextConfirmPass;
                                    });
                                  },
                                  child: _obscureTextConfirmPass
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                                errorText: _validateConfirmPass
                                    ? _errorMessConfirmPass
                                    : null,
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red))))),
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

                              if (_phoneControlled.text.isEmpty) {
                                _validatePhone = true;
                                _errorMessagePhone =
                                    "Vui lòng nhập số điện thoại đăng ký!";
                              } else if (!_phoneRegex
                                  .hasMatch(_phoneControlled.text)) {
                                _validatePhone = true;
                                _errorMessagePhone =
                                    "Nhập sai định dạng số điện thoại!";
                              } else {
                                _validatePhone = false;
                              }

                              if (_emailControlled.text.isEmpty) {
                                _validateEmail = true;
                                _errorMessageEmail =
                                    "Vui lòng nhập email đăng ký!";
                              } else if (!_emailRegex
                                  .hasMatch(_emailControlled.text)) {
                                _validateEmail = true;
                                _errorMessageEmail =
                                    "Nhập sai định dạng email!";
                              } else {
                                _validateEmail = false;
                              }

                              if (_passWordControlled.text.isEmpty) {
                                _validatePass = true;
                                _errorMessagePass = "Vui lòng nhập mật khẩu!";
                              } else if (!_passRegex
                                  .hasMatch(_passWordControlled.text)) {
                                _validatePass = true;
                                _errorMessagePass =
                                    "Gồm 8 ký tự, chứa 1 ký tự in hoa, 1 số và 1 ký tự đặc biệt!";
                              } else {
                                _validatePass = false;
                              }

                              if (_confirmPassWordControlled.text.isEmpty) {
                                _validateConfirmPass = true;
                                _errorMessConfirmPass =
                                    "Vui lòng nhập lại mật khẩu xác thực!";
                              } else if (_confirmPassWordControlled.text !=
                                  _passWordControlled.text) {
                                _validateConfirmPass = true;
                                _errorMessConfirmPass =
                                    "Mật khẩu nhập lại không chính xác!";
                              } else {
                                _validateConfirmPass = false;
                              }
                            });

                            if (!_isEmptyUserName &&
                                !_validatePhone &&
                                !_validateEmail &&
                                !_validatePass &&
                                !_validateConfirmPass) {
                              print("call api register account");
                              context.loaderOverlay.show();
                              registerAccount();
                            }
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              'Đăng Ký',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userNameControlled.dispose();
    _phoneControlled.dispose();
    _emailControlled.dispose();
    _passWordControlled.dispose();
    _confirmPassWordControlled.dispose();
  }
}
