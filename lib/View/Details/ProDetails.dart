import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gogogo/View/Details/PlusMinusBtn.dart';
import 'package:gogogo/View/Home/AutoCarousel.dart';
import 'package:gogogo/View/LogReg/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_quantity/input_quantity.dart';

class ProDetails extends StatefulWidget {
  //final Map<String, dynamic> productData; // Data about the product

  const ProDetails({
    Key? key,
  }) : super(key: key);
//required this.productData
  @override
  _ProDetailsState createState() => _ProDetailsState();
}

class _ProDetailsState extends State<ProDetails> {
  @override
  Widget build(BuildContext context) {
    // final String name = widget.productData['name']; // Accessing data from parent
    // final String description = widget.productData['description'];
    // final double price = widget.productData['price'];

    int _currentQuantity = 1;
    void savRating(double) {}

    void debugquan() {
      print(_currentQuantity);
    }

    List<Widget> carouselItems = [
      // Your carousel item widgets here
      Image(
        image: AssetImage('assets/images/bike.png'),
        fit: BoxFit.contain,
      ),

      Image(
        image: AssetImage('assets/images/bike.png'),
        fit: BoxFit.contain,
      )
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
              child: AutoSwipeCarousel(
                children: carouselItems,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0), // Shrink 30px left and right
            decoration: BoxDecoration(
              border: Border.all(color: greyColor),
            ),
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
                              'bicycle', //cate
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
                              'title',
                              style: TextStyle(
                                  fontSize: 16.0), // Adjust font size as needed
                            ),
                            Text(
                              'price',
                              style: TextStyle(
                                  fontSize: 16.0), // Adjust font size as needed
                            ),
                          ],
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
                              '',
                              style: TextStyle(
                                  fontSize: 16.0), // Adjust font size as needed
                            ),
                            InputQty.int(
                              onQtyChanged: (val) {
                                _currentQuantity = val;
                              },
                              initVal: 0,
                              steps: 1,
                              minVal: 0,
                            ),
                          ],
                        ),
                        // ElevatedButton(
                        //     onPressed: debugquan, child: Text('hitme'))
                        Row(
                          mainAxisSize:
                              MainAxisSize.max, // Set width to full screen
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Align left and right
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Align vertically
                          children: [
                            RatingBar(
                                minRating: 1,
                                maxRating: 5,
                                initialRating: 3,
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
                                    2.0), // Border radius of 2
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
                                  'DAISJDASDPASDASDASDSRTHBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',
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
                            Text(
                              'title',
                              style: TextStyle(
                                  fontSize: 16.0), // Adjust font size as needed
                            ),
                            Text(
                              'price',
                              style: TextStyle(
                                  fontSize: 16.0), // Adjust font size as needed
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
