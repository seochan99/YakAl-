import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../models/Calendar/calendar_day.dart';

class PillCalendarDayItem extends StatefulWidget {
  final DateTime date;
  final bool isSelected;
  final CalendarDay? calendarDay;
  const PillCalendarDayItem(
      {Key? key,
      required this.date,
      required this.isSelected,
      this.calendarDay})
      : super(key: key);

  @override
  State<PillCalendarDayItem> createState() =>
      _PillCalendarDayItemState(calendarDay: calendarDay);
}

class _PillCalendarDayItemState extends State<PillCalendarDayItem> {
  final CalendarDay? calendarDay;

  _PillCalendarDayItemState({this.calendarDay});

  @override
  Widget build(BuildContext context) {
    return calendarDay == null
        ? Container()
        : Center(
            child: Column(
              children: [
                CircularPercentIndicator(
                  percent: calendarDay!.progress / 100,
                  radius: 18,
                  lineWidth: 2,
                  animation: true,
                  animateFromLastPercent: true,
                  progressColor: const Color(0xFF2666F6),
                  backgroundColor: const Color(0xFFF1F5FE),
                  center: Stack(
                    children: [
                      // 완료 됐을 때 보일 원
                      if (calendarDay!.progress == 100)
                        Container(
                          margin: const EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F5FE),
                            shape: BoxShape.circle,
                          ),
                        ),
                      if (widget.isSelected)
                        Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: const BoxDecoration(
                            color: Color(0xFF5588FD),
                            shape: BoxShape.circle,
                          ),
                        ),
                      Center(
                        child: Text(
                          widget.date.day.toString(),
                          style: widget.isSelected
                              ? const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)
                              : const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox.fromSize(size: const Size.fromHeight(5)),
                calendarDay!.isOverlap
                    ? SvgPicture.asset(
                        'assets/icons/icon-overlap.svg',
                        width: 36,
                      )
                    : SizedBox.fromSize(size: const Size.fromHeight(20)),
              ],
            ),
          );
  }
}