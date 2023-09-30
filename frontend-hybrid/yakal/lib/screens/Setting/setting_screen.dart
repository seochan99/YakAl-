import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/widgets/Setting/setting_mode_widget.dart';
import 'package:yakal/widgets/Setting/setting_time_selection_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('앱 설정'),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /* -------------- 모드 설정  -------------- */
              const Text("모드 설정",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 20),
              const SettingModeWidget(),
              const SizedBox(
                height: 64,
              ),
              /* -------------- 모드 설정  -------------- */
              const Text("시간 설정",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 16),
              const Text(
                "나의 루틴에 맞추어 시간을 조정할 수 있습니다.",
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff626272),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),
              const SettingTimeSelectionWidget(),
              /* -------------- 계정 설정  -------------- */
              const SizedBox(
                height: 64,
              ),
              const Text("계정 설정",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('로그아웃',
                    style: TextStyle(fontSize: 16, color: Color(0xff151515))),
                onTap: () {
                  showCustomDialog(context);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('회원탈퇴',
                    style: TextStyle(fontSize: 16, color: Color(0xff151515))),
                onTap: () {
                  Get.toNamed('/signout');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 로그아웃 다이얼로그
  void showCustomDialog(BuildContext context) {
    Get.defaultDialog(
      // padding

      title: '로그아웃',
      titleStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      // 배경
      // subtitle none
      content: const Text(
        '로그아웃 하시겠습니까?',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xff464655),
        ),
      ),

      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xff2666F6),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Text(
              '로그아웃',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffffffff),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Text(
              '아니요',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff464655),
              ),
            ),
          ),
        ),
      ),
      confirmTextColor: Colors.black,
      onCancel: () {},
    );
  }
}