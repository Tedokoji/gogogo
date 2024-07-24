import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryView extends StatefulWidget {
  final String date;
  final String address;
  final String price;
  final String status;
  final String id;
  final bool isAdmin;
  final Function() onCheck;
  final Function(String) onClose;
  HistoryView(
      {required this.date,
      required this.address,
      required this.price,
      required this.status,
      required this.id,
      required this.isAdmin,
      required this.onCheck,
      required this.onClose,
      required});

  @override
  _CartItemViewState createState() => _CartItemViewState();
}

class _CartItemViewState extends State<HistoryView> {
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
          border: widget.status != "Chưa"
              ? Border.all(color: Colors.green)
              : Border.all(color: Colors.red),
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
                      '${widget.date}',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.4,
                        color: Color.fromARGB(255, 70, 94, 49),
                      ),
                    ),
                    Row(children: [
                      Text('${widget.price} VND',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.4,
                            color: Color.fromARGB(255, 72, 77, 34),
                          )),
                      Spacer(),
                      Builder(builder: (context) {
                        return Row(children: [
                          widget.isAdmin
                              ? Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.check),
                                      onPressed: () {
                                        // Add delete logic here
                                        //widget.Del(widget.keyid);
                                        widget.onCheck();
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        // Add delete logic here
                                        widget.onClose(widget.id);
                                        //widget.Del(widget.keyid);
                                      },
                                    )
                                  ],
                                )
                              : Container()
                        ]);
                      }),
                    ]),
                    Text(
                      'Địa chỉ giao hàng ${widget.address}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
