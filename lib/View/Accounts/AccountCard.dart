import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountCard extends StatefulWidget {
  final String accountname;
  final String ProName;
  final String Number;
  final String URL;

  final bool isAdmin;
  final Function(String) onCheck;
  final Function(String) onClose;
  AccountCard(
      {required this.accountname,
      required this.Number,
      required this.ProName,
      required this.URL,
      required this.isAdmin,
      required this.onCheck,
      required this.onClose,
      required});

  @override
  _CartItemViewState createState() => _CartItemViewState();
}

class _CartItemViewState extends State<AccountCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ProDetails(
        //       bike: product,
        //     ),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(1),
        width: double.infinity,
        height: 120.0,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên đăng nhập: ${widget.accountname}',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.4,
                        color: Color.fromARGB(255, 70, 94, 49),
                      ),
                    ),
                    Row(children: [
                      Text('Tên gọi: ${widget.ProName} ',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.4,
                            color: Color.fromARGB(255, 72, 77, 34),
                          )),
                    ]),
                    Row(
                      mainAxisSize:
                          MainAxisSize.min, // Restrict row width to content
                      children: [
                    Text(
                      'Số điện thoại ${widget.Number}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),Spacer(),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Handle edit button press
                            widget.onCheck(widget.accountname);
                          },
                        ),
                        GestureDetector(
                          child: Icon(Icons.delete),
                          onLongPress: () {
                            // Handle delete button press
                            widget.onClose(widget.accountname);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
