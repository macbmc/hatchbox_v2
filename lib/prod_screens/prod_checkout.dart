import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatchbox_v2/func_screens/number_stepper.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckPg extends StatefulWidget {
  const CheckPg({Key? key}) : super(key: key);

  @override
  State<CheckPg> createState() => _CheckPgState();
}

class _CheckPgState extends State<CheckPg> {
  var _selectedNumber = 0;
  late Razorpay _razorpay;
  final couponController = TextEditingController();
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
                        "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        fit: BoxFit.contain,
                        width: 150,
                        height: 100,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 20,),
                        Text("Soft Chair White",style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey),),
                        Text("Rs.12000",style: TextStyle(
                            fontSize: 18,
                            color: Colors.black),),
                        NumberStepper(
                          initialValue: _selectedNumber,
                          min: 1,
                          max: 5,
                          step: 1,
                          onChanged: (value){
                            setState(() {
                              _selectedNumber = value;
                            });
                          },
                        ),
                      ],
                    )

                  ],
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
                     Text("10000",style: TextStyle(
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
                     Text("20",style: TextStyle(
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
                     Text("10020",style: TextStyle(
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
                  onPressed:(){},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black
                  ),
                  child: Text("Checkout",style: TextStyle(fontSize: 20),)),

            )
            ]
        ),
      ),
    );
  }
}

/*
class CartProd extends StatelessWidget {
  @override
  double tprice = 0.0;
  String ImgPath,id;

  // ignore: use_key_in_widget_constructors
  CartProd({

    // ignore: non_constant_identifier_names
    required this.ImgPath,
    required this.title,
    //required this.discount,
    required this.mrp,
    required this.price,
    //required this.cat,
    required this.ls,
    required this.instock,
    //required this.short_description,
    required this.rev,
    required this.rev1,
    required this.rev2,
    required this.id
  });

  String title;
  String rating;
  String mrp;
  double price;
  int num;
  bool instock;
  String ls;
  String rev;
  String rev1;
  String rev2;
  // ignore: empty_constructor_bodies

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
      child: Stack(children: [
        GestureDetector(
          onTap: () {},
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            elevation: 10.0,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    "ImgPath",
                    fit: BoxFit.contain,
                    width: 200,
                    height: 95,
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ListView(children: [
                              Text(
                                "name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.brown),
                              ),
                            ])),
                        Row(
                          children: [
                            Text(r"₹"),
                            Text(
                              "mrp",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text(r"₹", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),
                                Text(
                                  "your_price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.red),
                                ),


                                SizedBox(width: 100,),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .all(Colors.brown),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0),
                                          side: BorderSide(
                                            color: Colors.white,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text("Remove",
                                      style: TextStyle(fontSize: 20),)),

                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
*/
