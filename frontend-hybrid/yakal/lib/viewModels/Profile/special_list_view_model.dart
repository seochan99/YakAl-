import 'package:get/get.dart';
import 'package:yakal/models/Profile/special_note_model.dart';
import 'package:yakal/utilities/api/api.dart';

import '../../models/Profile/user.dart';

class SpecialListViewModel extends GetxController {
  // 유저 정보 가져오기
  var user = User().obs;

/*---------------------- 특이사항 가져오기 ---------------------- */
  Future<void> getSpecialNoteItem(String title) async {
    /*---------------------- healthfood, diagnosis ---------------------- */
    if (title == 'healthfood' || title == 'diagnosis') {
      try {
        var dio = await authDioWithContext();
        var response = await dio.get("/$title");

        if (response.statusCode == 200 && response.data['success']) {
          user.update((val) {
            switch (title) {
              case 'healthfood':
                val?.specialNote?.healthfood = response.data['data'];
                break;
              case 'diagnosis':
                val?.specialNote?.diagnosis = response.data['data'];
                break;
              // underlyingConditions : 기저질환
              // allergies : 알러지
              // falls : 낙상 Date
              default:
                break;
            }
          });
        }
      } catch (e) {
        throw Exception("Exception while adding health medication: $e");
      }
      return;
    }

    /*---------------------- underlyingConditions, allergies, falls ---------------------- */
    user.update((val) {
      // 특이사항이 없으면 생성
      val?.specialNote ??= SpecialNote(
        underlyingConditions: [],
        allergies: [],
        falls: [],
        diagnosis: [],
        healthfood: [],
      );
      if (val?.specialNote != null) {
        switch (title) {
          case 'underlyingConditions':
            val?.specialNote!.underlyingConditions;
            break;
          case 'allergies':
            val?.specialNote!.allergies;
            break;
          case 'falls':
            val?.specialNote!.falls;
            break;
          default:
            break;
        }
      }
    });
  }

/*---------------------- 특이사항 삭제 ---------------------- */
  Future<void> removeSpecialNoteItem(String title, int index) async {
    /*---------------------- healthfood, diagnosis ---------------------- */
    if (title == 'healthfood' || title == 'diagnosis') {
      try {
        var dio = await authDioWithContext();
        var response = await dio.delete("/$title/$index");
        if (response.statusCode == 200 && response.data['success']) {
          loadSpeicalNote(title);
        }
      } catch (e) {
        throw Exception("Exception while adding health medication: $e");
      }
      return;
    }
/*---------------------- underlyingConditions, allergies, falls ---------------------- */
    user.update((val) {
      if (val?.specialNote != null) {
        switch (title) {
          case 'underlyingConditions':
            val?.specialNote!.underlyingConditions.removeAt(index);
            break;
          case 'allergies':
            val?.specialNote!.allergies.removeAt(index);
            break;
          case 'falls':
            val?.specialNote!.falls.removeAt(index);
            break;
          default:
            break;
        }
      }
    });
  }

  /*---------------------- 패치시키고 로드하기 ---------------------- */
  Future<void> loadSpeicalNote(title) async {
    try {
      List<ItemWithNameAndId> fetchedItems = await fetchSpeicalNote(title);
      user.update((val) {
        val?.specialNote ??= SpecialNote(
          underlyingConditions: [],
          allergies: [],
          falls: [],
          diagnosis: [],
          healthfood: [],
        );
        switch (title) {
          case 'diagnosis':
            val?.specialNote?.diagnosis.assignAll(fetchedItems);
            break;
          case 'healthfood':
            val?.specialNote?.healthfood.assignAll(fetchedItems);
            break;
          default:
            break;
        }
      });
    } catch (e) {
      throw Exception("Exception while adding health medication: $e");
    }
  }

  /*---------------------- 데이터 패치하기 - heatrlfood, dignosis ---------------------- */
  Future<List<ItemWithNameAndId>> fetchSpeicalNote(title) async {
    try {
      var dio = await authDioWithContext();
      var response = await dio.get("/$title/my");

      if (response.statusCode == 200 && response.data['success']) {
        return (response.data['data'] as List<dynamic>)
            .map((e) => ItemWithNameAndId.fromJson(e))
            .toList();
      } else {
        throw Exception("Error fetching healthfood: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Exception while fetching healthfood: $e");
    }
  }

  /*---------------------- 특이사항 추가 함수  ---------------------- */
  Future<void> addSpecialNoteItem(String title, dynamic item) async {
    if (title == 'healthfood' || title == 'diagnosis') {
      try {
        var dio = await authDioWithContext();
        var response =
            await dio.post("/$title", data: {"name": item as String});
        loadSpeicalNote(title);

        if (response.statusCode == 200 && response.data['success']) {
          user.update((val) {
            switch (title) {
              // underlyingConditions : 기저질환
              // allergies : 알러지
              // falls : 낙상 Date
              default:
                break;
            }
          });
        } else {
          print("Error adding health medication: ${response.statusMessage}");
        }
      } catch (e) {
        print("Exception while adding health medication: $e");
      }
      return;
    }

    user.update((val) {
      // 특이사항이 없으면 생성
      val?.specialNote ??= SpecialNote(
        underlyingConditions: [],
        allergies: [],
        falls: [],
        diagnosis: [],
        healthfood: [],
      );
      if (val?.specialNote != null) {
        switch (title) {
          case 'underlyingConditions':
            val?.specialNote!.underlyingConditions.add(item as String);
            break;
          case 'allergies':
            val?.specialNote!.allergies.add(item as String);
            break;
          case 'falls':
            val?.specialNote!.falls.add(item as DateTime);
            break;
          default:
            break;
        }
      }
    });
  }
}
