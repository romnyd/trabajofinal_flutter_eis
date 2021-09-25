import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leyendapps/data.dart';
import 'package:leyendapps/models/LeyendasInfo.dart';

import 'constants.dart';
import 'detail_page.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LeyendasInfo> leyendas = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future fetchStr() async {
    await new Future.delayed(const Duration(seconds: 5), () {});
    return 'Hello World';
  }

  void getData() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("leyendas");

    await collectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);
        leyendas.add(LeyendasInfo(
            position: doc["position"],
            name: doc["name"],
            iconImage: doc["iconImage"],
            description: doc["description"]));
      });
    });

    print(leyendas.length);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchStr(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.deepPurple],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.3, 0.7])),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'LeyendaApps',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                fontSize: 44,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Las mejores leyendas del llano',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 500,
                        padding: const EdgeInsets.only(left: 32),
                        child: Swiper(
                          itemCount: leyendas.length,
                          itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                          layout: SwiperLayout.STACK,
                          pagination: SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                                activeSize: 20, space: 8),
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                //pendiente navegar a la pantalla de detalle
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, a, b) => DetailPage(
                                      leyendasInfo: leyendas[index],
                                    ),
                                  ),
                                );
                              },
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      SizedBox(height: 100),
                                      Card(
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(32.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 100),
                                              Text(
                                                leyendas[index].name,
                                                style: TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontSize: 44,
                                                  color:
                                                      const Color(0xff47455f),
                                                  fontWeight: FontWeight.w900,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                leyendas[index]
                                                        .description
                                                        .substring(1, 80) +
                                                    "...",
                                                style: TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontSize: 15,
                                                  color: primaryTextColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              SizedBox(height: 32),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Leer mas',
                                                    style: TextStyle(
                                                      fontFamily: 'Avenir',
                                                      fontSize: 18,
                                                      color: secondaryTextColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: secondaryTextColor,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(60, 0, 0, 270),
                                    child: Hero(
                                      tag: leyendas[index].position,
                                      child: Image.asset(
                                        leyendas[index].iconImage,
                                        width: 250,
                                        height: 300,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 24,
                                    bottom: 60,
                                    child: Text(
                                      leyendas[index].position.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Avenir',
                                        fontSize: 200,
                                        color:
                                            primaryTextColor.withOpacity(0.08),
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
