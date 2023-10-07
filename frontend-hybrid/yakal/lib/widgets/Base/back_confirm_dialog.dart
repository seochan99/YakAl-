import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utilities/style/color_styles.dart';

class BackConfirmDialog extends StatelessWidget {
  final String question;
  final String backTo;
  final void Function()? backAction;

  const BackConfirmDialog({
    super.key,
    required this.question,
    required this.backTo,
    this.backAction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorStyles.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        height: 176,
        width: MediaQuery.of(context).size.width - 40.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                question,
                style: const TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  height: 1.6,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: ColorStyles.gray2,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "아니요",
                          style: TextStyle(
                            color: ColorStyles.gray6,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: TextButton(
                        onPressed: () {
                          if (backAction != null) {
                            backAction!();
                          }

                          Get.back(); // Close Dialog

                          Get.until(
                              (Route route) => Get.currentRoute == backTo);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: ColorStyles.main,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "다시하기",
                          style: TextStyle(
                            color: ColorStyles.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
