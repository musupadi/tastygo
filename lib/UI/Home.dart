import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastygo/Adapter/AdapterFood.dart';
import 'package:tastygo/Constant/FontSize.dart';
import 'package:tastygo/Model/StaticData.dart';
import 'package:tastygo/Route.dart';

import '../Constant/Colors.dart';



class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String Nama="Nama";

  @override
  void initState() {
    // Get.to(logins);
    super.initState();
    NamaSession();
  }

  Future<void> NamaSession() async{
    final prefs = await SharedPreferences.getInstance();
    final String? name = await prefs.getString('name');

    setState(() => Nama = "Developer");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BackgroundGray(),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 3.0,
            backgroundColor: PrimaryColors(),
            title: Text(
              "Home",style: TextStyle(
                fontSize: 25,
                color: Colors.white
            ),
            ),
            actions : [
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 28,
                ),
              )
            ]
        ),
        body: ListView(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  color: PrimaryColors(),
                  height: 164,
                  width: double.infinity,
                ),
                Column(children: [
                  SizedBox(
                    width: double.infinity,
                    height: 25,),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 227,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 7,
                              color: Colors.grey,
                              offset:Offset(0,3),
                              spreadRadius: 4
                          )
                        ]
                    ),
                    child:  Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: CircleAvatar(
                                    backgroundColor: PrimaryColors(),
                                    foregroundImage: AssetImage("assets/img/logo.png"),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text("Ryeisa",
                                        style: TextStyle(
                                            color: PrimaryColors(),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(thickness: 2,),
                          Row(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  child: CircleAvatar(
                                    backgroundColor: SecondaryColors(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Image.asset("assets/img/wallet.png"),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Text("Wallet",style: TextStyle(
                                            color: PrimaryColors(),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),)
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text("Rp.0",style: TextStyle(
                                          color: PrimaryColors(),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),)
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ),
                  SizedBox(width: double.infinity, height: 10),

                ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7,
                        color: Colors.grey,
                        offset:Offset(0,3),
                        spreadRadius: 4
                    )
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final cameras = await availableCameras();
                            toScanner(context, false,cameras);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 65,
                                  width: 65,
                                  child: Image.asset("assets/img/scan.png")
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Scan",
                                style: TextStyle(
                                    color: PrimaryColors(),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 65,
                                width: 65,
                                child: CircleAvatar(
                                  backgroundColor: SecondaryColors(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset("assets/img/finance.png"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Terdekat",style: TextStyle(
                                color: PrimaryColors(),
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 65,
                                width: 65,
                                child: CircleAvatar(
                                  backgroundColor: SecondaryColors(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset("assets/img/product.png"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Favorite",style: TextStyle(
                                color: PrimaryColors(),
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final cameras = await availableCameras();
                            toScanner(context, false,cameras);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 65,
                                  width: 65,
                                  child: Image.asset(
                                    "assets/img/delivery.png"
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Delivery",
                                style: TextStyle(
                                    color: PrimaryColors(),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 65,
                                width: 65,
                                child: CircleAvatar(
                                  backgroundColor: SecondaryColors(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset("assets/img/voucher.png"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Voucher",style: TextStyle(
                                color: PrimaryColors(),
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 65,
                                width: 65,
                                child: CircleAvatar(
                                  backgroundColor: SecondaryColors(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset("assets/img/history.png"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("History",style: TextStyle(
                                color: PrimaryColors(),
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.maxFinite,
              child: Text("Terdekat",
                style: TextStyle(
                    color: PrimaryColors(),
                    fontSize: HeaderFontSize(),
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.left,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: ListFood.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Adapterfood();
              },
            )
          ],
        )
    );
  }
}
