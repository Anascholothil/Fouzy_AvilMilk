import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:fouzy/constants/colors.dart';
import 'package:provider/provider.dart';
import '../modelClass/MainCategoryModelClass.dart';
import '../provider/mainprovider.dart';
import 'FouzyAvilMilkList.dart';
import 'IceCreamList.dart';
import 'Juice&ShakesList.dart';
import 'fouzy_multiple.dart';

class Home_screen extends StatelessWidget {
  const Home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    Mainprovider provider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getMainCategoy();
      print("ffvfvfv" + provider.mainCategorylist.length.toString());
    });

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        showExitPopup(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: cYellow,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => ZoomDrawer.of(context)!.toggle(),
              icon: Icon(Icons.food_bank_rounded,color: cgreen,size: 60,)),
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bgimg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: Container(
              height: height,
              width: width,
              decoration: ShapeDecoration(
                color: cgreen,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
              child: Consumer<Mainprovider>(builder: (context, value, child) {
                return ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.mainCategorylist.length,
                  itemBuilder: (context, index) {
                    var items = value.mainCategorylist[index];
                    print("vfjvbfjnvjn" +
                        value.mainCategorylist.length.toString());
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          value.getfsptypes();
                          callNext(context, FouzyMultiple());
                        } else if (index == 1) {
                          value.getavilmilktypes();
                          callNext(context, FouzyAvilMilkListScreen());
                        } else if (index == 2) {
                          value.fetchIceCreamList();
                          value.fetchDessertList();
                          callNext(context, IceCreamListScreen());
                        } else if (index == 3) {
                          value.getJuiceShakesAllItems();
                          callNext(context, Juice_ShakesListScreen());
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 28),
                        child: Container(
                          height: height / 12,
                          width: width * .2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: syellow,
                            image: const DecorationImage(
                              image: AssetImage('assets/containerimg.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              items.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              })),
        ),
      ),
    );
  }
}

Future<bool> showExitPopup(BuildContext CONTXT) async {
  return await showDialog(
      context: CONTXT,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cYellow,
          content: SizedBox(
            height: 95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you want to EXIT ?",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'ink nut',
                        fontWeight: FontWeight.w700,
                        color: cgreen)),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style:
                              ElevatedButton.styleFrom(backgroundColor: cgreen),
                          child: Center(
                              child: Text("yes",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700)))),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Center(
                          child: Text("No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700))),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}
