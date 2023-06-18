import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hatchbox_v2/auth_screens/prof.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hatchbox_v2/func_screens/search.dart';
import 'package:hatchbox_v2/main.dart';
import 'package:hatchbox_v2/prod_screens/cart.dart';
import 'package:hatchbox_v2/prod_screens/itemsdisp.dart';
import 'package:hatchbox_v2/prod_screens/offerzone.dart';
import 'package:hatchbox_v2/prod_screens/wish.dart';
import 'package:hatchbox_v2/prod_screens/prod_desc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  int sindex = 0;
  @override

  final List<Widget> screens = [
    HomeScreenPG(),
    Wishpg(),
    UserCart(),
    ProfPg(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.white.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.white,
                tabs: [
                  GButton(
                    iconColor: Colors.white,
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    iconColor: Colors.white,
                    icon: Icons.favorite,
                    text: 'Wish',
                  ),
                  GButton(
                    iconColor: Colors.white,
                    icon: Icons.shopping_basket_outlined,
                    text: 'Shop Cart',
                  ),
                  GButton(
                    iconColor: Colors.white,
                    icon: Icons.accessibility_rounded,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: sindex,
                onTabChange: (index) {
                  setState(() {
                    sindex = index;
                  });
                },
              ),
            ),
          ),
        ),
        body:screens[sindex]
    );
  }
}
class HomeScreenPG extends StatefulWidget {
  const HomeScreenPG({Key? key}) : super(key: key);

  @override
  State<HomeScreenPG> createState() => _HomeScreenPGState();
}

class _HomeScreenPGState extends State<HomeScreenPG> {
  String data="Sample";
 GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child:Scaffold(
            key: _scaffoldKey,
            /*drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color:Colors.black),
                    accountName: Text(
                      "Elixir",
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
                    title: Text('Data1'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.train,
                    ),
                    title: Text('Data2'),
                    onTap: () {},
                  ),
                ],
              ),
            ),*/
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.blueGrey,
                              ),
                              child: Image.asset('assets/logo.png',width: 10,height: 10,)
                          ),

                              GestureDetector(
                                onTap: (){Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return Search();
                                }));},
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          /*Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) {
                                            return Search();
                                          }));*/
                                        }, icon: Icon(Icons.search_rounded)),
                                    Text("Search",style: TextStyle(
                                        color: Colors.black, fontSize:15, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )


                        ],
                      ),
                      SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                             child: Row(
                                children: [
                                  OfferZone(
                                        ImgPath: "assets/img10.jpg",
                                        matter: "Couches \n 20% off"),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  OfferZone(
                                      ImgPath: "assets/img2.jpg",
                                      matter: "Chairs \n 15% off"),
                                  OfferZone(
                                      ImgPath: "assets/img3.jpg",
                                      matter: "Wardrobes \n 20% off"),
                                ],
                              ),
                          ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Itemdisp(
                                  cat: "Home Decor",
                                );
                              }));
                            },
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
                                width: MediaQuery.of(context).size.width * .2,
                                height: 80,
                                child: Center(
                                  child: Icon(Icons.table_bar_rounded,
                                      size: 35, color: Colors.brown),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Itemdisp(
                                  cat: "Living room furniture",
                                );
                              }));
                            },
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
                                width: MediaQuery.of(context).size.width * .2,
                                height: 80,
                                child: Center(
                                  child: Icon(
                                    Icons.chair,
                                    size: 35,
                                    color: Colors.brown,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Itemdisp(
                                  cat: "Clothing & Accessories",
                                );
                              }));
                            },
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
                                width: MediaQuery.of(context).size.width * .2,
                                height: 80,
                                child: Center(
                                  child: Icon(Icons.table_rows_outlined,
                                      size: 35, color: Colors.brown),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Itemdisp(
                                  cat: "decor",
                                );
                              }));
                            },
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
                                width: MediaQuery.of(context).size.width * .2,
                                height: 80,
                                child: Center(
                                  child: Icon(
                                      Icons.warehouse_outlined,
                                      size: 35,
                                      color: Colors.brown),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      /*SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height/5,
                              width: MediaQuery.of(context).size.width*3,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("items")
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text(
                                          "Some Unknown Error has occured please try again");
                                    }
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (_, index) {
                                        DocumentSnapshot _snap =
                                        snapshot.data!.docs[index];
                                        return RoundBox(
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
                      ),*/
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Best Seller",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return OfferPg();
                              }));
                            },
                            child: Row(
                              children: [
                                Text("View",),
                                Icon(Icons.arrow_right_alt)
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
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
                      SizedBox(
                        height: 15,
                      ),
                      /*SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Items(
                              ImgPath: "assets/img9.png",
                              matter: "Arm Chair",
                              price: 9000,
                            ),
                            Items(
                              ImgPath: "assets/img9.png",
                              matter: "Arm Chair",
                              price: 9000,
                            )
                          ],
                        ),
                      ),*/
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
          ),

        );


  }


  Future _signOut() async {
    await FirebaseAuth.instance.signOut().then((value){
      {Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return HomePage();
      }));}
    });
    //User user = FirebaseAuth.instance.currentUser!;
  }
  /*Future addtoCart()async{
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

  }*/

}

class OfferZone extends StatelessWidget {
  final String? ImgPath;
  final String? matter;
  const OfferZone({Key? key, this.ImgPath, this.matter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) {
          return OfferPg();
        }));
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 30,
            left: 30),
        height: MediaQuery.of(context).size.height * .4,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            //color: Colors.grey[200],
            // border: Border.all(color: Colors.white),
            image: DecorationImage(
                image: AssetImage(
                  ImgPath!,
                ),
                fit: BoxFit.fill)),
        child: Text(
          matter!,
          style: TextStyle(
              color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class RoundBox extends StatelessWidget {
  final String? ImgPath;
  final String? matter;
  final String? modPath,ls,ss,status,rev1,rev2;
  final int? mrp,price,discount;
  const RoundBox({Key? key, this.ImgPath, this.matter,this.modPath,this.ls,this.ss,this.status,this.mrp,this.price,this.rev1,this.rev2,this.discount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DescPg(modPath: modPath,ImgPath: ImgPath,matter: matter,ls: ls,ss: ss,status: status,mrp: mrp,price: price,rev1: rev1,rev2: rev2,discount: discount,)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width/4,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Color.fromRGBO(46, 27, 18, 255)),
                  
              ),
              child: Image.network(ImgPath!),
            ),
            Text(
              matter.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: 'ArchitypeRenner-Bold'),
            ),
          ],
        ),
      ),
    );
  }

}

class Items extends StatelessWidget {
  final String? ImgPath;
  final String? matter;
  final String? modPath,ls,ss,status,rev1,rev2;
  final int? mrp,price,discount;
  const Items({Key? key, this.ImgPath, this.matter,this.modPath,this.ls,this.ss,this.status,this.mrp,this.price,this.rev1,this.rev2,this.discount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DescPg(modPath: modPath,ImgPath: ImgPath,matter: matter,ls: ls,ss: ss,status: status,mrp: mrp,price: price,rev1: rev1,rev2: rev2,discount: discount,)));
    },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: Colors.grey[200],
          height: MediaQuery.of(context).size.height*0.3,
          padding: EdgeInsets.only(top: 10,bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.15,
                width: MediaQuery.of(context).size.width*.45,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Color.fromRGBO(46, 27, 18, 255)),
                    image: DecorationImage(
                      image: NetworkImage(ImgPath!),
                      fit: BoxFit.cover
                    ),
                ),
                child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed:(){
                          addtoWishList();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Added to Wishlist"),
                          ));
                        },
                        icon: Icon(
                          Icons.favorite_outline_rounded,
                        ))),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    matter!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'ArchitypeRenner-Bold'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    price!.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'ArchitypeRenner-Bold'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future addtoWishList() async{
    var currentuser = FirebaseAuth.instance.currentUser;
    CollectionReference _collectionref = FirebaseFirestore.instance.collection("user-wishlist");
    return _collectionref.doc(currentuser!.email).collection("Cart").doc(matter)
        .set({
      // "id":widget.id,
      "model":modPath,
      "name_prod":matter,
      "price":price,
      "image":ImgPath,
      "discount":discount,
      "mrp":mrp,
      "long_desc":ls,
      "short_desc":ss,
      "rev1":rev1,
      "rev2":rev2,
      "status":status
    }).then((value) => print("Added to cart "));

  }
}


/*drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color:Colors.black),
                    accountName: Text(
                      "Elixir",
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
                    title: Text('Data1'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.train,
                    ),
                    title: Text('Data2'),
                    onTap: () {},
                  ),
                ],
              ),
            ),*/