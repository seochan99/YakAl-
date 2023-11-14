import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/dose_list_view_model.dart';

class DoseListWidget extends StatelessWidget {
  final AddDoseViewModel addDoseViewModel = Get.find<AddDoseViewModel>();

  DoseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /* 먼저 그룹 단위로 목록을 출력, 그룹은 같은 복용 시간의 약들의 그룹임 (e.g. 아침, 저녁 복용 약물의 모임) */
    return ListView.separated(
      itemCount: addDoseViewModel.getGroupCount(),
      itemBuilder: (context, groupIndex) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* 복용 시간에 따른 그룹 제목 스트링 출력 (e.g. "아침, 저녁") */
            Text(
              addDoseViewModel.getGroupTimeString(groupIndex),
              style: const TextStyle(
                color: ColorStyles.gray5,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            /* 해당 그룹 안에 있는 약 목록을 출력 */
            ListView.separated(
              /* ListView 안에 있는 ListView 가 Non-Scrollable 하도록 만듬 */
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              /* --------------------------------------------------- */
              itemCount: addDoseViewModel.getItemCountOnGroup(groupIndex),
              itemBuilder: (context, itemIndex) {
                var oneMedicine =
                    addDoseViewModel.getOneMedicine(groupIndex, itemIndex);
                return Column(
                  children: [
                    /* 약 하나의 정보를 보여 주는 Row */
                    Row(
                      children: [
                        /* 약 사진 (64 by 32) */
                        Container(
                            width: 64,
                            height: 32,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: ColorStyles.gray2,
                            ),
                            child: oneMedicine.base64Image.isNotEmpty
                                ? Image.memory(
                                    base64Decode(
                                      oneMedicine.base64Image,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset(
                                    "assets/icons/img-mainpill-default.svg",
                                    width: 64,
                                    height: 32,
                                  )),
                        const SizedBox(
                          width: 10,
                        ),
                        /* 약 이름 */
                        Text(
                          oneMedicine.name,
                          style: const TextStyle(
                            color: ColorStyles.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              /* 약 정보 Row 사이의 공백 */
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
            ),
          ],
        );
      },
      /* 그룹 정보 Row 사이의 공백 */
      separatorBuilder: (context, index) => const SizedBox(
        height: 48,
      ),
    );
  }
}
