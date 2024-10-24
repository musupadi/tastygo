import 'package:flutter/material.dart';

import '../Constant/Colors.dart';
import '../Model/Ascendant.dart';
import '../Model/SharedPreferance.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BackgroundGray(),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 3.0,
            backgroundColor: PrimaryColors(),
            title: Text(
              "Profile",style: TextStyle(
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
                    height: 280,
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
                          Container(
                            height: 100,
                            width: 100,
                            child: CircleAvatar(
                              backgroundColor: PrimaryColors(),
                              foregroundImage: AssetImage("assets/img/logo.png"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                            future: SharedName(),
                            builder: (context, snapshot) {
                              return Text(snapshot.requireData,
                                style: TextStyle(
                                    color: PrimaryColors(),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              );
                            },
                          ),
                          Text("User",
                            style: TextStyle(
                                color: PrimaryColors(),
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Divider(thickness: 2,),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                      child: Text("Wallet",style: TextStyle(
                                          color: PrimaryColors(),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),)
                                  ),
                                  Container(
                                      child: Text("Rp.0",
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
                        ],
                      ),
                    ),

                  ),

                ],
                )
              ],
            ),
            Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: Colors.grey,
                          offset:Offset(0,3),
                          spreadRadius: 1
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: Text(
                          "Edit Data User",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          )
                      )
                  ),
                )
            ),
            Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: Colors.grey,
                          offset:Offset(0,3),
                          spreadRadius: 1
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: Text(
                          "Topup Wallet",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          )
                      )
                  ),
                )
            ),
            Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: Colors.grey,
                          offset:Offset(0,3),
                          spreadRadius: 1
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: Text(
                          "Privacy and Policy",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          )
                      )
                  ),
                )
            ),
            InkWell(
              onTap: () {
                LogoutMessage("Are You Sure Want to Logout ?", "Logout KEMBANG apps ? ", context);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: Colors.grey,
                          offset:Offset(0,3),
                          spreadRadius: 1
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                    )
                  )
                  ),
                )
              ),
            ),
          ],
        )
    );
  }
}
