import SwiftUI

//MARK: - Day Model
struct DayModel: Identifiable,Hashable {
    let id = UUID()
    let date: Date
    let medications: [Medicine] // List of medications for the day
    
    var dayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    // 한국어 요일 변환
    var weekdayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_KR") // 한국어 로케일 설정
        return formatter.string(from: date)
    }

    var fullWeekdayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
}

//MARK: - Calendar Week View : 매 주차 뷰
struct CalendarWeekView: View {
    // 모델 생성
    var weekDates: [DayModel]
    
    // 뷰
    var body: some View {
        HStack(spacing: 45) {
            ForEach(weekDates, id: \.self) { date in
                VStack {
                    Text("\(date.weekdayText)")
                        .font(
                        Font.custom("SUIT", size: 12)
                        .weight(.bold)
                        )
                        .foregroundColor(weekdayColor(for: date.weekdayText))
                    Text("\(date.dayText)")
                        .font(
                        Font.custom("SUIT", size: 12)
                        .weight(.medium)
                        )
                        .foregroundColor(weekdayColor(for: date.weekdayText))
                }
            }
        }.frame(maxWidth: .infinity, alignment: .center)
    }
    
    func weekdayColor(for weekdayText: String) -> Color {
        switch weekdayText {
            case "일":
                return Color(red: 0.88, green: 0.06, blue: 0.16) // 일요일 색상
            case "토":
                return Color(red: 0.33, green: 0.53, blue: 0.99) // 토요일 색상
            default:
                return Color.black // 기본 색상
        }
    }
    
}



struct CalendarSwiftUIView: View {
    @State private var currentDate = Date()
    @State private var isExpanded = false
    @State private var currentWeekIndex = 0 // 이 부분을 추가해 주세요

    // 년 월 표현
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter
    }
    
    // 예시 약물
    var sampleMedications: [Medicine] = [
        Medicine(id: 1, image: "image_덱시로펜정", name: "약물A", ingredients: "성분 A", dangerStat: 0, isTaken: false),
        Medicine(id: 2, image: "image_덱시로펜정", name: "약물B", ingredients: "성분 B", dangerStat: 1, isTaken: false)
    ]
    
    // 일주일 생성
    var sampleWeekDates: [[DayModel]] {
        var allWeekDates: [[DayModel]] = []
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        guard let startOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .weekOfMonth, in: .month, for: startOfMonth) else {
            return allWeekDates
        }
        
        for week in range {
            var weekDates: [DayModel] = []
            let startOfWeek = calendar.date(bySetting: .weekOfMonth, value: week, of: startOfMonth)!
            for day in 0..<7 {
                if let date = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                    let dayModel = DayModel(date: date, medications: sampleMedications)
                    weekDates.append(dayModel)
                }
            }
            allWeekDates.append(weekDates)
        }
        return allWeekDates
    }

    
    var body: some View {
        ScrollView{
            
        // --------------- 달력 뷰 ---------------
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Button(action: {
                    self.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate) ?? self.currentDate
                }) {
                    Image(systemName: "arrow.left")
                }
                
                Text(dateFormatter.string(from: currentDate))
                    .font(
                        Font.custom("SUIT", size: 15)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))

                Button(action: {
                    self.currentDate = Calendar.current.date(byAdding: .month, value: 1, to: self.currentDate) ?? self.currentDate
                }) {
                    Image(systemName: "arrow.right")
                }
                Spacer()
            }
            
            // 펼쳐졌을 경우의 뷰
            if isExpanded {
                ForEach(sampleWeekDates, id: \.self) { weekDates in
                    CalendarWeekView(weekDates: weekDates)
                }
            } else {
                CalendarWeekView(weekDates: sampleWeekDates[currentWeekIndex])
            }
            
            // 달력 펼치기
            Button(action: {
                withAnimation {
                    self.isExpanded.toggle()
                }
            }) {
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            }

            VStack(spacing: 0){
                HStack{
                    VStack{
                        HStack{
                            Text("2023년 7월 20일")
                              .font(
                                Font.custom("SUIT", size: 15)
                                  .weight(.semibold)
                              )
                              .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                        }.frame(maxWidth: .infinity, alignment: .leading)
     
                        HStack{
                            Text("14개 복용 ")
                              .font(
                                Font.custom("SUIT", size: 20)
                                  .weight(.bold)
                              )
                              .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                            Text("(15개)")
                              .font(
                                Font.custom("SUIT", size: 15)
                                  .weight(.semibold)
                              )
                              .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                                        
                    }
                    Spacer()
                    VStack{
                        Text("89%")
                          .font(
                            Font.custom("SUIT", size: 16)
                              .weight(.semibold)
                          )
                          .multilineTextAlignment(.center)
                          .foregroundColor(Color(red: 0.33, green: 0.53, blue: 0.99))
                          .frame(width: 44, height: 16, alignment: .top)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading) // 왼쪽에 붙이는 부분
                    .padding(.horizontal,20)
                    .padding(.vertical,20)
                    .background(Color(red: 233.0/255.0, green: 233.0/255.0, blue: 238.0/255.0))
                
                // 약물 View
                MedicationSwiftUIView()
                    .environmentObject(MedicationData())
                    .padding(.horizontal, 0) // 수평 여백을 없애는 부분
                    .padding(.vertical, 0) // 수평 여백을 없애는 부분
            }
        
                


        }
        .padding(.horizontal, 0) // 수평 여백을 없애는 부분
        

        // --------------- 약물 뷰 ---------------

    }
        
    }
}


extension Date {
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    
}
struct CalendarSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarSwiftUIView()
    }
}
