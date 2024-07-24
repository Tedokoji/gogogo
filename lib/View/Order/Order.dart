import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:gogogo/View/Home/Home_skele.dart';
import 'package:gogogo/View/Order/Cart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderCheckout extends StatefulWidget {
  final List<CartItem> items; // List of items in the order
  final String Total;
  const OrderCheckout({Key? key, required this.items, required this.Total})
      : super(key: key);

  @override
  State<OrderCheckout> createState() => _OrderCheckoutState();
}

class _OrderCheckoutState extends State<OrderCheckout> {
  String _shippingAddress = "";
  String _paymentMethod = "";
  String storeName = '';
  String purchaseDateTime = '';

  double subtotal = 0;
  double taxRate = 0; // Optional, set to 0.0 for no tax
  String footerMessage = '';
  // Functions to handle user input for shipping address and payment method

  void _onShippingAddressChange(String value) {
    setState(() {
      _shippingAddress = value;
    });
  }

  void _onPaymentMethodChange(String value) {
    setState(() {
      _paymentMethod = value;
    });
  }

  void _onConfirmOrder() {
    // Implement logic to confirm order with backend
    // ...
  }
  Future<void> gotoHistoryanddosmth() async {
    final currentUser = await getUserName();
    final ref = FirebaseDatabase.instance.ref('users/${currentUser}/History');

    final cartId = ref.push().key;

    // Update the Cart collection with unique ID
    await ref.child(cartId!).set({
      "Date": '${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}',
      "price": widget.Total,
      "address": _shippingAddress,
      "status": 'Chưa'
    });
    final reff = FirebaseDatabase.instance.ref();

    final snapshot = await reff.child('/users/${currentUser}/Cart/');
    await snapshot.remove();
    Fluttertoast.showToast(
      msg: "Đã Đặt Hàng!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeSKE()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Xác nhận mua hàng'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.green),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Order Summary section
              const SizedBox(height: 10.0),
              Text('${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.4,
                    color: Color.fromARGB(255, 70, 94, 49),
                  )),
              const Divider(thickness: 1.0),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: OrderSummary(items: widget.items)),
              const Divider(thickness: 1.0),
              Text('Địa chỉ giao hàng',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.4,
                    color: Color.fromARGB(255, 70, 94, 49),
                  )),
              Container(
                //name regis
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFD0D0D0)),
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFFFFFFF),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 1, 15, 13),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _shippingAddress = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Địa chỉ',
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
              // Shipping Information section

              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisSize: MainAxisSize.max, // Set width to full screen
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Align left and right
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Align vertically
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0.4, 0, 0.4, 4),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Tổng:  ',
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
                        '${widget.Total} VND',
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
                ],
              ),
              Container(
                // Position at the bottom edge
                child: GestureDetector(
                  onTap: () {
                    gotoHistoryanddosmth();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.green),
                        color: Colors.green),
                    // Adjust container height as needed
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: Center(
                      child: Text('Xác nhận',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 1.4,
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// This is just an example OrderSummary widget
class OrderSummary extends StatelessWidget {
  final List<CartItem> items;

  const OrderSummary({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate total price and other order details
    // ...

    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final cartItem = items[index];
        //totalPrice += cartItem.price;
        return Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(children: [
                Text('${cartItem.name}',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.4,
                      color: Color.fromARGB(255, 70, 94, 49),
                    )),
                Spacer(),
                Text('${cartItem.quantity}',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.4,
                      color: Color.fromARGB(255, 70, 94, 49),
                    )),
              ])
            ],
          ),
        );
      },
    );
  }
}
