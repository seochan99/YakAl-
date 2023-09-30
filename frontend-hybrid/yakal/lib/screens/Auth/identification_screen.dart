import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';

import '../../utilities/style/color_styles.dart';

class IdentificationScreen extends StatelessWidget {
  const IdentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorStyles.white,
      child: SafeArea(
        child: Scaffold(
          body: IamportCertification(
            initialChild: const Center(
              child: CircularProgressIndicator(),
            ),
            userCode: '${dotenv.env['IDENTIFICATION_MID']}',
            data: CertificationData(
              pg: "inicis_unified",
              merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
              mRedirectUrl: "https://yakal/mobile/identify/cancel",
            ),
            callback: (Map<String, String> result) {
              if (result['success'] == 'true') {
                Get.toNamed(
                  '/login/identify/result',
                  arguments: result,
                );
              } else {
                Get.back();
              }
            },
          ),
        ),
      ),
    );
  }
}
