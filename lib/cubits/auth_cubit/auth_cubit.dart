import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nerd_hossam_task/constants/constants.dart';
import 'package:nerd_hossam_task/helpers/remember_helper.dart';
import 'package:nerd_hossam_task/shared/network/local/cache_helper.dart';

import 'auth_states.dart';

//Bloc builder and bloc consumer methods
typedef AuthBlocBuilder = BlocBuilder<AuthCubit, AuthStates>;
typedef AuthBlocConsumer = BlocConsumer<AuthCubit, AuthStates>;

//
class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(IntitalAuthState());
  static AuthCubit instance(BuildContext context) =>
      BlocProvider.of<AuthCubit>(context);

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoadingState());
      await Future.delayed(const Duration(seconds: 2));
      // final response = await AuthServices.login(email, password);
      // final user = userModel.AuthUserModel.fromMap(response);
      // Constants.token = user.access_token;

      // await CacheHelper.setToken(user.access_token);
      // await _remember.saveData(email, password);

      // log(user.user.toString());
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(error: e.toString()));
      rethrow;
    }
  }

  final RememberMeHelper _remember = RememberMeHelper();

  bool get isRememberd => _remember.isRemembered;
  String get cachedEmail => _remember.email;
  String get cachedPassword => _remember.password;

  void onChangeCheckMe(bool? isRemembered) {
    _remember.changeIsRemembered(isRemembered);
    emit(ChangeIsRememberedState());
  }

  Future<void> loadCahcedRemember() async {
    await _remember.loadData();
    log(_remember.toString());
    emit(LoadCachedRememberState());
  }

  Future<void> register(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String passwordConfirm}) async {
    try {
      emit(RegisterLoadingState());
      await Future.delayed(const Duration(seconds: 2));

      // final response = await AuthServices.register(
      //     email: email,
      //     name: name,
      //     phone: phone,
      //     password: password,
      //     passwordConfirm: passwordConfirm);
      // final registerModel = RegisterModel.fromMap(response);
      // Constants.token = registerModel.user.access_token;
      // log(response.toString());
      emit(RegisterSuccessState());
    } catch (e) {
      emit(RegisterErrorState(error: e.toString()));
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      emit(LogoutLoadingState());
      await CacheHelper.removeToken();
      Constants.token = null;

      emit(LogoutSuccessState());
    } catch (e) {
      emit(LogoutErrorState(error: e.toString()));
    }
  }
}
