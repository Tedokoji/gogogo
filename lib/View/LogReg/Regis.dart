import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:gogogo/View/Home/Home.dart';
import 'package:gogogo/View/Home/Home_skele.dart';

import 'package:gogogo/View/LogReg/Login.dart';

import 'package:google_fonts/google_fonts.dart';

class Regis extends StatelessWidget {
  const Regis({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Regis',
      home: const RegisPage(title: 'Regis'),
    );
  }
}

class RegisPage extends StatefulWidget {
  const RegisPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<RegisPage> createState() => _MyRegisPageState();
}

class _MyRegisPageState extends State<RegisPage> {
  String number = '';
  String name = '';
  bool isnumWrong = false;
  bool isnameWrong = false;
  void CheckRegister(value) {
    setState(() {
      number = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color(0xFFFEFEFE),
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap content with SingleChildScrollView
          padding: const EdgeInsets.fromLTRB(20.0, 7.0, 20.0, 8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFEFEFE),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 80, 20, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 183.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/logoBicycle.png')),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 4),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Builder(
                                                      builder:
                                                          (context) => Text(
                                                                isnameWrong
                                                                    ? 'Error:Tên không hợp lệ'
                                                                    : 'Tên',
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 12,
                                                                  height: 1.5,
                                                                  color: isnameWrong
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          223,
                                                                          8,
                                                                          8)
                                                                      : Color(
                                                                          0xFF3C3C3C),
                                                                ),
                                                              )),
                                                ),
                                              ),
                                              Container(
                                                //name regis
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xFFD0D0D0)),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 1, 15, 13),
                                                  child: TextField(
                                                    onChanged: (value) {
                                                      setState(() {
                                                        name = value;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Nhập tên tài khoản',
                                                      hintStyle:
                                                          GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFF8A8A8A),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 4),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  isnumWrong
                                                      ? 'Phone empty or existed'
                                                      : 'Số điện thoại',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    height: 1.5,
                                                    color: isnumWrong
                                                        ? Color.fromARGB(
                                                            255, 223, 8, 8)
                                                        : Color(0xFF3C3C3C),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              //name regis
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xFFD0D0D0)),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 1, 15, 13),
                                                child: TextField(
                                                  onChanged: (value) {
                                                    setState(() {
                                                      number = value;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: 'Nhập số',
                                                    hintStyle:
                                                        GoogleFonts.getFont(
                                                      'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Color(0xFF8A8A8A),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.5,
                                        color: Color(0xFF7C7C7C),
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              'Bằng việc nhấn nút "Đăng Ký" bạn đã đồng ý với ',
                                          style: GoogleFonts.getFont(
                                            'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.3,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Điều khoản sử dụng',
                                          style: GoogleFonts.getFont(
                                            'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.3,
                                            color: Color(0xFF032172),
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' và ',
                                          style: GoogleFonts.getFont(
                                            'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.3,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Chính sách Riêng tư',
                                          style: GoogleFonts.getFont(
                                            'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.3,
                                            color: Color(0xFF032172),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //register
                              width: double
                                  .infinity, // Spans the entire available width
                              margin: const EdgeInsets.fromLTRB(
                                  0.0, 16.0, 0.0, 0.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF43936C),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  if (number.isEmpty ||
                                      !RegExp(r'^[+\d{1,4} \-]?\d{10}$')
                                          .hasMatch(number)) {
                                    setState(() {
                                      isnumWrong = true;
                                    });
                                    return;
                                  }
                                  ;

                                  final ref = FirebaseDatabase.instance.ref();
                                  final snapshot =
                                      await ref.child('users/${name}').get();
                                  if (snapshot.exists) {
                                    setState(() {
                                      isnameWrong = true;
                                    });

                                    return;
                                  }

                                  if (name == '') {
                                    setState(() {
                                      isnameWrong = true;
                                    });
                                    return;
                                  } else if (number == '') {
                                    setState(() {
                                      isnumWrong = true;
                                    });
                                  } else {
                                    storeUserLogin('$name');
                                    
                                    print('clciked db rel');
                                    final ref = FirebaseDatabase.instance
                                        .ref('users/${name}');
                                    await ref.set({
                                      "Phonenum": "${number}",
                                      'ProName': "${name}",
                                      'proURL': "",
                                      'admin':"false"
                                    });

                                    storeFireBaseDataUser(number, name, '');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeSKE()),
                                    );
                                  }
                                },
                                child: Text(
                                  'Đăng ký',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    height: 1.4,
                                    color: Color(0xFFFEFEFE),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 45.5),
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                height: 1.4,
                                color: Color(0xFF000000),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Đã có tài khoản?',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    height: 1.3,
                                    color: Color(0xFF555555),
                                  ),
                                ),
                                TextSpan(
                                  text: ' Đăng nhập',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    height: 1.3,
                                    color: Color(0xFF5D4037),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                        width: 0,
                        height: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF000000),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Container(
                            width: 0,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
