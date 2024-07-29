import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fouzy/constants/callFunctions.dart';
import 'package:fouzy/constants/colors.dart';
import 'package:provider/provider.dart';
import '../modelClass/MainCategoryModelClass.dart';
import '../provider/mainprovider.dart';
import 'FouzyAvilMilkList.dart';
import 'IceCreamList.dart';
import 'Juice&ShakesList.dart';
import 'fouzy_multiple.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Home_screen> {
  late Future<List<MainCategory>> _mainCategoryFuture;

  @override
  void initState() {
    super.initState();
    _mainCategoryFuture = Provider.of<Mainprovider>(context, listen: false).getMainCategoy();
  }

  @override
  Widget build(BuildContext context) {
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
          scrollDirection: Axis.vertical,
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
            child: FutureBuilder<List<MainCategory>>(
              future: _mainCategoryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No categories found'));
                } else {
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var items = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          final value = Provider.of<Mainprovider>(context, listen: false);
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
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 28),
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
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

// The showExitPopup function remains unchanged















// The showExitPopup function remains unchanged
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
