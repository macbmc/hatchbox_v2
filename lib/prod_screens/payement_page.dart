// ignore_for_file: sized_box_for_whitespace, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hatchbox_v2/auth_screens/prof.dart';
import 'package:hatchbox_v2/func_screens/number_stepper.dart';
import 'package:flutter/material.dart';
import 'package:hatchbox_v2/func_screens/support.dart';
import 'package:hatchbox_v2/prod_screens/HomeScreen.dart';
import 'package:hatchbox_v2/prod_screens/cart.dart';
import 'package:hatchbox_v2/prod_screens/prod_desc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key,required this.name,required this.amount,required this.num,required this.img}) : super(key: key);
final int amount;
final int num;
final String img;
final String name;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var _selectedNumber = 0;
  User user = FirebaseAuth.instance.currentUser!;
  String email="";
  int subt = 0;
  int tot=0;
  final GlobalKey<FormState> _formkey = GlobalKey();
  late TextEditingController _amountController;
  late Razorpay _razorpay;
  final couponController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void handlerPaymentSuccess() {
    print("payment success");
  }

  void handlerErrorFailure() {
    print("payment failed");
  }

  void handlerExternalWallet() {
    print("External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 10.0,top: 10.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                  size: 26.0,
                ),
              )
          ),
        ],

        backgroundColor: Colors.white,
        elevation: 1,
        title:Center(child: Text("Order",style: TextStyle(color: Colors.black),)),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color:Colors.black),
              accountName: Text(
                "HatchBOX",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "elixir1001@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text("HOMESCREEN"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.man,
              ),
              title: Text("PROFILE"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProfPg();
                }));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_basket_outlined,
              ),
              title: Text("CART"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return UserCart();
                }));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.call,
              ),
              title: Text("GRIEVEINCES"),
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Support(email: user.email, username: user.uid);
                }));
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.0,right: 20.0),
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                child: Stack(children: [
                  GestureDetector(
                    onTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 10.0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 210,
                          //width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Image.network(
                                  widget.img,
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 100,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(height: 20,),
                                  Text(widget.name,style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blueGrey),),
                                  Text(widget.amount.toString(),style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black),),
                                  Text("Quantity: ${widget.num.toString()}",style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black),),
                                  /*NumberStepper(
                                    initialValue: _selectedNumber,
                                    min: 1,
                                    max: 5,
                                    step: 1,
                                    onChanged: (value){
                                      setState(() {
                                        _selectedNumber = value;
                                      });
                                    },
                                  ),*/
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      controller: couponController,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        hintText: 'Promo Code',
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(20.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed:(){},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black
                      ),
                      child: Text("Apply Now")),

                ],
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 1,
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("SubTotal:",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black),),
                        Text("${widget.amount*widget.num}",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Delivery Charge:",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black),),
                        Text("Free",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black),)
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0,right: 10.0),
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.blueGrey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Total:",style: TextStyle(
                            fontSize: 20,
                            color: Colors.black),),
                        Text("${widget.amount*widget.num}",style: TextStyle(
                            fontSize: 20,
                            color: Colors.black),)
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                width:MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed:(){
                      var options = {
                        "key": "rzp_test_WCDhsV9GQgaKsf",
                        "amount": widget.amount*widget.num*100,
                        "name": "HatchBox",
                        "description": "Product Payment",
                        "prefill": {
                          "contact": "7306548414",
                          "email": "elixirtech1001@gmail.com"
                        },
                        "external": {
                          "wallets": ["paytm"]
                        },
                      };
                      try {
                        _razorpay.open(options);
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black
                    ),
                    child: Text("Checkout",style: TextStyle(fontSize: 20),)),

              )
            ]
        ),
      ),
      /*body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            "Do Payment Here",
                            style: TextStyle(fontSize: 21),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: _amountController,
                              decoration: const InputDecoration(
                                  hintText: "Enter amount"),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Please Enter Amount";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            onPressed: () {
                              if (!_formkey.currentState!.validate()) {
                                return;
                              }
                              _formkey.currentState!.save();
                              var options = {
                                "key": "rzp_test_WCDhsV9GQgaKsf",
                                "amount": num.parse(_amountController.text) * 100,
                                "name": "HatchBox",
                                "description": "Product Payment",
                                "prefill": {
                                  "contact": "7306548414",
                                  "email": "elixirtech1001@gmail.com"
                                },
                                "external": {
                                  "wallets": ["paytm"]
                                },
                              };
                              try {
                                _razorpay.open(options);
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                            child: const Text("Pay Now"),
                          )
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      ),*/
    );
  }



}