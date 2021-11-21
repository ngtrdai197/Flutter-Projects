import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic routeArgs = ModalRoute.of(context)?.settings.arguments;
    final mealId = routeArgs['id'] ?? '';
    final meal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId, orElse: () {
      throw Exception('Cannot found meal');
    });
    final appBar = AppBar(title: Text(meal.title));
    final realHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: realHeight * 0.3,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, 'Ingredients'),
            _buildContainer(
              ListView.builder(
                itemBuilder: (ctx, idx) {
                  return Card(
                    elevation: 3,
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        meal.ingredients[idx],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                itemCount: meal.ingredients.length,
              ),
            ),
            _buildSectionTitle(context, 'Steps'),
            _buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, idx) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${idx + 1}'),
                          ),
                          title: Text(meal.steps[idx]),
                        ),
                        Divider(
                          color: Colors.black54,
                        )
                      ],
                    );
                  },
                  itemCount: meal.steps.length,
                ),
                height: 300)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.delete,
        ),
        onPressed: () {
          Navigator.of(context).pop(mealId);
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildContainer(Widget widget, {double height = 200}) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.white)),
      child: widget,
    );
  }
}
