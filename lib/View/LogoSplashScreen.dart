import 'package:flutter/material.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:gogogo/Utils/size_utils.dart';
import 'package:gogogo/View/Home/Home_skele.dart';
import 'package:gogogo/View/LogReg/Regis.dart';

import 'package:gogogo/WidgetsAssets/custom_image_view.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoSplashScreen extends StatelessWidget {
  const LogoSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        /////
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xFFFEFEFE),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 68, 14, 8),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(6.3, 0, 6.3, 104),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () async {
                            if (await isLoggedIn()) {
                              Navigator.push(
                                context, // Current context
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeSKE()), // Route to Regis widget
                              );
                            } else {
                              Navigator.push(
                                context, // Current context
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Regis()), // Route to Regis widget
                              );
                            }
                          },
                          child: Text(
                            'Skip',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 1.4,
                              color: Color(0xFF3C3C3C),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 76.3),
                      child: Container(
                        child: Image(
                          image: AssetImage(
                            'assets/images/logoBicycle.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 66.3),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 23, 6.5),
                              child: Text(
                                'Chọn xe Phù hợp với bạn',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  height: 1.5,
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ),
                            Text(
                              'Cùng những phụ kiện hấp dẫn',
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                height: 1.5,
                                color: Color(0xFF555555),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        )
      ],
    );
  }
}
