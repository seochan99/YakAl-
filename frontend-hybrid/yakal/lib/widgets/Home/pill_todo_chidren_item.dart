import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/Home/e_taking_time.dart';
import '../../models/Home/pill_todo_children.dart';

class PillTodoChildrenItem extends StatefulWidget {
  final ETakingTime eTakingTime;
  final PillTodoChildren pillTodoChildren;
  final Function(ETakingTime, int) onClickChildrenCheckBox;
  final Function(ETakingTime, int) onClickChildrenItemView;

  const PillTodoChildrenItem(
      {required this.eTakingTime,
      required this.pillTodoChildren,
      required this.onClickChildrenCheckBox,
      required this.onClickChildrenItemView,
      Key? key})
      : super(key: key);

  @override
  State<PillTodoChildrenItem> createState() => _PillTodoChildrenItemState();
}

class _PillTodoChildrenItemState extends State<PillTodoChildrenItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClickChildrenCheckBox(
            widget.eTakingTime, widget.pillTodoChildren.id);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox.fromSize(size: const Size(15, 20)),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: widget.pillTodoChildren.base64Image.isEmpty
                  ? SvgPicture.asset(
                      'assets/icons/icon-check-on-36.svg',
                      width: 80,
                      height: 40,
                      color: Colors.blue,
                    )
                  : Image.memory(
                      base64Decode(widget.pillTodoChildren.base64Image),
                      width: 80,
                      height: 40,
                    ),
            ),
            SizedBox.fromSize(size: const Size(10, 10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.pillTodoChildren.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.pillTodoChildren.effect,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff8d8d8d),
                  ),
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                widget.onClickChildrenCheckBox(
                    widget.eTakingTime, widget.pillTodoChildren.id);
              },
              // InkWell Repple Effect 없애기
              splashColor: Colors.transparent,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(24)),
                width: 48,
                height: 48,
                child: widget.pillTodoChildren.isTaken
                    ? SvgPicture.asset('assets/icons/icon-check-oval-on-24.svg')
                    : SvgPicture.asset(
                        'assets/icons/icon-check-oval-off-24.svg'),
              ),
            ),
            SizedBox.fromSize(size: const Size(15, 20)),
          ],
        ),
      ),
    );
  }
}