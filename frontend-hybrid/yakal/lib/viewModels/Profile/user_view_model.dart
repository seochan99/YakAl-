import 'package:get/get.dart';
import '../../models/Profile/user.dart';

class UserViewModel extends GetxController {
  var user = User(nickName: '약 알').obs;

  // Update nickname
  void updateNickName(String newNickName) {
    user.update((val) {
      val?.nickName = newNickName;
    });
  }

  // 보호자 정보 추가
  void addOrUpdateGuardian(String name, DateTime? birthDate) {
    user.update((val) {
      val?.guardian = Guardian(name: name, birthDate: birthDate);
    });
  }

  // 특이사항 기저질환 삭제
  void removeUnderlyingCondition(int index) {
    user.update((val) {
      val?.specialNote?.underlyingConditions.removeAt(index);
    });
  }

  // 특이사항 알러지 추가
  void addAllergy(String allergy) {
    user.update((val) {
      val?.specialNote?.allergies.add(allergy);
    });
  }

  // 특이사항 알러지 삭제
  void removeAllergy(int index) {
    user.update((val) {
      val?.specialNote?.allergies.removeAt(index);
    });
  }

  // 특이사항 1년간 진단병 삭제
  void removeOneYearDisease(int index) {
    user.update((val) {
      val?.specialNote?.oneYearDisease.removeAt(index);
    });
  }

  void addSpecialNoteItem(String title, dynamic item) {
    user.update((val) {
      if (val?.specialNote != null) {
        switch (title) {
          case 'underlyingConditions':
            val?.specialNote!.underlyingConditions.add(item as String);
            break;
          // allergies
          case 'allergies':
            val?.specialNote!.allergies.add(item as String);
            break;
          case 'oneYearDisease':
            val?.specialNote!.oneYearDisease.add(item as String);
            break;
          case 'healthMedications':
            val?.specialNote!.healthMedications.add(item as String);
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

  // 특이사항 1년간 진단병 삭제
  void removeHealthMedications(int index) {
    user.update((val) {
      val?.specialNote?.healthMedications.removeAt(index);
    });
  }

  // 특이사항 낙상 삭제
  void removeFall(int index) {
    user.update((val) {
      val?.specialNote?.falls.removeAt(index);
    });
  }

  // 입원기록 추가
  void addHospitalRecord(DateTime admissionDate, String location) {
    user.update((val) {
      val?.hospitalRecordList ??= HospitalRecordList(
        admissionRecords: [],
        emergencyRoomVisits: [],
      );

      val?.hospitalRecordList?.admissionRecords.add(
        HospitalRecord(date: admissionDate, location: location),
      );
    });
  }

  // 입원기록 삭제
  void removeHospitalRecord(int index) {
    user.update((val) {
      val?.hospitalRecordList?.admissionRecords.removeAt(index);
    });
  }

  // 응급실 기록 추가
  void addEmergencyRoomVisit(DateTime admissionDate, String location) {
    user.update((val) {
      val?.hospitalRecordList ??= HospitalRecordList(
        admissionRecords: [],
        emergencyRoomVisits: [],
      );

      val?.hospitalRecordList?.emergencyRoomVisits.add(
        HospitalRecord(date: admissionDate, location: location),
      );
    });
  }

  // 응급실 기록 삭제
  void removeEmergencyRoomVisit(int index) {
    user.update((val) {
      val?.hospitalRecordList?.emergencyRoomVisits.removeAt(index);
    });
  }
}
