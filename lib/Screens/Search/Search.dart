import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/Screens/PetDetail/pet_detail.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();
  String search;
  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  search = value;
                  initState();
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 16),
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
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 1,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('PetData')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (ConnectionState.waiting == snapshot.connectionState) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return search != null
                                ? snapshot.data.docs[index]
                                            .get('petName')
                                            .toString()
                                            .toUpperCase()
                                            .substring(0, search.length) ==
                                        search.toUpperCase()
                                    ? CustomTile(
                                        snapshot: snapshot,
                                        index: index,
                                      )
                                    : Container()
                                : CustomTile(
                                    snapshot: snapshot,
                                    index: index,
                                  );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  CustomTile({this.index, this.snapshot});
  AsyncSnapshot snapshot;
  int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PetDetail(
              pet: snapshot.data.docs[index],
            );
          }));
        },
        child: ListTile(
          leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(snapshot.data.docs[index].get('ImageUrl'))),
          title: Text(snapshot.data.docs[index].get('petName')),
        ),
      ),
    );
  }
}
