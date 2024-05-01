import 'package:nerd_hossam_task/shared/service_locator.dart';

import '../../../constants/constants.dart';
import '../endpoints.dart';
import 'remote/app_dio_helper.dart';

class AuthServices {
  final appDioHelper = locator.get<AppDioHelper>();
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await appDioHelper.postData(
        url: EndPoints.login, data: {'email': email, 'password': password});
    return response.data;
  }

  Future<Map<String, dynamic>> register(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String passwordConfirm}) async {
    final response = await appDioHelper
        .postData(url: EndPoints.register, token: Constants.token, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': passwordConfirm,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> profile() async {
    final response = await appDioHelper.getData(
        url: EndPoints.profile, token: Constants.token);
    return response.data;
  }

  Future<Map<String, dynamic>> logout() async {
    final response = await appDioHelper.getData(
      url: EndPoints.logout,
      token: Constants.token,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> changePhone(
      String phone, String password) async {
    final response = await appDioHelper.postData(
        url: EndPoints.changePhone,
        token: Constants.token,
        data: {'phone': phone, 'password': password});
    return response.data;
  }

  Future<Map<String, dynamic>> changePassword(
      {required String currentPassword,
      required String newPassword,
      required String newPasswordConfirmation}) async {
    final response = await appDioHelper
        .postData(url: EndPoints.changePassword, token: Constants.token, data: {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> updateProfile(
      {required String currentPassword,
      String? name,
      String? email,
      String? phone}) async {
    final response = await appDioHelper.postData(
        url: EndPoints.updateProfile,
        token: Constants.token,
        data: {
          'password': currentPassword,
          'phone': phone,
          'name': name,
          'email': email
        });
    return response.data;
  }
}
