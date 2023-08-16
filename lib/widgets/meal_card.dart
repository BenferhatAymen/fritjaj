import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealCard extends StatelessWidget {
  MealCard({this.chickenNumber, this.friesNumber, this.id});
  String? friesNumber;
  String? chickenNumber;
  String? imageLink;
  var id;

  @override
  Widget build(BuildContext context) {
    if (int.parse(friesNumber!) == 0 && int.parse(chickenNumber!) != 0) {
      imageLink = "assets/images/jaj.jpg";
    } else if (int.parse(friesNumber!) != 0 && int.parse(chickenNumber!) == 0) {
      imageLink = "assets/images/fritt.jpg";
    } else {
      imageLink = "assets/images/fritt_jaj.jpg";
    }
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(25)),
        width: 370,
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                imageLink!,
                height: 120,
                width: 150,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Fritt : $friesNumber", style: TextStyle(fontSize: 17)),
                Text("Jaj : $chickenNumber", style: TextStyle(fontSize: 17)),
              ],
            ),
            Spacer(),
            GestureDetector(
              child: Icon(Icons.done),
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection("meals")
                    .doc(id)
                    .delete();
              },
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ));
  }
}
