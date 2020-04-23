import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart.dart';

class MealDetailScreen extends StatelessWidget {
  static const route = "/meal-detail";
  final Function toggleFav;
  final Function isFavouriteMeals;
  MealDetailScreen(this.toggleFav, this.isFavouriteMeals);
  @override
  Widget build(BuildContext context) {
    final mealId = (ModalRoute.of(context).settings.arguments
        as Map<String, String>)['id'];
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    Widget _buildTitleSection(BuildContext context, String titleText) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            titleText,
            style: Theme.of(context).textTheme.title,
          ));
    }

    Widget _buildContainer(BuildContext context, Widget childWidget) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          height: 200,
          width: 300,
          child: childWidget);
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: isFavouriteMeals(mealId) ? Icon(Icons.star) : Icon(Icons.star_border),
          onPressed: () => toggleFav(mealId),
        ),
        appBar: AppBar(
          title: Text(selectedMeal.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
              ),
              _buildTitleSection(context, "Ingredients"),
              _buildContainer(
                  context,
                  ListView.builder(
                      itemCount: selectedMeal.ingredients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text(selectedMeal.ingredients[index])),
                        );
                      })),
              _buildContainer(
                  context,
                  ListView.builder(
                      itemCount: selectedMeal.steps.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                child: Text("# ${(index + 1)}"),
                              ),
                              title: Text(selectedMeal.steps[index]),
                            ),
                            Divider(),
                          ],
                        );
                      }))
            ],
          ),
        ));
  }
}
