
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/src/models/schedule.dart';
import 'package:schedule/src/screens/details/schedule_details.dart';

class ScheduleTile extends StatelessWidget {
  const ScheduleTile(this.schedule, {super.key});

  final Schedule schedule;

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return yellowClr;
      case 2:
        return pinkClr;
      default:
        return bluishClr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final orient = MediaQuery.of(context).orientation;
    final vertical = orient == Orientation.portrait;
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: vertical ? 4.h : 10.h),
        child: InkWell(
          onTap: () => navigator(context, Details(schedule)),
          child: Ink(
            padding: EdgeInsets.symmetric(vertical: vertical ? 12.h : 20.h, horizontal: vertical ? 15.w : 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: _getBGClr(schedule.color),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schedule.title,
                        style: TextStyle(
                          fontSize: vertical ? 16.sp : 8.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: vertical ? 8.h : 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey[200],
                            size: vertical ? 16.sp : 8.sp,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${schedule.startTime} - ${schedule.endTime}",
                            style: TextStyle(
                              fontSize: vertical ? 12.sp : 6.sp,
                              color: Colors.grey[100],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: vertical ? 6.h : 16.h),
                      if (schedule.description != '')
                      Text(
                        schedule.description,
                        style: TextStyle(
                          fontSize: vertical ? 14.sp : 7.sp,
                          color: Colors.grey[100],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: vertical ? 40.h : 80.h,
                  width: 0.5,
                  color: Colors.grey[200]!.withOpacity(0.7),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    schedule.isCompleted == 1 ? "Finalizada" : "Pendente",
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
