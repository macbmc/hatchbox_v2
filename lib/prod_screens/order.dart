import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hatchbox_v2/auth_screens/prof.dart';
import 'package:hatchbox_v2/prod_screens/cart.dart';
class Orderpg extends StatefulWidget {
  const Orderpg({Key? key}) : super(key: key);

  @override
  State<Orderpg> createState() => _OrderpgState();
}

class _OrderpgState extends State<Orderpg> {
  @override
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
                    "Shopping Orders",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return ProfPg();
                    }));}
                      , icon: Icon(Icons.home)),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width*0.1),
              SizedBox(
                height: MediaQuery.of(context).size.height*.6,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                    stream:FirebaseFirestore.instance.collection("user-order").doc(FirebaseAuth.instance
                        .currentUser!.email).collection("orders").snapshots(),
                    builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("Something Fishy"),);
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          DocumentSnapshot _item = snapshot.data!.docs[index];
                          if(snapshot.hasData) {
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
            ],
          ),
        ),
      ),
    );
  }
}

