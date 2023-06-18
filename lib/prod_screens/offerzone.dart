import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatchbox_v2/prod_screens/HomeScreen.dart';
import 'package:hatchbox_v2/prod_screens/cart.dart';
class OfferPg extends StatefulWidget {
  const OfferPg({Key? key}) : super(key: key);

  @override
  State<OfferPg> createState() => _OfferPgState();
}

class _OfferPgState extends State<OfferPg> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.grey,
                        ),
                        iconSize: 30,
                        onPressed:(){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                        },
                    ),
                    Text(
                      "Offer Zone",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: 'ArchitypeRenner-Bold'),
                    ),
                    IconButton(
                        onPressed:(){Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return UserCart();
                        }));},
                        icon: Icon(
                          Icons.shopping_basket_outlined,
                        ),
                    iconSize: 30,
                    )
                  ],
                ),
                SizedBox(height: 20,),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*1.5,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("home_screen")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    "Some Unknown Error has occured please try again");
                              }
                              return GridView.builder(
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5.0,
                                    mainAxisSpacing: 50.0
                                ), //(MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3),
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, index) {
                                  DocumentSnapshot _snap =
                                  snapshot.data!.docs[index];
                                  return Items(
                                    ImgPath: _snap['image'].toString(),
                                    matter: _snap['name'].toString(),
                                    modPath: _snap['model'].toString(),
                                    ls: _snap['long_description'].toString(),
                                    discount:_snap['discount'],
                                    mrp:_snap['mrp'],
                                    rev1:_snap['rev1'].toString(),
                                    rev2:_snap['rev2'].toString(),
                                    ss:_snap['short_description'].toString(),
                                    status:_snap['status'].toString(),
                                    price:_snap['your_price'],
                                  );
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
