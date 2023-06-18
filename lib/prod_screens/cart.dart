import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hatchbox_v2/prod_screens/HomeScreen.dart';
import 'package:hatchbox_v2/prod_screens/prod_desc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class UserCart extends StatefulWidget {
  const UserCart({Key? key}) : super(key: key);

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  double _total=0.0;
  double sum=0.0;
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                    ),
                    iconSize: 25,
                    color: Colors.brown,
                  ),
                  Text(
                    "Shopping Cart",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return HomeScreen();
                    }));}
                      , icon: Icon(Icons.home)),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width*0.1),
              SizedBox(
                height: MediaQuery.of(context).size.height*.6,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                    stream:FirebaseFirestore.instance.collection("user-cart").doc(FirebaseAuth.instance
                        .currentUser!.email).collection("Cart").snapshots(),
                    builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("Something Fishy"),);
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          DocumentSnapshot _item = snapshot.data!.docs[index];
                          if(snapshot.hasData) {
                            getData(_item['price'].toString());
                            sum=sum+double.parse(_item['price'].toString());
                            return Item_lister(ImgPath: _item['image'],
                              modPath: _item["model"],
                              discount: _item["discount"],
                              matter: _item["name_prod"],
                              price: _item["price"],
                              mrp: _item["mrp"],
                              ls: _item["long_desc"],
                              ss: _item["short_desc"],
                              rev1: _item["rev1"],
                              rev2: _item["rev2"],
                              status: _item["status"],);
                          }
                          else{
                            return Text("Nothing in the cart lol -_-");
                          }
                        },
                      );
                    }


                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Colors.black,
                  child: Column(
                    children: [
                     /* Text("SubTotal: \t  $sum",style:
                      TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'ArchitypeRenner-Bold',color: Colors.white),),*/
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        width:MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed:(){

                              var options = {
                                "key": "rzp_test_WCDhsV9GQgaKsf",
                                "amount": _total*100,
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  getData(String price)
  {
    double _tprice=0.0;
    _tprice=_tprice + double.parse('$price');

    _total=_total+_tprice;
    


  }

}
class Item_lister extends StatelessWidget {

  const Item_lister({Key? key,
    required this.modPath,
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
    //required this.id
  }) : super(key: key);
  final String? ImgPath;
  final String? matter;
  final String? modPath,ls,ss,status,rev1,rev2;
  final int? mrp,price,discount;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DescPg(
                modPath: modPath,
                ImgPath: ImgPath,
                matter: matter,
                ls: ls,
                ss: ss,
                status: status,
                mrp: mrp,
                price: price,
                rev1: rev1,
                rev2: rev2,
                discount: discount,
              )));
        },
        child: Container(
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(blurRadius: 25.0)],
            color: Colors.white,
          ),
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.network(
                ImgPath!,
                width: 160,
                height: 150,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Expanded(
                        child: ListView(children: [
                          Text(
                            matter!,
                            style:
                            TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'ArchitypeRenner-Bold'),
                          ),
                        ])),
                    Row(
                      children: [
                        Text(r"₹"),
                        Text(
                          mrp!.toString(),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          price!.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "You have saved ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          discount!.toString(),
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "%",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
