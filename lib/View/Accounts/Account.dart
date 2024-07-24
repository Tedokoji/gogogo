import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:gogogo/View/Accounts/Admin.dart';
import 'package:gogogo/View/Accounts/ConfirmDel.dart';
import 'package:gogogo/View/Accounts/EditAcc.dart';
import 'package:gogogo/View/LogReg/Login.dart';
import 'package:gogogo/View/Order/Cart.dart';

class Account extends StatefulWidget {
  final String number;
  final String proName;
  final String proURL;

  const Account(
      {Key? key,
      required this.number,
      required this.proName,
      required this.proURL})
      : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  // Sample account info
  final String _name = 'John Doe';
  bool _showPopup = false;
  // Explicit type

  String _inputText = "";
  // DatabaseReference ref = FirebaseDatabase
  //                                       .instance
  //                                       .ref("users/${name}");
  List<CartItem> items = [];
  //                                   print('clciked db rel');

  //                                   await ref.update({
  //                                     "Phonenum": "${number}",
  //                                     "ProName": "${name}",
  //                                     "proURL": "${url}",
  //                                   });
  void _togglePopup() {
    setState(() {
      _showPopup = !_showPopup;
    });
  }

  void _onTextChanged(String text) {
    setState(() {
      _inputText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài khoản'),
      ),
      body: SingleChildScrollView(
        // Allow scrolling if content overflows
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Profile picture section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: widget.proURL != null && widget.proURL != ''
                        ? Image.network(
                            widget.proURL, // Use null safety operator (!)
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                SizedBox(
                              // Show placeholder widget on error
                              width: 100.0,
                              height: 100.0,
                              child: Center(
                                  child: Icon(Icons
                                      .error)), // Or display a custom error icon
                            ),
                          )
                        : Image.asset(
                            'assets/images/bike.png', // Replace with your asset path
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
              SizedBox(height: 20.0), // Add some spacing

              // Account name
              Text(
                '${widget.proName}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget.number}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0), // Add some spacing

              // Settings list
              ListView.builder(
                shrinkWrap: true, // Prevent list from expanding unnecessarily
                itemCount: _settingsList.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<bool>(
                    future: getIsAdmin(),
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return ListTile(
                        title: Text(_settingsList[index]),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () async {
                          if (index == 0) {
                            final user = await getUserName();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cart(
                                  currentUser: user, 
                                  
                                ),
                              ),
                            );
                          }
                          if (index == 1) {
                            final user = await getUserName();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfile(id : user),
                              ),
                            );
                          }
                          if (index == 2) {
                            if(!snapshot.data!) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  Admin(),
                              ),
                            );
                          }
                          if (index == 4) {
                            clearUserLogin();
                      
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }
                          if (index == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmationPage(),
                              ),
                            );
                          }
                        }, // Add your action
                      );
                    }
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sample settings list
  final List<String> _settingsList = [
    'Giỏ hàng',
    'Tùy chỉnh thông tin',
    'Chức năng admin',
    'Xóa tài khoản',
    'Đăng xuất',
  ];
}
