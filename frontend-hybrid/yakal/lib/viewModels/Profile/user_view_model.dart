import 'package:get/get.dart';

import '../../models/Profile/user.dart';

class UserViewModel extends GetxController {
  var user = User(nickName: '약 알').obs;

  void updateNickName(String newNickName) {
    user.update((val) {
      val?.nickName = newNickName;
    });
  }
}
