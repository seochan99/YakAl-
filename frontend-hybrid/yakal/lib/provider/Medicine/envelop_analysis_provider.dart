import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yakal/models/Medication/dose_name_code_model.dart';

class EnvelopAnalysisProvider {
  Future<List<DoseNameCodeModel>> getTextFromImage(String imagePath) async {
    var dio = Dio();

    var formData = FormData.fromMap(
      {
        "image": await MultipartFile.fromFile(imagePath),
      },
      ListFormat.multiCompatible,
    );

    try {
      var response = await dio.post(
        dotenv.get("OCR_SERVER_HOST"),
        data: formData,
        options: Options(
          headers: {
            "content-Type": "multipart/form-data",
          },
        ),
      );

      return response.data;
    } on DioException catch (error) {
      return [];
    }
  }
}
