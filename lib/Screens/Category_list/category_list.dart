import 'package:flutter/material.dart';
import 'package:pet_finder/Screens/Data/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:pet_finder/Screens/Pet_Widget/pet_widget.dart';
import 'package:pet_finder/Widgets/CustomShimmer.dart';

// ignore: must_be_immutable
class CategoryList extends StatefulWidget {
  final Category category;
  BuildContext context;

  CategoryList({@required this.category, this.context});

  @override
  _CategoryListState createState() => _CategoryListState(category: category);
}

class _CategoryListState extends State<CategoryList> {
  final Category category;

  _CategoryListState({@required this.category});
  QuerySnapshot petData;

  void initState() {
    String pet = category.toString();
    String searchquery = (pet.substring(9, pet.length));
    Crud().getPetDataforCategory(searchquery).then((value) {
      setState(() {
        petData = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          (widget.category == Category.HAMSTER
                  ? "Hamster"
                  : widget.category == Category.CAT
                      ? "Cat"
                      : widget.category == Category.BUNNY
                          ? "Bunny"
                          : "Dog") +
              " Category",
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.more_horiz,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          petData != null
              ? petData.docs.length != 0
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemCount: petData.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1 / 1.6, crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return PetWidget(
                                pet: petData.docs[index], index: index);
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: Container(child: Text('No Data')),
                    )
              : CustomShimmer(),
        ],
      ),
    );
  }
}
