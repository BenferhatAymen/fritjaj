import 'package:flutter/material.dart';
import 'package:fritjaj/providers/theme_state_provider.dart';
import 'package:fritjaj/screens/add_meal_screen.dart';
import 'package:fritjaj/widgets/custom_text_field.dart';
import 'package:fritjaj/widgets/meal_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../models/Chicken_fries_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IconData iconLight = Icons.wb_sunny;
  IconData iconDark = Icons.nightlight_round;

  @override
  Widget build(BuildContext context) {
    bool iconState = Provider.of<ThemeProvider>(context).isDarkMode;

    CollectionReference meals = FirebaseFirestore.instance.collection("meals");
    return StreamBuilder<QuerySnapshot>(
        stream: meals.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ChikckenFries> mealsList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              ChikckenFries chikenFries =
                  ChikckenFries.fromJson(snapshot.data!.docs[i].data());
              chikenFries.id = snapshot.data!.docs[i].id;
              mealsList.add(chikenFries);
            }

            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                          child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: AddMealPage())),
                      isScrollControlled: true);
                },
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: AppBar(
                actions: [
                  IconButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed:
                          Provider.of<ThemeProvider>(context).toggleTheme,
                      icon: iconState ? Icon(iconLight) : Icon(iconDark))
                ],
                automaticallyImplyLeading: false,
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Frit Jaj Manager",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ]),
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text("Orders Left : ${mealsList.length}",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: mealsList.length,
                        itemBuilder: (context, index) {
                          return MealCard(
                            chickenNumber: mealsList[index].chickenQuantity,
                            friesNumber: mealsList[index].friesQuantity,
                            id: mealsList[index].id,
                          );
                        }),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                          child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: AddMealPage())),
                      isScrollControlled: true);
                },
              ),
              body: Center(
                child: Container(child: Text("No Orders Yet")),
              ),
            );
          }
        });
  }
}
