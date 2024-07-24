import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:gogogo/View/Details/PlusMinusBtn.dart';
import 'package:gogogo/View/Order/CartItem.dart';
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
    return _cartItems;
  }

  void _DelCartItems(String id) async {
    final ref = FirebaseDatabase.instance.ref();

    final snapshot = await ref.child('/users/${widget.currentUser}/Cart/${id}');
    await snapshot.remove();
  }

  int calculateTotalPrice(List<CartItem> cartItems) {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CartItem>>(
      future: _fetchCartItems(), // Your function to fetch cart items
      builder: (context, snapshot) {
        if (snapshot.hasError) {
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

class CartItemView extends StatelessWidget {
  final String name;
  final int price;
  final int quantity;
  final String url;
  final String keyid;
  
  CartItemView(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.url,
      required this.keyid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ProDetails(
        //             bike: product,
        //           )),
        // )
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(1),
        width: double.infinity,
        height: 120.0,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                '${url}',
                // Optional properties
                fit: BoxFit
                    .contain, // Adjust fit as needed (e.g., BoxFit.fill, BoxFit.contain)
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('Error loading image'));
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${name}',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.4,
                          color: Color.fromARGB(255, 70, 94, 49),
                        )),
                    Text(
                      '${price} VND',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(children: [
                      Text(
                        'Số lượng ${quantity}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          
                          
                          // Implement logic to handle trash icon button press
                          // This might involve removing the item from the cart
                          // or triggering another action based on your app's functionality
                        },
                      )
                    ]),
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
