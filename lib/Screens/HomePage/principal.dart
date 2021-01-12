import 'package:flutter/material.dart';
import 'package:pet_finder/Screens/Category_list/category_list.dart';
import 'package:pet_finder/Screens/Pet_Widget/pet_widget.dart';
import 'package:pet_finder/Screens/Data/data.dart';
import 'package:pet_finder/Screens/Search/Search.dart';
import 'package:pet_finder/Screens/UploadPet/UploadPet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:pet_finder/ViewModel/SizeConfig.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pet_finder/Widgets/Drawer.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  QuerySnapshot petData;

  Crud crud = new Crud();

  @override
  void initState() {
    crud.getAllpetData().then((value) {
      setState(() {
        petData = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UploadPet();
          })).then((value) {
            setState(() {
              initState();
            });
          });
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.file_upload),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Find Your",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.textMultiplier * 2.9,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Lovely pet in anywhere",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: SizeConfig.textMultiplier * 2.9,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                child: TextField(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Search();
                    }));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle:
                        TextStyle(fontSize: SizeConfig.textMultiplier * 1.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.only(
                      right: 30,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 16.0, left: 24.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: SizeConfig.textMultiplier * 2.6,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pet Category",
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildPetCategory(Category.HAMSTER, Colors.orange[200]),
                      buildPetCategory(Category.CAT, Colors.blue[200]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildPetCategory(Category.BUNNY, Colors.green[200]),
                      buildPetCategory(Category.DOG, Colors.red[200]),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Newest Pet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
            petData != null
                ? Container(
                    height: SizeConfig.heightMultiplier * 35,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: buildNewestPet(),
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
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vets Near You",
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 1.9,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.heightMultiplier * 16,
              margin: EdgeInsets.only(bottom: 16),
              child: PageView(
                physics: BouncingScrollPhysics(),
                children: [
                  buildVet("assets/images/vets/vet_0.png",
                      "Animal Emergency Hospital", "(369) 133-8956"),
                  buildVet("assets/images/vets/vet_1.png",
                      "Artemis Veterinary Center", "(706) 722-9159"),
                  buildVet("assets/images/vets/vet_2.png",
                      "Big Lake Vet Hospital", "(598) 4986-9532"),
                  buildVet("assets/images/vets/vet_3.png",
                      "Veterinary Medical Center", "(33) 8974-559-555"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPetCategory(Category category, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryList(category: category),
              ));
        },
        child: Container(
          height: SizeConfig.textMultiplier * 8.3,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[200],
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: SizeConfig.textMultiplier * 5.9,
                width: SizeConfig.textMultiplier * 5.9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.5),
                ),
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      "assets/images/" +
                          (category == Category.HAMSTER
                              ? "hamster"
                              : category == Category.CAT
                                  ? "cat"
                                  : category == Category.BUNNY
                                      ? "bunny"
                                      : "dog") +
                          ".png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category == Category.HAMSTER
                        ? "Hamsters"
                        : category == Category.CAT
                            ? "Cats"
                            : category == Category.BUNNY
                                ? "Bunnies"
                                : "Dogs",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildNewestPet() {
    List<Widget> list = [];
    List<Widget> emptyList = [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: Text('No Data')),
        ],
      )
    ];
    bool dataAvalible = false;
    for (var i = 0; i < petData.docs.length; i++) {
      dataAvalible = true;
      list.add(PetWidget(pet: petData.docs[i], index: i));
    }
    if (dataAvalible == true) {
      return list;
    } else {
      return emptyList;
    }
  }

  Widget buildVet(String imageUrl, String name, String phone) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 4),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 1,
          color: Colors.grey[300],
        ),
      ),
      child: Row(
        children: [
          Container(
            height: SizeConfig.heightMultiplier * 12,
            width: SizeConfig.widthMultiplier * 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.grey[800],
                    size: 18,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    phone,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  "OPEN - 24/7",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
