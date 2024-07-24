import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:gogogo/View/Home/Home_skele.dart';
import 'package:gogogo/View/Order/HisToryBuild.dart';

class HistoryItem {
  final String date;
  final String address;
  final String price;
  final String status;
  final String id;

  const HistoryItem({
    required this.date,
    required this.address,
    required this.price,
    required this.status,
    required this.id,
  });
}

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<HistoryItem> _cartItems = [];
  bool isadmin = false;
  void initState() {
    super.initState();
    _fetchHisItems(); // Fetch data on widget initialization
  }
  Future<void> onClose(String id) async {
    final ref = FirebaseDatabase.instance.ref();
    final currentUser = await getUserName();

    await ref.child('users/${currentUser}/History/$id').remove();
    setState(() {
      
    });
  }
  void onCheck(){

  }
  Future<List<HistoryItem>> _fetchHisItems() async {
    final ref = FirebaseDatabase.instance.ref();
    final currentUser = await getUserName();
    final snapshot = await ref.child('/users/${currentUser}/History').get();
    try {
      final data = await snapshot.value as Map<dynamic, dynamic>;
      _cartItems = data.entries.map((entry) {
        // var price = entry.value['price'] as int;
        // if (totalPrice != null) {
        //   totalPrice = totalPrice + price;
        // }
        return HistoryItem(
            date: entry.value['Date'] as String,
            address: entry.value['address'] as String,
            price: entry.value['price'] as String,
            status: entry.value['status'] as String,
            id: entry.key as String);
      }).toList();
      // Update UI when data is fetched
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeSKE()),
      );
    }
    var isaddddminnn = await ref.child('users/${currentUser}/admin').get();
    isadmin = isaddddminnn.value as bool ?? false;
    return _cartItems;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HistoryItem>>(
        future: _fetchHisItems(), // Your function to fetch cart items
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Fluttertoast.showToast(
              msg: "Không có Lịch sử mua hàng, đăt hàng ngay!",
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
                  title: const Text('Lịch sử mua hàng'), // Title: Cart
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () =>
                        Navigator.pop(context), // Handle back button press
                  ),
                  backgroundColor:
                      Colors.white, // Set white background for app bar
                ),
                body: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];

                    //totalPrice += cartItem.price;
                    return HistoryView(
                      date: cartItem.date,
                      address: cartItem.address,
                      price: cartItem.price,
                      status: cartItem.status,
                      id: cartItem.id,
                      isAdmin: isadmin,
                      onCheck: onCheck,
                      onClose:(id)=> onClose(id),
                    );
                  },
                ));
          }
          return Center(child: CircularProgressIndicator());
        }
        // Add content or other widgets inside the container here
        );
  }
}
// Container(
//                     margin: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.green),
//                         borderRadius: BorderRadius.circular(10)),
//                     padding: EdgeInsets.all(1),
//                     width: double.infinity,
//                     height: 120.0,
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10.0),
//                           child: Image.network(
//                             '${product.thumb}',
//                             // Optional properties
//                             fit: BoxFit
//                                 .contain, // Adjust fit as needed (e.g., BoxFit.fill, BoxFit.contain)
//                             loadingBuilder: (context, child, loadingProgress) {
//                               if (loadingProgress == null) return child;
//                               return Center(child: CircularProgressIndicator());
//                             },
//                             errorBuilder: (context, error, stackTrace) {
//                               return Center(child: Text('Error loading image'));
//                             },
//                           ),
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('${product.name}',
//                                     style: GoogleFonts.getFont(
//                                       'Poppins',
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 14,
//                                       height: 1.4,
//                                       color: Color.fromARGB(255, 70, 94, 49),
//                                     )),
//                                 Text(
//                                   '${product.description}',
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )