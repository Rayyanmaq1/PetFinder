import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/Screens/PetDetail/pet_detail.dart';
import 'package:shimmer/shimmer.dart';

class PetWidget extends StatelessWidget {
  final DocumentSnapshot pet;
  final int index;

  PetWidget({@required this.pet, @required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PetDetail(pet: pet)),
        );
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
        margin: EdgeInsets.only(
            right: index != null ? 16 : 0,
            left: index == 0 ? 16 : 0,
            bottom: 16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: pet.get('ImageUrl'),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: pet.get('ImageUrl') != null
                              ? NetworkImage(pet.get('ImageUrl'))
                              : Shimmer.fromColors(
                                  child: Card(
                                    color: Colors.grey,
                                  ),
                                  baseColor: Colors.white70,
                                  highlightColor: Colors.grey[700],
                                  direction: ShimmerDirection.ltr,
                                ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.favorite,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
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
                      color: pet.get('petCondition') == "ADOPTION"
                          ? Colors.orange[100]
                          : pet.get('petCondition') == "DISAPPEAR"
                              ? Colors.red[100]
                              : Colors.blue[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: pet.get('petCondition') != null
                        ? Text(
                            pet.get('petCondition'),
                            style: TextStyle(
                              color: pet.get('petCondition') == "ADOPTION"
                                  ? Colors.orange
                                  : pet.get('petCondition') == "DISAPPEAR"
                                      ? Colors.red
                                      : Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )
                        : Shimmer.fromColors(
                            child: Card(
                              color: Colors.grey,
                            ),
                            baseColor: Colors.white70,
                            highlightColor: Colors.grey[700],
                            direction: ShimmerDirection.ltr,
                          ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  pet.get('petName') != null
                      ? Text(
                          pet.get('petName'),
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Shimmer.fromColors(
                          child: Card(
                            color: Colors.grey,
                          ),
                          baseColor: Colors.white70,
                          highlightColor: Colors.grey[700],
                          direction: ShimmerDirection.ltr,
                        ),
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
                      pet.get('petLocation') != null
                          ? Text(
                              pet.get('petLocation'),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            )
                          : Shimmer.fromColors(
                              child: Card(
                                color: Colors.grey,
                              ),
                              baseColor: Colors.white70,
                              highlightColor: Colors.grey[700],
                              direction: ShimmerDirection.ltr,
                            ),
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
