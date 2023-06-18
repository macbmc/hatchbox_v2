import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hatchbox_v2/func_screens/search.dart';
import 'package:hatchbox_v2/func_screens/searchget.dart';
import 'package:hatchbox_v2/prod_screens/HomeScreen.dart';
import 'package:hatchbox_v2/prod_screens/prod_desc.dart';
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchcontroller = TextEditingController();
  QuerySnapshot? snapshotdata;
  bool isExec = false;
  late final String ImgPath, name,discount,mrp,your_price;

  @override
  Widget build(BuildContext context) {
    Widget searchData() {
      return SizedBox(
        child: ListView.builder(
            itemCount: snapshotdata!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DescPg(modPath:snapshotdata!.docs[index]['model'].toString(),ImgPath:snapshotdata!.docs[index]['image'].toString(),matter:snapshotdata!.docs[index]['name'].toString(),ls: snapshotdata!.docs[index]['long_description'].toString(),
                        ss:snapshotdata!.docs[index]['short_description'].toString(),
                        status:snapshotdata!.docs[index]['status'].toString(),mrp: snapshotdata!.docs[index]['mrp'],price: snapshotdata!.docs[index]['your_price'],
                        rev1: snapshotdata!.docs[index]['rev1'].toString(),
                        rev2: snapshotdata!.docs[index]['rev2'].toString(),discount:snapshotdata!.docs[index]['discount'],)));
                },
                child: ListTile(
                  leading: Container( width:100,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image:NetworkImage(snapshotdata!.docs[index]['image'].toString()),
                          fit: BoxFit.cover
                      ),
                      border: Border.all(
                        color: Colors.black54,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                  ),
                  title: Text(snapshotdata!.docs[index]['name'].toString()),
                  subtitle: Text(snapshotdata!.docs[index]['your_price'].toString()),
                ),
              );
            }
        ),

      );

    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        leading: IconButton(onPressed:(){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        },
          icon:Icon(
            Icons.arrow_back_ios_outlined,
          ),
          iconSize: 25,
          color: Colors.white,),
        title: TextField(
          controller: searchcontroller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(

              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                iconSize: 30,
                color: Colors.white,
                onPressed: (){
                  setState(()
                  {
                    searchcontroller.text="";
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color:Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              hintText: "Search",
              hintStyle: TextStyle(color: Color(0xffEEF2EB)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),
        ),
        actions: [
          GetBuilder<DataController>(
            init: DataController(),
            builder:(val){
              return IconButton(onPressed:(){val.queryData(searchcontroller.text).then((value){
                snapshotdata = value;
                setState(()
                {
                  isExec = true;
                });
              });
              searchData();
              },  icon: Icon(
                Icons.search_rounded,
              ),);
            } ,
          ),
        ],
      ),
      body: isExec ? searchData():
      Center(
        child: Container(
          child: Text("Explore our vast products",style: TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold,
              fontSize: 15,
              fontFamily: 'ArchitypeRenner-Bold'),),
        ),
      ),
    );
  }

}
