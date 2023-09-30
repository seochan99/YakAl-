import 'question_model.dart';
import './question_data.dart';

class SurveyModel {
  final String title;
  final String comment;
  final String time;
  final String iconPath;
  final List<QuestionModel> questions;
  bool isCompleted;
  int totalScore;
  String resultComment;
  final String resultDescription;

  SurveyModel({
    required this.title,
    required this.comment,
    required this.questions,
    required this.time,
    required this.iconPath,
    required this.isCompleted,
    required this.totalScore,
    required this.resultComment,
    required this.resultDescription,
  });

  int get getTotalScore => totalScore;

  set setTotalScore(int score) {
    totalScore = score;
  }

  void setComment(int score) {
    switch (title) {
      case '복약 순응도 테스트':
        resultComment = '$score/48점 입니다.';
        break;
      case '우울증 선별 테스트':
        if (score >= 0 && score <= 4) {
          resultComment = '우울증상이 없습니다';
        } else if (score >= 5 && score <= 9) {
          resultComment = '가벼울 우울증상이 있습니다';
        } else if (score >= 10 && score <= 19) {
          resultComment = '중간정도의 우울증이 의심됩니다';
        } else if (score >= 20 && score <= 27) {
          resultComment = '심한 우울증이 의심됩니다';
        } else {
          resultComment = '우울증상이 없습니다';
        }
        break;
      case '불면증 심각도 테스트':
        if (score >= 0 && score <= 7) {
          resultComment = '정상입니다';
        } else if (score >= 8 && score <= 14) {
          resultComment = '약간의 불면증이 있습니다';
        } else if (score >= 15 && score <= 21) {
          resultComment = '중등도의 불면증이 있습니다';
        } else if (score >= 22) {
          resultComment = '심한 불면증이 있습니다';
        } else {
          resultComment = '정상입니다';
        }
        break;
      case '우울 척도 테스트':
        if (score >= 0 && score <= 5) {
          resultComment = '정상 입니다';
        } else if (score >= 6 && score <= 10) {
          resultComment = '중간정도의 우울상태 입니다';
        } else if (score >= 11 && score <= 15) {
          resultComment = '중증도의 우울증이 의심됩니다';
        } else {
          resultComment = '우울증상이 없습니다';
        }
        break;
      case "노쇠 테스트":
        if (score == 0) {
          resultComment = '건강한 상태입니다';
        } else if (score >= 1 && score <= 2) {
          resultComment = "노쇠 전단계가 의심됩니다";
        } else if (score >= 3) {
          resultComment = "노쇠가 의심됩니다.";
        } else {
          resultComment = '건강한 상태입니다';
        }
      case "시청각 테스트":
        if (score == 0) {
          resultComment = '건강한 상태입니다';
        } else if (score >= 1 && score <= 2) {
          resultComment = "노쇠 전단계가 의심됩니다";
        } else if (score >= 3) {
          resultComment = "노쇠가 의심됩니다.";
        } else {
          resultComment = '건강한 상태입니다';
        }
      case "일상생활 동작 지수":
        if (score <= 4) {
          resultComment = "전문가 상담을 통해 치매 검사를 받아 보시기를 추천 드립니다";
        } else if (score >= 5) {
          resultComment = "정상 입니다";
        }
      default:
        resultComment = '테스트가 정상적으로 진행되지 않았습니다.';
    }
  }

  String get getResultComment => resultComment;
}

final List<SurveyModel> tests = [
  SurveyModel(
    title: '복약 순응도 테스트',
    comment: '약알 이용자의 복약 습관과 복약 순응도를 파악하여 의약품 복용에 도움을 드리기 위한 설문입니다.',
    iconPath: 'assets/icons/circle_1.svg',
    time: '3',
    isCompleted: false,
    // 12개의 질문만들기
    questions: List<QuestionModel>.generate(
      12,
      (index) => QuestionModel(
        question: questionsBokyak[index],
        options: ['전혀없음', '가끔', '대부분', '항상'],
        scores: [1, 2, 3, 4],
      ),
    ),
    totalScore: 0,
    resultComment: '',
    resultDescription:
        "복약 순응도 점수가 낮은 상황에서는 의사의 처방 및 약사의 복약지도가 환자의 건강상태를 개선시키는 데 어려움이 있습니다. 해당되는 이용자에게는 적절한 복약 알림과  복약 현황 파악을 통해 복약 순응도를 높일 수 있습니다.",
  ),
  SurveyModel(
    title: '우울 척도 테스트',
    comment:
        '이용자의 우울 여부는 일상생활의 동기부여나 복약 준수도에 영향을 미칠 수 있습니다. 이용자의 상태를 파악하여 심리 상담 등 도움을 드릴 수 있습니다.',
    iconPath: 'assets/icons/circle_4.svg',
    time: '3',
    isCompleted: false,
    // 12개의 질문만들기
    questions: List<QuestionModel>.generate(
      15,
      (index) => QuestionModel(
        question: questionDepressionScale[index],
        options: ["예", "아니오"],
        scores: [0, 1],
      ),
    ),
    totalScore: 0,
    resultComment: '',
    resultDescription:
        "우울증이 너무 심하면 약을 잘 먹지 않는 것과 같이 치료에 영향을 줄 수 있습니다. 심한 우울에 해당하는 이용자는 전문기관의 치료적 개입과 평가가 필요한 상황입니다. 중간정도의 우울에 해당하는 이용자는 가까운 지역센터나 전문기관의 방문을 통해 상담이 권유됩니다. 가벼운 우울상태인 이용자들은 규칙적인 생활습관과 충분한 수면, 그리고 운동하는 습관을 통해 개선될 수 있습니다.",
  ),
  SurveyModel(
    title: '노쇠 테스트',
    comment:
        '노인분들을 대상으로 하는 일회성 설문조사입니다. 노쇠 증상에 해당되는지 여부를 파악하여 도움을 드리기 위한 설문입니다.',
    iconPath: 'assets/icons/circle_2.svg',
    time: '3',
    isCompleted: false,
    // 12개의 질문만들기
    questions: List<QuestionModel>.generate(
      5,
      (index) => QuestionModel(
        question: questionAging[index],
        options: ["예", "아니오"],
        scores: [0, 1],
      ),
    ),
    totalScore: 0,
    resultComment: '',
    resultDescription:
        "노쇠증상이 많을수록 쇠약한 상태라는 것을 의미합니다. 쇠약한 상태일수록 외부 자극이나 스트레스에 취약해질 수 있기 때문에 적절한 운동과 건강한 생활습관으로 개선해야 합니다.",
  ),
  SurveyModel(
    title: '우울증 선별 테스트',
    comment:
        '이용자의 우울 여부는 일상생활의 동기부여 나 의약품 복약 준수도에 영향을 미칠 수 있습니다. 이용자의 상태를 파악하여 심리 상담 등 도움을 드릴 수 있습니다.',
    iconPath: 'assets/icons/circle_2.svg',
    time: '3',
    isCompleted: false,
    // 12개의 질문만들기
    questions: List<QuestionModel>.generate(
      9,
      (index) => QuestionModel(
        question: questionsDepressionScreening[index],
        options: ['전혀없음', '2~6일', '7일 이상', '거의 매일'],
        scores: [0, 1, 2, 3],
      ),
    ),
    totalScore: 0,
    resultComment: '',
    resultDescription:
        "총점이 10점 이상으로 주요우울장애가 의심되거나9번 문항을 1점 이상으로 응답한 경우  (즉, 자살/자해 생각이 있는 경우) 가까운 병∙ 의원에서 진료를 받거나, 정신건강복지센터(또는 정신건강 위기상담전화)에서 상담을 받을 필요가 있습니다. 가벼운 우울상태인 이용자들은  규칙적인 생활습관과 충분한 수면, 그리고 운동하는 습관을 통해 개선될 수 있습니다.",
  ),
  SurveyModel(
    title: '불면증 심각도 테스트',
    comment: '이용자의 불면증에 해당하는지 여부를 파악하여 수면 건강 및 전체적인 건강에 도움을 드리기 위한 설문입니다.',
    iconPath: 'assets/icons/circle_3.svg',
    time: '3',
    isCompleted: false,
    // 12개의 질문만들기
    questions: List<QuestionModel>.generate(
      9,
      (index) => QuestionModel(
        question: questionsDepressionScreening[index],
        options: ["매우", "그렇다", "보통", "아니다", "전혀 아니다"],
        scores: [0, 1, 2, 3, 4],
      ),
    ),
    totalScore: 0,
    resultComment: '',
    resultDescription:
        "충분한 수면과 좋은 수면의 질은 이용자의 건강에 중요한 요소입니다. 이 설문에서 높은 점수를 받을수록 불면증이 심한 상태이기 때문에 수면 클리닉이나 의료기관을 방문하여 적절한 치료가 필요합니다.",
  ),
  SurveyModel(
    title: '시청각 테스트',
    comment: '이용자의 안경 및 보청기 사용유무를 파악하기 위한 설문입니다.',
    iconPath: 'assets/icons/circle_1.svg',
    time: '3',
    isCompleted: false,
    // 12개의 질문만들기
    questions: List<QuestionModel>.generate(
      2,
      (index) => QuestionModel(
        question: questionAuditoryTest[index],
        options: ["예", "아니오"],
        scores: [0, 1],
      ),
    ),
    totalScore: 0,
    resultComment: '',
    resultDescription:
        "시각 및 청각의 건강상태는 이용자의 삶의 질에 큰 영향을 줄 수 있고 적절한 보조 장치를 사용하거나 치료를 통해 개선될 수 있습니다.",
  ),
  SurveyModel(
    title: '일상생활 동작 지수',
    comment:
        '노인분들을 대상으로 하는 일회성 설문조사입니다. 일상에서의 동작을 무리없이 수행할 수 있는지 여부를 파악하여 이용자에게 물리치료 요법을 추천드릴 수 있습니다.',
    iconPath: 'assets/icons/circle_2.svg',
    time: '3',
    isCompleted: false,
    // 12개의 질문만들기
    questions: List<QuestionModel>.generate(
      6,
      (index) => QuestionModel(
        question: questionActivitiesOfDailyLiving[index],
        options: ["예", "아니오"],
        scores: [0, 1],
      ),
    ),
    totalScore: 0,
    resultComment: '',
    resultDescription:
        "일상 생활 동작 지수 설문에서 낮은 점수일수록 일상생활의 동작에 어려움이 있음을 의미합니다. 적절한 물리적 치료요법으로 개선할 수 있습니다.",
  ),
];
