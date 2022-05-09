import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scan/provider.dart';
import 'package:scan/shared_pref.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

String qrCode = '';

Future findValue(BuildContext context, qrCode) async {
  final snapShot = await FirebaseFirestore.instance
      .collection('dish')
      .doc(context.read<FilialInfo>().getFilial)
      .get();
  if (snapShot.exists) {
    if (snapShot.data()!.containsKey(
        DateTime.now().day.toString().padLeft(2, '0') +
            "." +
            DateTime.now().month.toString().padLeft(2, '0') +
            "." +
            DateTime.now().year.toString())) {
      FirebaseFirestore.instance
          .collection('dish')
          .doc(context.read<FilialInfo>().getFilial)
          .set({
        DateTime.now().day.toString().padLeft(2, '0') +
            "." +
            DateTime.now().month.toString().padLeft(2, '0') +
            "." +
            DateTime.now().year.toString(): {
          DateTime.now().hour.toString().padLeft(2, '0') +
              ":" +
              DateTime.now().minute.toString().padLeft(2, '0') +
              ":" +
              DateTime.now().second.toString().padLeft(2, '0'): {
            "Блюдо": "$qrCode",
            "Вносил": UserSimplePreferences.getName()
          }
        },
      }, SetOptions(merge: true));
    } else {
      FirebaseFirestore.instance
          .collection('dish')
          .doc(context.read<FilialInfo>().getFilial)
          .set(
        {
          DateTime.now().day.toString().padLeft(2, '0') +
              "." +
              DateTime.now().month.toString().padLeft(2, '0') +
              "." +
              DateTime.now().year.toString(): {
            DateTime.now().hour.toString().padLeft(2, '0') +
                ":" +
                DateTime.now().minute.toString().padLeft(2, '0') +
                ":" +
                DateTime.now().second.toString().padLeft(2, '0'): {
              "Блюдо": "$qrCode",
              "Вносил": UserSimplePreferences.getName()
            }
          },
        },
      );
    }
  } else {
    FirebaseFirestore.instance
        .collection('dish')
        .doc(context.read<FilialInfo>().getFilial)
        .set(
      {
        DateTime.now().day.toString().padLeft(2, '0') +
            "." +
            DateTime.now().month.toString().padLeft(2, '0') +
            "." +
            DateTime.now().year.toString(): {
          DateTime.now().hour.toString().padLeft(2, '0') +
              ":" +
              DateTime.now().minute.toString().padLeft(2, '0') +
              ":" +
              DateTime.now().second.toString().padLeft(2, '0'): {
            "Блюдо": "$qrCode",
            "Вносил": UserSimplePreferences.getName()
          }
        },
      },
    );
  }
}

class _ScanState extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<FilialInfo>().getFilial),
        backgroundColor: Colors.cyan[900],
      ),
      body: Stack(children: [
        Center(
          child: GestureDetector(
              child: Container(
                  height: 55.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey[200],
                  ),
                  child: Center(
                      child: Text(
                    '''Отсканировать''',
                    style: TextStyle(fontSize: 16.sp),
                  ))),
              onTap: () async {
                qrCode =
                await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', 'cancel', false, ScanMode.QR);
                final date = (DateTime.now().day +
                    DateTime.now().month +
                    DateTime.now().year);
                final dateInQr = qrCode
                    .substring(qrCode.length - 10)
                    .split(".")
                    .map((it) => int.parse(it))
                    .toList();
                final asd =
                    dateInQr.reduce((value, element) => value + element);

                if (date <= asd) {
                  context.read<FilialInfo>().changeCook(true);
                  setState(() {});
                  await Future.delayed(const Duration(seconds: 4));
                  context.read<FilialInfo>().changeCook(false);
                } else {
                  findValue(context, qrCode);
                  context.read<FilialInfo>().changeEndCook(true);
                  setState(() {});
                  await Future.delayed(const Duration(seconds: 4));
                  context.read<FilialInfo>().changeEndCook(false);
                  await context.read<FilialInfo>().sendNotification();
                }
              }),
        ),
        context.watch<FilialInfo>().getCook == true
            ? SafeArea(
                child: Center(
                  child: GestureDetector(
                    child: Column(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.grey[900]!.withOpacity(0.8),
                              ),
                              height: 0.1.sh,
                              width: 0.9.sw,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.r, bottom: 5.r),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                '    Timekeeper Message',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontFamily:
                                                        'Stem-SemiLight',
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Container(
                                                child: Text(
                                              '    Приступай к готовке',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Stem-SemiLight',
                                                  color: Colors.white),
                                            )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ]),
                    onTap: () {},
                  ),
                ),
              )
            : const SizedBox(),
        context.watch<FilialInfo>().getEndCook == true
            ? SafeArea(
                child: Center(
                  child: GestureDetector(
                    child: Column(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.grey[900]!.withOpacity(0.8),
                              ),
                              height: 0.1.sh,
                              width: 0.9.sw,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 5.r,
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                '    Timekeeper Message',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontFamily:
                                                        'Stem-SemiLight',
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Container(
                                                child: Text(
                                              '    Готовить запрещено, спиши товар!',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Stem-SemiLight',
                                                  color: Colors.white),
                                            )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ]),
                    onTap: () {},
                  ),
                ),
              )
            : const SizedBox()
      ]),
    );
  }
}
