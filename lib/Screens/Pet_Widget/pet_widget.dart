import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/route_manager.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:pet_finder/Screens/PetDetail/pet_detail.dart';
import 'package:pet_finder/ViewModel/SizeConfig.dart';
import 'package:pet_finder/Widgets/CustomShimmer.dart';
import 'package:pet_finder/Widgets/SoldTag.dart';

// ignore: must_be_immutable
class PetWidget extends StatefulWidget {
  final DocumentSnapshot pet;
  final int index;

  PetWidget({@required this.pet, @required this.index});

  @override
  _PetWidgetState createState() => _PetWidgetState(index: index, pet: pet);
}

class _PetWidgetState extends State<PetWidget> {
  _PetWidgetState({this.index, this.pet});
  final DocumentSnapshot pet;
  final int index;
  DocumentSnapshot userFavourite;
  @override
  // ignore: must_call_super
  initState() {
    if (Crud().ifuserLoggedIn()) {
      Crud().checkFavourite(widget.pet.id).then((value) {
        setState(() {
          userFavourite = value;
        });
      });
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(PetDetail(pet: pet)).then((value) {
          setState(() {
            initState();
          });
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.grey[200],
            width: 1,
          ),
        ),
        margin: EdgeInsets.only(bottom: 16, left: 12, right: 5),
        width: SizeConfig.widthMultiplier * 55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.pet != null
                            ? NetworkImage(widget.pet.get('ImageUrl'))
                            : CustomShimmer(),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  pet.get('petSold') == 'Sold' ? SoldTag() : Container(),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        height: 35,
                        width: 35,
                        child: GestureDetector(
                          onTap: () {
                            Crud().favourite(pet.id).then((_) {
                              setState(() {
                                initState();
                              });
                            });
                          },
                          child: userFavourite != null
                              ? Icon(
                                  Icons.favorite,
                                  color: userFavourite.exists
                                      ? userFavourite.get('State')
                                          ? Colors.red
                                          : Colors.grey
                                      : Colors.grey,
                                  size: 22,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Colors.grey,
                                  size: 22,
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: widget.pet.get('petCondition') == "ADOPTION"
                          ? Colors.orange[100]
                          : widget.pet.get('petCondition') == "DISAPPEAR"
                              ? Colors.red[100]
                              : Colors.blue[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: widget.pet != null
                        ? Text(
                            widget.pet.get('petCondition'),
                            style: TextStyle(
                              color:
                                  widget.pet.get('petCondition') == "ADOPTION"
                                      ? Colors.orange
                                      : widget.pet.get('petCondition') ==
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
                  widget.pet != null
                      ? Text(
                          widget.pet.get('petName'),
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
                      widget.pet != null
                          ? Expanded(
                              child: Text(
                                widget.pet.get('petLocation'),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
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
            ),
          ],
        ),
      ),
    );
  }
}
