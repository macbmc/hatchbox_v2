import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hatchbox_v2/auth_screens/datab.dart';
import 'package:hatchbox_v2/func_screens/support.dart';
import 'package:hatchbox_v2/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatchbox_v2/prod_screens/HomeScreen.dart';
import 'package:hatchbox_v2/prod_screens/order.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
class ProfPg extends StatefulWidget {
  const ProfPg({Key? key}) : super(key: key);

  @override
  State<ProfPg> createState() => _ProfPgState();
}

class _ProfPgState extends State<ProfPg> {
  User user = FirebaseAuth.instance.currentUser!;
  String? ImgPath, name,phno, email,pin,pass;
  Future getData()async{
    final DocumentSnapshot userDoc =await FirebaseFirestore.instance.collection("user-info").doc(user.uid).get();
    final _ImgPath=userDoc.get("image").toString();
    final _name=userDoc.get("name").toString();
    final _phno=userDoc.get("phoneno").toString();
    final _email=userDoc.get("email").toString();
    final _pin=userDoc.get("pincode").toString();
    final _pass=userDoc.get("pass").toString();
    setState(() {
      ImgPath=_ImgPath;
      name=_name;
      phno=_phno;
      email=_email;
      pin=_pin;
      pass=_pass;
    });
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                right: -30,
                child: Container(
                  height: 550,
                  width: MediaQuery.of(context).size.width * 1.2,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(220, 212, 211, 1),
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(250))),
                ),
              ),
              Positioned(
                right: -30,
                child: Container(
                  height: 350,
                  width: MediaQuery.of(context).size.width * 1.2,
                  decoration: const BoxDecoration(
                    //color: Color.fromRGBO(210, 65, 133, 1),
                      color: Colors.brown,
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(500))),
                ),
              ),
              Container(
                //color: Colors.white,
                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: IconButton(onPressed:(){
                        Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                       return HomeScreen();
                                    }));
                           },
                            icon:Icon(
                              Icons.arrow_back_ios_outlined,
                            ),
                            iconSize: 30,
                            color: Colors.white,),
                        ),
                        Text("Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                        IconButton(
                          icon: Icon(
                            Icons.logout,
                          ),
                          iconSize: 30,
                          onPressed: (){_signOut();} ,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container( width: 120,
                                  height: 120,

                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:NetworkImage(ImgPath.toString()),
                                      fit: BoxFit.cover
                                    ),
                                    border: Border.all(
                                      color: Colors.black54,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80.0),
                                  ),
                                  /*ImgPath!=null? Image.network(
                                    ImgPath!,
                                    fit: BoxFit.fill,
                                    width: 200,
                                    height: 95,
                                  )
                                      :
                                  Image.asset('assets/—Pngtree—cute panda_643086.png',)*/
                                child:Align(
                                    alignment: Alignment.bottomCenter,
                                    child:SizedBox(
                                      height: 40,
                                      width: 80,
                                      child: ElevatedButton(
                                          onPressed:(){pickUpImg(name.toString(),phno.toString(),pin.toString(),email.toString(),pass.toString());
                                            },
                                          child:Text("Update picture")
                                      ),
                                    ),
                                  ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("$name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.brown),),
                              Text("$phno",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.brown),),
                              Text("$email",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.brown),)
                            ],
                          )
                        ],
                      ),
                    ),

                    /*Stack(alignment: Alignment.bottomRight,
                      children:[
                        Container(
                        width: 120,
                        height: 120,

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                        child: image !=null ? Image.file(image!,fit: BoxFit.cover,):Image.asset("assets/—Pngtree—cute panda_643086.png"),
                      ),
                        ElevatedButton(
                          onPressed: () {*//*pickImage();*//*},
                          child: Text('+',style: TextStyle(fontSize: 20),),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                          ),
                        )
                      ]
                    ),*/
                    //Text(user.email.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("@Elixir",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){},
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
                              width: MediaQuery.of(context).size.width/2.9,
                              height: 80,
                              child: Row(
                                children: [
                                  Icon(Icons.settings,size: 28,color: Colors.brown,),
                                  Text(" Settings",style: TextStyle(fontSize: 17,color: Colors.black54,fontWeight: FontWeight.bold),)
                                ],
                              ),


                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return Orderpg();
                            }));},
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
                              width: MediaQuery.of(context).size.width/2.9,
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.timer,size: 28,color: Colors.brown,),
                                  Text("Orders",style: TextStyle(fontSize: 17,color: Colors.black54,fontWeight: FontWeight.bold),)
                                ],
                              ),


                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){},
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
                              width: MediaQuery.of(context).size.width/2.9,
                              height: 80,
                              child: Row(
                                children: [
                                  Icon(Icons.edit,size: 28,color: Colors.brown,),
                                  Text("Edit\nProfile",style: TextStyle(fontSize: 17,color: Colors.black54,fontWeight: FontWeight.bold),)
                                ],
                              ),


                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return Support(username:name,email: email,);
                          }));},
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
                              width: MediaQuery.of(context).size.width/2.5,
                              height: 80,
                              child: Row(
                                children: [
                                  Icon(Icons.phone,size: 28,color: Colors.brown,),
                                  Text("Grievances",style: TextStyle(fontSize: 17,color: Colors.black54,fontWeight: FontWeight.bold),)
                                ],
                              ),


                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30,),
                  ],
                ),
              ),
            ],
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
  void pickUpImg(String name,String phoneno,String pin,String emaill,String pass) async{
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75
    );

    await FirebaseStorage.instance.ref().child(name)
        .putFile(File(image!.path));
    FirebaseStorage.instance.ref().child(name)
        .getDownloadURL().then((value)
    {
      print(value);
      DatabaseService(uid:user.uid).updateUserData(name, phoneno, pin, emaill, pass,value);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Validating image..refresh page to load image"),
      ));
    });
  }
}
class Profinfo extends StatelessWidget {
  @override
  String ImgPath, name;

  // ignore: use_key_in_widget_constructors
  Profinfo({

    // ignore: non_constant_identifier_names
    required this.ImgPath,
    required this.name,
    required this.phno,
    required this.email,

  });

  String phno, email;

  // ignore: empty_constructor_bodies

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Image.network(
                ImgPath,
                fit: BoxFit.contain,
                width: 200,
                height: 95,
              ),
            ],
          ),
          Column(
            children: [
              Text(name),
              Text(phno),
              Text(email)
            ],
          )
        ],
      ),
    );
  }

}

