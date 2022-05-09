import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class FilialInfo with ChangeNotifier {
  String filial = '';
  String qrCode = '';

  bool cook = false;

  bool endCook = false;

  bool get getEndCook => endCook;

  void changeEndCook(bool a){
    endCook = a;
    notifyListeners();
  }

  bool get getCook =>cook;

  void changeCook(bool a){
    cook = a;
    notifyListeners();
  }

  String get getFilial => filial;

  void changeFilial(String a) {
    filial = a;
    notifyListeners();
  }

  Future<void> scanQRCode() async {
    qrCode = 'gfgf 08.11.2022';
        // await FlutterBarcodeScanner.scanBarcode(
        //     '#ff6666', 'cancel', false, ScanMode.QR);
  }


  Future<void> sendNotification() async {

    const postUrl = 'https://fcm.googleapis.com/fcm/send';

    String podpiska = "/topics/" + 'podpiska';


    final data = {
      "notification": {
        "body": 'Новое списание ',
        "title": 'TIMEKEEPER',
        "sound": 'default',
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done",
        "screen": "second",
        "sound": 'default',
      },
      "to": podpiska
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAxHAUXME:APA91bGuZqh6NT0dXU9K_P2mYAUohJUQAqDootSuPBIGBbMlho9gyKFliCRHTlNQDRpIK1O8apR-LWCnf15dQAXaKrng6R_XFFE5ZFYXAAQO90UGmwwSvbbZgPclSZsau6ksTwJG9z6r'
    };
    try {
      final response = await http.post(Uri.parse(postUrl),
          body: json.encode(data),
          encoding: Encoding.getByName('utf-8'),
          headers: headers);

      if (response.statusCode == 200) {}
    } on SocketException{}
  }
}
