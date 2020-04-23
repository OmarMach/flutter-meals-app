import 'package:flutter/material.dart';

import '../Models/meal.dart';
import '../Screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String imageUrl;
  final String id;
  final int duration;
  final String title;
  final Complexity complexity;
  final Affordability affordability;
  
  String get _complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return "Simple";
      case Complexity.Challenging:
        return "Challenging";
      case Complexity.Hard:
        return "Hard";
      default:
        return "Error";
    }
  }

  String get _affordablityText {
    switch (affordability) {
      case Affordability.Affordable:
        return "Affordable";
      case Affordability.Pricey:
        return "Pricey";
      case Affordability.Luxurious:
        return "Luxurious";
      default:
        return "Error";
    }
  }

  MealItem(
      {@required this.id,
      @required this.duration,
      @required this.imageUrl,
      @required this.title,
      @required this.affordability,
      @required this.complexity,});

  @override
  Widget build(BuildContext context) {
    void selectMeal(BuildContext context, String id) {
      Navigator.of(context).pushNamed(MealDetailScreen.route,
          arguments: {'id': id}).then((result) {
        //if (result != null) removeItem(result);
      });
    }

    return InkWell(
        onTap: () => selectMeal(context, id),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 6,
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.network(
                      imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      width: 350,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      color: Colors.black54,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(Icons.schedule),
                        SizedBox(
                          width: 6,
                        ),
                        Text('$duration Minutes')
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.work),
                        SizedBox(
                          width: 6,
                        ),
                        Text('$_complexityText')
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.attach_money),
                        SizedBox(
                          width: 6,
                        ),
                        Text('$_affordablityText')
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
