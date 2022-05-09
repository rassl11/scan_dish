import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scan/provider.dart';
import 'package:scan/scan.dart';

class Filial extends StatelessWidget {
  const Filial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Контроль хранения'),
        backgroundColor: Colors.cyan[900],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.r)),
                    height: 50.h,
                    width: 150.h,
                    child: Center(
                      child: Text(
                        'Выбери филиал',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    )),
                SizedBox(
                  height: 200.h,
                ),
                GestureDetector(
                  child: Container(
                      height: 55.h,
                      width: 160.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey[200],
                      ),
                      
                      child: Center(
                          child: Text(
                        '''Timekeeper 
Westminster''',
                        style: TextStyle(fontSize: 16.sp),
                      ))),
                  onTap: () async {
                    context.read<FilialInfo>().changeFilial('Timekeeper Westminster');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Scan()),
                    );
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.grey[200],
                        ),
                        height: 55.h,
                        width: 160.w,
                        child: Center(
                            child: Text(
                          '''Timekeeper
   Alayskiy''',
                          style: TextStyle(fontSize: 16.sp),
                        ))),
                    onTap: () {
                      context
                          .read<FilialInfo>()
                          .changeFilial('Timekeeper Alayskiy');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Scan()),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    child: Container(
                        height: 55.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.grey[200],
                        ),
                        child: Center(
                            child: Text(
                          '''Timekeeper 
      Цех''',
                          style: TextStyle(fontSize: 16.sp),
                        ))),
                    onTap: () {
                      context.read<FilialInfo>().changeFilial('Timekeeper Цех');
                      context.read<FilialInfo>().changeFilial('Timekeeper Цех');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Scan()),
                      );
                    },
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
