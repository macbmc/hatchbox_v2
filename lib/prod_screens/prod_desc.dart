import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hatchbox_v2/func_screens/number_stepper.dart';
import 'package:hatchbox_v2/func_screens/support.dart';
import 'package:hatchbox_v2/prod_screens/HomeScreen.dart';
import 'package:hatchbox_v2/prod_screens/cart.dart';
import 'package:hatchbox_v2/prod_screens/prod_checkout.dart';
import 'package:hatchbox_v2/prod_screens/payement_page.dart';

import 'package:model_viewer_plus/model_viewer_plus.dart';
class DescPg extends StatefulWidget {
  const DescPg({Key? key,required this.modPath,
    required this.ImgPath,
    required this.rev1,
    required this.rev2,
    required this.ls,
    required this.ss,
    required this.status,
    required this.matter,
    required this.mrp,
    required this.price,
    required this.discount,

  }) : super(key: key);
  final String? ImgPath;
  final String? matter;
  final String? modPath,ls,ss,status,rev1,rev2;
  final int? mrp,price,discount;
  @override
  State<DescPg> createState() => _DescPgState();
}

class _DescPgState extends State<DescPg> {
  @override
  User user = FirebaseAuth.instance.currentUser!;
  var _selectedNumber = 0;
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 10.0,top: 10.0),
                  child: GestureDetector(
                    onTap: () {Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return UserCart();
                    }));},
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 26.0,
                    ),
                  )
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            title:Center(child: Text(widget.matter.toString(),style: TextStyle(color: Colors.black),)),
            leading: Padding(
              padding: EdgeInsets.only(left: 10.0,top: 10.0),
              child: SizedBox(
                height: 30,
                width: 30,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
                  onPressed: (){
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }));
                  },
                )
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        addtoWishList();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Added to wishlist"),
                        ));
                      },
                      child: Icon(
                        Icons.favorite_outline_rounded,
                        color: Colors.red,
                        size: 26.0,
                      ),
                    )
                  ],
                ),
                Container(
                  //color: Color.fromRGBO(220, 212, 220, 5),
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width/1.1,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: ModelViewer(
                    //backgroundColor: Colors.teal[50],
                    src: widget.modPath.toString() ,
                    alt: "A 3D model of an table soccer",
                    autoRotate: false,
                    autoPlay: false,
                    cameraControls: true,
                    ar: true,
                    disableZoom: true,
                    disablePan: true,
                    disableTap: true,
                    arPlacement: ArPlacement.floor,
                    arModes: ['scene-viewer', 'webxr', 'quick-look'],
                    arScale: ArScale.fixed,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: TabBar(
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    //unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(
                          child: Text("Price",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:15 ),),
                        ),
                        Tab(
                          child: Text("Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:15 ),),
                        ),
                        Tab(
                          child: Text("Reviews",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:15 ),),
                        ),
                      ],
                    ),
                ),
                Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.matter.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    Text("5 *",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                    child: Text("Status: ${widget.status.toString()} ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red),)),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10.0,right: 10.0),
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.blueGrey,
                                        width: 1,
                                      )
                                  ),
                                  child: Row(
                                    children: [
                                      Text("Rs.${widget.mrp.toString()} ",style: TextStyle(fontSize: 16,decoration: TextDecoration.lineThrough,color: Colors.grey),),
                                      Text("Rs.${widget.price.toString()} ",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),

                                      SizedBox(
                                        width: 30,
                                      ),
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
                                  ),
                                ),

                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        onPressed:(){
                                          addtoCart();
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text("Added to cart"),
                                          ));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.black,
                                        ),
                                        child: Text("Add To Cart")),
                                    ElevatedButton(
                                        onPressed:(){
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) {
                                            return PaymentScreen(img:widget.ImgPath.toString(),amount:int.parse(widget.price.toString()),name: widget.matter.toString(),num:_selectedNumber,);
                                          }));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.black
                                        ),
                                        child: Text("Buy Now")),
                                    ElevatedButton(
                                        onPressed:(){
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) {
                                            return Support(email:user.email, username: user.uid);
                                          }));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.black
                                        ),
                                        child: Text("Contact Seller")),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            margin: EdgeInsets.only(top: 10.0),
                            padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0,bottom: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.blueGrey,
                                  width: 1,
                                )
                            ),
                            child: Text("${widget.ls.toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(top: 30.0,left: 10.0,bottom: 50.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Colors.blueGrey,
                                              ),
                                              child: Image.asset('assets/logo.png',)
                                          ),
                                          SizedBox(width: 10,),
                                          Text("Robert D",style: TextStyle(fontSize: 15,color: Colors.black),)
                                        ]
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0)),
                                      elevation: 10.0,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          width: MediaQuery.of(context).size.width/1.3,
                                          height: 100,
                                          child:Text("${widget.rev1.toString()}")
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Colors.blueGrey,
                                              ),
                                              child: Image.asset('assets/logo.png',)
                                          ),
                                          SizedBox(width: 10,),
                                          Text("Anthon",style: TextStyle(fontSize: 15,color: Colors.black),)
                                        ]
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0)),
                                      elevation: 10.0,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          width: MediaQuery.of(context).size.width/1.3,
                                          height: 100,
                                          child:Text("${widget.rev2.toString()}")
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Colors.blueGrey,
                                              ),
                                              child: Image.asset('assets/logo.png',)
                                          ),
                                          SizedBox(width: 10,),
                                          Text("Tom Cruise",style: TextStyle(fontSize: 15,color: Colors.black),)
                                          //Text()
                                        ]
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0)),
                                      elevation: 10.0,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          width: MediaQuery.of(context).size.width/1.3,
                                          height: 100,
                                          child:Text("${widget.rev1.toString()}")
                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
  Future addtoCart()async{
    var currentuser = FirebaseAuth.instance.currentUser;
    CollectionReference _collectionref = FirebaseFirestore.instance.collection("user-cart");
    return _collectionref.doc(currentuser!.email).collection("Cart").doc(widget.matter)
        .set({
      // "id":widget.id,
      "model":widget.modPath,
      "name_prod":widget.matter,
      "price":widget.price,
      "image":widget.ImgPath,
      "discount":widget.discount,
      "mrp":widget.mrp,
      "long_desc":widget.ls,
      "short_desc":widget.ss,
      "rev1":widget.rev1,
      "rev2":widget.rev2,
      "status":widget.status
    }).then((value) => print("Added to cart "));

  }
  Future addtoWishList()async{
    var currentuser = FirebaseAuth.instance.currentUser;
    CollectionReference _collectionref = FirebaseFirestore.instance.collection("user-wishlist");
    return _collectionref.doc(currentuser!.email).collection("Cart").doc(widget.matter)
        .set({
      // "id":widget.id,
      "model":widget.modPath,
      "name_prod":widget.matter,
      "price":widget.price,
      "image":widget.ImgPath,
      "discount":widget.discount,
      "mrp":widget.mrp,
      "long_desc":widget.ls,
      "short_desc":widget.ss,
      "rev1":widget.rev1,
      "rev2":widget.rev2,
      "status":widget.status
    }).then((value) => print("Added to cart "));

  }
  Future addtoOrder() async{
    var currentuser = FirebaseAuth.instance.currentUser;
    CollectionReference _collectionref = FirebaseFirestore.instance.collection("user-order");
    return _collectionref.doc(currentuser!.email).collection("Orders").doc(widget.matter)
        .set({
      // "id":widget.id,
      "name_prod":widget.matter,
      "price":widget.price,
      "image":widget.ImgPath,
    }).then((value) => print("Added to cart "));

  }
}

