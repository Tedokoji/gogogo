import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:gogogo/View/Accounts/Account.dart';

import 'package:gogogo/View/Home/Home_skele.dart';

import 'package:gogogo/View/LogReg/Regis.dart';

import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  final String id;
  const EditProfile({super.key, required this.id});
  @override
  State<EditProfile> createState() => LoginState();
}

class LoginState extends State<EditProfile> {
  String url = '';
  String name = '';
  String number = '';
  bool isnumWrong = false;
  bool isnameWrong = false;
  bool isnamenotexist = false;
  void _incrementCounter() {
    setState(() {});
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Handle back button press
        ),
        title: Text('Thay dổi thông tin'),
      ),
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
                                            'Tên gọi:',
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
                                              hintText: 'Tên',
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
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            isnumWrong
                                                ? 'Số không hợp lệ'
                                                : 'SĐT:',
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
                                                number = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Số',
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
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'URL hình đại diện:',
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
                                                url = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'URL',
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
                                      Container(
                                        //register
                                        width: double
                                            .infinity, // Spans the entire available width
                                        margin: const EdgeInsets.fromLTRB(
                                            0.0, 16.0, 0.0, 0.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF43936C),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
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

                                            final ref =
                                                FirebaseDatabase.instance.ref();
                                            
                                            final snapshot = await ref
                                                .child('users/${widget.id}')
                                                .get();

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
                                              DatabaseReference ref =
                                                  FirebaseDatabase.instance
                                                      .ref("users/${widget.id}");

                                              print('clciked db rel');
                                              storeFireBaseDataUser(number, name, url);
                                              await ref.update({
                                                "Phonenum": "${number}",
                                                "ProName": "${name}",
                                                "proURL": "${url}",
                                              });
                                              
                                            }
                                          },
                                          child: Text(
                                            'Thay đổi',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              height: 1.4,
                                              color: Color(0xFFFEFEFE),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
