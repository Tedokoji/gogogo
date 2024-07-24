import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:gogogo/Model/Bike.dart';
import 'package:gogogo/View/Details/PlusMinusBtn.dart';
import 'package:gogogo/View/Home/AutoCarousel.dart';
import 'package:gogogo/View/LogReg/constants.dart';
import 'package:gogogo/View/Order/Cart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProDetails extends StatefulWidget {
  //final Map<String, dynamic> productData; // Data about the product
  final Bike bike;
  const ProDetails({Key? key, required this.bike}) : super(key: key);
//required this.productData
  @override
  _ProDetailsState createState() => _ProDetailsState();
}

class _ProDetailsState extends State<ProDetails> {
  int Price = 0;
  int _currentQuantity = 1;
  @override
  Widget build(BuildContext context) {
    String outputPrice = NumberFormat.decimalPattern().format(Price);
    // final String name = widget.productData['name']; // Accessing data from parent
    // final String description = widget.productData['description'];
    // final double price = widget.productData['price'];
    void addCart() async {
      
      // Check if an item with the same name already exists
      try {
        final currentUser = await getUserName();
        final ref = FirebaseDatabase.instance.ref('users/${currentUser}/Cart');

        final cartId = ref.push().key;

        // Update the Cart collection with unique ID
        await ref.child(cartId!).set({
          "name": widget.bike.name,
          "price": widget.bike.price,
          "quantity": _currentQuantity,
          "url": widget.bike.thumb
        });
        Fluttertoast.showToast(
          msg: "Đã thêm vào giỏ!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }

    void savRating(double) {}

    void changeQuan(var val) {
      setState(() {
        _currentQuantity = val;
      });
      setState(() {
        Price = _currentQuantity * widget.bike.price;
      });
      print(Price);
    }

    List<Widget> carouselItems = [
      // Your carousel item widgets here
      ListView.builder(
        itemCount: widget
            .bike.thumbDetail.length, // Use thumbnumber for number of items
        itemBuilder: (context, index) {
          if (index == 0) {
            final imageUrl = '${widget.bike.thumb}'; // Construct image URL
            return Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.contain, // Adjust fit as needed
            );
          } else {
            final imageUrl =
                '${widget.bike.thumbDetail[index]}'; // Construct image URL
            return Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.contain, // Adjust fit as needed
            );
          }
        },
      ),

      // 'assets/images/poster-bike-ride-called-big-bicyclist_40382-409.avif'
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0, // Loại bỏ khoảng cách mặc định giữa leading và title
        title: Row(
          children: [
            Text(
              'Chi tiết',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // Phần còn lại của AppBar
      ),
      // Phần thân của Scaffold
      body: Column(
        children: [
          Text(''),
          Expanded(
            child: Container(
              height:
                  MediaQuery.of(context).size.height * 0.4, // Set height to 40%

              // Add decoration with a box shadow
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.grey.withOpacity(0.5), // Gray color with opacity
                    blurRadius: 10.0, // Blur radius of the shadow
                    spreadRadius: 5.0, // Spread radius of the shadow (optional)
                    offset: Offset(
                        2.0, 2.0), // Offset the shadow slightly (optional)
                  ),
                ],
              ),

              child: AutoSwipeCarousel(
                children: carouselItems,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0), // Shrink 30px left and right
            decoration: BoxDecoration(
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 7.5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${widget.bike.brand}', //cate
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                height: 1.4,
                                color: Color(0xFF43936C),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize:
                              MainAxisSize.max, // Set width to full screen
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Align left and right
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Align vertically
                          children: [
                            Text(
                              '${widget.bike.name}',
                              style: TextStyle(
                                  fontSize: 16.0), // Adjust font size as needed
                            ),
                            Text(
                              '${widget.bike.price} VND',
                              style: TextStyle(
                                  fontSize: 16.0), // Adjust font size as needed
                            ),
                          ],
                        ),
                        Text(''),
                        Row(
                          mainAxisSize:
                              MainAxisSize.max, // Set width to full screen
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Align left and right
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Align vertically
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                  fontSize: 16.0), // Adjust font size as needed
                            ),
                            InputQty.int(
                              onQtyChanged: (val) {
                                _currentQuantity = val;
                                changeQuan(val);
                                print(_currentQuantity);
                              },
                              qtyFormProps:
                                  QtyFormProps(enableTyping: false), //
                              initVal: 1,
                              steps: 1,
                              minVal: 1,
                            ),
                          ],
                        ),
                        // ElevatedButton(
                        //     onPressed: debugquan, child: Text('hitme'))
                        Row(
                          mainAxisSize:
                              MainAxisSize.max, // Set width to full screen
                          mainAxisAlignment:
                              MainAxisAlignment.start, // Align left and right
                          crossAxisAlignment:
                              CrossAxisAlignment.end, // Align vertically
                          children: [
                            Transform.scale(
                              scale: 0.65,
                              child: RatingBar(
                                  minRating: 1,
                                  maxRating: 5,
                                  initialRating: 1,
                                  allowHalfRating: true,
                                  onRatingUpdate: savRating,
                                  ratingWidget: RatingWidget(
                                      full: Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      half: Icon(
                                        Icons.star_half,
                                        color: Colors.amber,
                                      ),
                                      empty: Icon(
                                        Icons.star,
                                        color: const Color.fromARGB(
                                            255, 119, 119, 119),
                                      ))),
                            ),
                            Text(''),
                          ],
                        ),
                        Card(
                          // Other Card properties like elevation, shape, etc.
                          child: Padding(
                            padding: EdgeInsets.all(
                                0.1), // Adjust the padding value as needed
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Border radius of 2
                                border: Border.all(
                                  color: Colors.green, // Green border color
                                  width:
                                      1.0, // Border width of 1 pixel (optional)
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(
                                    4), // Adjust padding as needed
                                child: Text(
                                  '${widget.bike.description}',
                                  style: GoogleFonts.getFont('Poppins'),
                                ),
                              ),
                            ),
                            // Replace with your content widget
                          ),
                        ),

                        Row(
                          mainAxisSize:
                              MainAxisSize.max, // Set width to full screen
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Align left and right
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Align vertically
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0.4, 0, 0.4, 4),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Total',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        height: 1.4,
                                        color: Color(0xFF555555),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'VND: ${outputPrice}',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    height: 1.4,
                                    color: Color(0xFF3C3C3C),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: addCart,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF43936C),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  width: 132,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0,
                                      vertical: 14), // Simplified padding
                                  child: Center(
                                    // Center the text
                                    child: Text(
                                      'Add Order',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        height:
                                            1.4, // Assuming this is line height
                                        color: Color(0xFFFEFEFE),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
