import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/main.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';

import 'addIcreamTypesScreen.dart';
import 'adddesserts.dart';


class DeseertsItemScreen extends StatelessWidget {
  String icecategory;
  String icecategoryid;
  String maincategoryid;

  DeseertsItemScreen({super.key,required this.icecategory,required this.icecategoryid,required this.maincategoryid});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            appbarbkgd,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        floatingActionButton:
        Consumer<Mainprovider>(
            builder: (context,value,child) {
              return FloatingActionButton(
                backgroundColor: cgreen,
                child: Icon(Icons.add, color: cWhite, size: 38),
                onPressed: () {
                  value.dessertsclear();
                         callNext(context, adddessertsScreen(dessertsfrom: "NEW", dessertsoldid: '',
                           icecategory: icecategory, icecategoryid: icecategoryid, maincategoryid: maincategoryid,));
                },
              );
            }
        ),

        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              back(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: cgreen,
              size: 24,
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,

          title: text(
            " Fouzy Dessert Item",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              Consumer<Mainprovider>(
                  builder: (context,value,child) {
                    return  GridView.builder(
                      itemCount: value.dessertslist.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 0.2,
                          crossAxisCount: 2,
                          childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        var items = value.dessertslist[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 35),
                          width: width,
                          height: height*.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: cWhite,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(child: text(items.name, FontWeight.w800, cgreen, 20)),
                              FittedBox(child: text("₹"+items.price, FontWeight.w800, cgreen, 20)),



                              SizedBox(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: Text(
                                                "Do you want to DELETE ?",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: cBlack)),
                                            actions: <Widget>[
                                              Center(
                                                child: TextButton(
                                                  onPressed: () {
                                                    value.deleteDessert(items.id,context);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: myRed,
                                                        borderRadius:
                                                        BorderRadius.circular(8),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Color(0x26000000),
                                                            blurRadius:
                                                            2.0, // soften the shadow
                                                            spreadRadius:
                                                            1.0, //extend the shadow
                                                          ),
                                                        ]),
                                                    child: Center(
                                                        child: Text("Delete",
                                                            style: TextStyle(
                                                                color: cWhite,
                                                                fontSize: 17,
                                                                fontWeight:
                                                                FontWeight.w700))),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        );
                                      },
                                      child: btn(40, 80, cWhite, "Delete", myRed, FontWeight.w500, 12,Icons.delete_outline)),

                                  InkWell(    onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Text(
                                            "Do you want to EDIT ?",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: cBlack)),
                                        actions: <Widget>[
                                          Center(
                                            child: TextButton(
                                              onPressed: () {
                                                print("hgfds0"+items.id);
                                                value.editDessertList(items.id, context);
                                                callNext(context, adddessertsScreen(dessertsfrom: "EDIT", dessertsoldid: items.id,
                                                  icecategory: icecategory, icecategoryid: icecategoryid, maincategoryid: maincategoryid,));


                                              },
                                              child: Container(
                                                height: 45,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                    color: cgreen,
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color(0x26000000),
                                                        blurRadius:
                                                        2.0, // soften the shadow
                                                        spreadRadius:
                                                        1.0, //extend the shadow
                                                      ),
                                                    ]),
                                                child: Center(
                                                    child: Text("Edit",
                                                        style: TextStyle(
                                                            color: cWhite,
                                                            fontSize: 17,
                                                            fontWeight:
                                                            FontWeight.w700))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                      child: btn(40, 80, cWhite, "Edit", cgreen, FontWeight.w500, 12,Icons.edit_outlined)),

                                ],
                              ),
                              SizedBox(height: 2,)
                            ],
                          ),

                        );
                      },
                    );
                  }
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
