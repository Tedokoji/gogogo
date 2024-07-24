import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gogogo/API/shareprefs.dart';

import 'package:gogogo/View/Home/Home_skele.dart';

import 'package:gogogo/View/LogReg/Regis.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  int _counter = 0;
  String name = '';
  bool isnamenotexist = false;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            isnamenotexist
                                                ? 'Tên không tồn tại'
                                                : 'Tên:',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              height: 1.5,
                                              color: Color(0xFF3C3C3C),
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
                                                name = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Tên đăng nhập',
                                              hintStyle: GoogleFonts.getFont(
                                                'Poppins',
                                                fontWeight: FontWeight.w400,
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
                          ],
                        ),
                      ),
                      Container(
                        //register
                        width:
                            double.infinity, // Spans the entire available width
                        margin: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF43936C),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (name == '') return;
                            final ref = FirebaseDatabase.instance.ref();
                            final snapshot =
                                await ref.child('users/${name}').get();
                            final reff =
                                await ref.child('users/${name}/admin').get();
                            if (!snapshot.exists) {
                              isnamenotexist = true;
                              Fluttertoast.showToast(
                                msg:
                                    "Tên không tồn tại",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              return;
                            } else {
                              storeUserLogin('$name');

                              var testbruh = await ref
                                  .child('users/${name}/Phonenum')
                                  .get();
                              storeIsAdmin(reff.value as bool);
                              // storeIsAdmin(bool.parse(isaddddminnn.value));
                              storeFireBaseDataUser(
                                  '${testbruh.value}', name, '');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeSKE()),
                              );
                            }
                          },
                          child: Text(
                            'Đăng nhập',
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
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 45),
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                height: 1.4,
                                color: Color(0xFF5D4037),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Chưa đăng ký?  ',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    height: 1.3,
                                    color: Color(0xFF555555),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Đăng ký',
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
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Regis()),
                        ),
                      )
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
