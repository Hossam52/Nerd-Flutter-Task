import 'package:nerd_hossam_task/shared/network/services/local/cache_helper.dart';

class RememberMeHelper {
  bool isRemembered = false;
  String email = '';
  String password = '';

  void changeIsRemembered(bool? isRemembered) {
    this.isRemembered = isRemembered ?? false;
  }

  Future<void> loadData() async {
    final isRemembered = await CacheHelper.getIsRemembered;
    final emailRemembered = await CacheHelper.getEmailRemembered;
    final passwordRemembered = await CacheHelper.getPasswordRemembered;
    if (isRemembered) {
      email = emailRemembered;
      password = passwordRemembered;
    } else {
      email = password = '';
    }
  }

  Future<void> saveData(String email, String password) async {
    if (isRemembered) {
      await CacheHelper.setIsRemembered(isRemembered, email, password);
    }
  }

  @override
  String toString() =>
      'RememberMeHelper(isRemembered: $isRemembered, email: $email, password: $password)';
}
