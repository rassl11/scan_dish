import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan/shared_pref.dart';

import 'filial.dart';

class Reg extends StatefulWidget {
  const Reg({Key? key}) : super(key: key);

  @override
  _RegState createState() => _RegState();
}

late TextEditingController _nameController;

class _RegState extends State<Reg> {
  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Регистрация',
                style: TextStyle(fontSize: 20.sp),
              ),
              TextFormField(
                showCursor: true,
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
                decoration: InputDecoration(
                    errorStyle: TextStyle(
                        color: Colors.deepOrange[400],
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900),
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.all(
                      18.r,
                    ),
                    filled: true,
                    prefixStyle: TextStyle(
                      fontSize: 16.sp,
                    ),
                    labelText: "Имя",
                    labelStyle: TextStyle(fontSize: 16.sp, color: Colors.black),
                    fillColor: Color.fromARGB(255, 229, 235, 238),
                    border: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(width: 1, color: Colors.red)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(width: 1, color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(width: 1, color: Colors.white))),
                enabled: true,
                controller: _nameController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await UserSimplePreferences.setName(_nameController.text.trim());
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Filial(),
                      ),
                    );
                  },
                  child: Text(
                    'Войти',
                    style: TextStyle(fontSize: 16.sp),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
