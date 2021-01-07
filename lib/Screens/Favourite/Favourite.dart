import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder/Widgets/AltarDialog.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/Widgets/CustomShimmer.dart';
import 'package:pet_finder/Screens/PetDetail/pet_detail.dart';
import 'package:pet_finder/Widgets/SoldTag.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  String uid;
  bool favExists = false;
  bool runOnce = false;
  QuerySnapshot petData;
  bool userLoggedIn = true;
  @override
  void initState() {
    if (Crud().ifuserLoggedIn()) {
      uid = Crud().userUid();
      Crud().getPetDataforFav().then((value) {
        setState(() {
          petData = value;
        });
      });
    } else {
      setState(() {
        userLoggedIn = false;
      });
    }

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Favourites',
            style:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: userLoggedIn
            ? Column(
                children: [
                  petData != null
                      ? Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('UserData')
                                  .doc(uid)
                                  .collection('Favourite')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length,
                                    // ignore: missing_return
                                    itemBuilder: (context, index) {
                                      if (snapshot.data.docs[index]
                                          .get('State')) {
                                        for (int i = 0;
                                            i < petData.docs.length;
                                            i++) {
                                          if (petData.docs[i].id ==
                                              snapshot.data.docs[index].id) {
                                            favExists = true;
                                            return CustomTile(context, index,
                                                snapshot, i, petData);
                                          } else {
                                            continue;
                                          }
                                        }
                                      } else {
                                        if (favExists == false &&
                                            runOnce == false) {
                                          runOnce = true;
                                          return Center(
                                            child: Container(
                                              child: Text('No Data'),
                                            ),
                                          );
                                        }
                                        return Container();
                                      }
                                      return Container();
                                    },
                                  );
                                }
                              }),
                        )
                      : Center(child: CustomShimmer()),
                ],
              )
            : CustomAlertDialog());
  }
}

// ignore: must_be_immutable
class CustomTile extends StatefulWidget {
  CustomTile(this.context, this.index, this.snapshot, this.i, this.petData);
  BuildContext context;
  AsyncSnapshot snapshot;
  int i;
  QuerySnapshot petData;
  int index;

  @override
  _CustomTileState createState() => _CustomTileState(
      snapshot: snapshot,
      index: index,
      context: context,
      i: i,
      petData: petData);
}

class _CustomTileState extends State<CustomTile> {
  _CustomTileState(
      {this.context, this.index, this.snapshot, this.i, this.petData});
  BuildContext context;
  int i;
  int index;
  AsyncSnapshot snapshot;
  QuerySnapshot petData;
  bool pageProgress = false;

  // ignore: must_call_super

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
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
                  Stack(
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
                      petData.docs[i].get('petSold') == 'Sold'
                          ? SoldTag()
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:
                              petData.docs[i].get('petCondition') == "ADOPTION"
                                  ? Colors.orange[100]
                                  : petData.docs[i].get('petCondition') ==
                                          "DISAPPEAR"
                                      ? Colors.red[100]
                                      : Colors.blue[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: petData.docs[i] != null
                            ? Text(
                                petData.docs[i].get('petCondition'),
                                style: TextStyle(
                                  color: petData.docs[i].get('petCondition') ==
                                          "ADOPTION"
                                      ? Colors.orange
                                      : petData.docs[i].get('petCondition') ==
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
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              ? Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.4),
                                  child: Text(
                                    petData.docs[i].get('petLocation'),
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10,
                                    ),
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
                  Crud().favourite(snapshot.data.docs[index].id).then((_) {
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
