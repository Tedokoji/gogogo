import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:gogogo/View/Accounts/Account.dart';
import 'package:gogogo/View/Details/PlusMinusBtn.dart';
import 'package:gogogo/View/Home/Home_skele.dart';
import 'package:gogogo/View/Order/CartItem.dart';
import 'package:gogogo/View/Order/Order.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_quantity/input_quantity.dart';

class CartItem {
  final String name;
  final int price;
  int quantity;
  String url;
  String id;
  CartItem(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.url,
      required this.id});
  Map<String, dynamic> toJson() =>
      {'name': name, 'price': price, 'quantity': quantity, 'urel': url};
}

class Cart extends StatefulWidget {
  final String currentUser;
  const Cart({super.key, required this.currentUser});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  // Assuming getUserName() is defined elsewhere
  List<CartItem> _cartItems = []; // Private state variable

  @override
  void initState() {
    super.initState();
    _fetchCartItems(); // Fetch data on widget initialization
  }

  int totalPrice = 0;

  int _currentQuantity = 1;
  void changeQuan(var val) {
    setState(() {
      _currentQuantity = val;
    });
  }

  Future<List<CartItem>> _fetchCartItems() async {
    final ref = FirebaseDatabase.instance.ref();

    final snapshot = await ref.child('/users/${widget.currentUser}/Cart').get();
    try {
      final data = await snapshot.value as Map<dynamic, dynamic>;
      _cartItems = data.entries.map((entry) {
        // var price = entry.value['price'] as int;
        // if (totalPrice != null) {
        //   totalPrice = totalPrice + price;
        // }
        return CartItem(
            name: entry.value['name'] as String,
            price: entry.value['price'] as int,
            quantity: entry.value['quantity'] as int,
            url: entry.value['url'] as String,
            id: entry.key as String);
      }).toList();
      // Update UI when data is fetched
      totalPrice = calculateTotalPrice(_cartItems);
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeSKE()),
      );
    }

    return _cartItems;
  }

  int calculateTotalPrice(List<CartItem> cartItems) {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }

  void _DelCartItems(String id) async {
    final ref = FirebaseDatabase.instance.ref();

    final snapshot = await ref.child('/users/${widget.currentUser}/Cart/${id}');
    await snapshot.remove();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CartItem>>(
      future: _fetchCartItems(), // Your function to fetch cart items
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Fluttertoast.showToast(
            msg: "Không có sản phẩm nào trong giỏ!",
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

          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          final cartItems = snapshot.data!; // Safe access after null check

          return Scaffold(
              appBar: AppBar(
                title: const Text('Giỏ hàng'), // Title: Cart
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () =>
                      Navigator.pop(context), // Handle back button press
                ),
                backgroundColor:
                    Colors.white, // Set white background for app bar
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        //totalPrice += cartItem.price;
                        return CartItemView(
                          name: cartItem.name,
                          price: cartItem.price,
                          quantity: cartItem.quantity,
                          url: cartItem.url,
                          keyid: cartItem.id,
                          Del: (asd) => _DelCartItems(cartItem.id),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.green), // Green border
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng tiền: ${totalPrice} vnd', // Total price
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle "đặt hàng" (Order) button press
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderCheckout(
                                        items: cartItems,
                                        Total: '$totalPrice',
                                      )),
                            );

                            // Implement your order logic here
                          },
                          child: const Text('Đặt hàng'), // Order
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Green button
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        }

        // Display a loading indicator while fetching data

        // Display a loading indicator while fetching data
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
