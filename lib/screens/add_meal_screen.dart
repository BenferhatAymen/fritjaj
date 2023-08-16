import 'package:flutter/material.dart';
import 'package:fritjaj/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMealPage extends StatelessWidget {
  String? FriesNumber;
  String? ChickenNumber;
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CollectionReference meals = FirebaseFirestore.instance.collection("meals");
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(30),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Add Meal',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[400],
              )),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            labelText: "Number Of Fries",
            onChanged: (value) {
              FriesNumber = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            labelText: "Number Of Chicken",
            onChanged: (value) {
              ChickenNumber = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  meals.add({
                    "fries": FriesNumber,
                    "chicken": ChickenNumber,
                    'createdAt': DateTime.now(),
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.teal[400], primary: Colors.white))
        ]),
      ),
    );
  }
}
