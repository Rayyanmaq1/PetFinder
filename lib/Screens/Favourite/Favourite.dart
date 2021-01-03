import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/Widgets/CustomShimmer.dart';
import 'package:pet_finder/Screens/PetDetail/pet_detail.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  String uid;
  String favList;
  bool runOnce = false;
  @override
  void initState() {
    uid = Crud().userUid();

    Crud().checkiffavExist().then((value) {
      setState(() {
        favList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Favourites',
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('UserData')
                      .doc(uid)
                      .collection('Favourite')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        // ignore: missing_return
                        itemBuilder: (context, index) {
                          if (snapshot.data.docs[index].get('State')) {
                            return CustomTile(context, index, snapshot);
                          } else if (favList == 'false' && runOnce == false) {
                            runOnce = true;

                            return Center(
                              child: Container(
                                width: double.infinity,
                                height: 80,
                                child: Center(
                                  child: Text(
                                    'No Data',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomTile extends StatefulWidget {
  CustomTile(this.context, this.index, this.snapshot);
  BuildContext context;
  AsyncSnapshot snapshot;
  int index;

  @override
  _CustomTileState createState() =>
      _CustomTileState(snapshot: snapshot, index: index, context: context);
}

class _CustomTileState extends State<CustomTile> {
  _CustomTileState({this.context, this.index, this.snapshot});
  BuildContext context;
  int index;
  AsyncSnapshot snapshot;
  QuerySnapshot petData;
  bool pageProgress = false;

  // ignore: must_call_super
  initState() {
    Crud().getPetDataforFav().then((value) {
      setState(() {
        petData = value;
      });
    });
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (petData != null) {
      for (int i = 0; i < petData.docs.length; i++) {
        if (petData.docs[i].id == snapshot.data.docs[index].id) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PetDetail(
                    pet: petData.docs[i],
                  );
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: NetworkImage(
                                  petData.docs[i].get('ImageUrl'),
                                ),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: petData.docs[i].get('petCondition') ==
                                        "ADOPTION"
                                    ? Colors.orange[100]
                                    : petData.docs[i].get('petCondition') ==
                                            "DISAPPEAR"
                                        ? Colors.red[100]
                                        : Colors.blue[100],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: petData.docs[i] != null
                                  ? Text(
                                      petData.docs[i].get('petCondition'),
                                      style: TextStyle(
                                        color: petData.docs[i]
                                                    .get('petCondition') ==
                                                "ADOPTION"
                                            ? Colors.orange
                                            : petData.docs[i]
                                                        .get('petCondition') ==
                                                    "DISAPPEAR"
                                                ? Colors.red
                                                : Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    )
                                  : CustomShimmer(),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            petData.docs[i] != null
                                ? Text(
                                    petData.docs[i].get('petName'),
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : CustomShimmer(),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey[600],
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                petData.docs[i] != null
                                    ? Text(
                                        petData.docs[i].get('petLocation'),
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      )
                                    : CustomShimmer(),
                                SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Crud()
                            .favourite(snapshot.data.docs[index].id)
                            .then((_) {
                          setState(() {});
                        });
                      },
                      child: Icon(
                        Icons.favorite,
                        size: 34,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }
    } else {
      return CustomShimmer();
    }
    return Container();
  }
}
