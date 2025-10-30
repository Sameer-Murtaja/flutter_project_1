import 'package:flutter/material.dart';
import 'package:flutter_project_1/UI/screens/recipe_details_screen.dart';
import 'package:flutter_project_1/UI/utils/app_color.dart';
import 'package:flutter_project_1/data/models/recipe.dart';

class RecipeTile extends StatelessWidget {
  final Recipe data;
  const RecipeTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeDetailScreen(data: data)));
      },
      child: Container(
        height: 90,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.primaryExtraSoft,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Recipe Photo
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blueGrey,
                image: DecorationImage(
                  image: NetworkImage(data.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Recipe Info
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe title
                    Text(
                      data.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'inter',
                      ),
                    ),
                    SizedBox(height: 12),
                    // Recipe Calories and Time
                    Row(
                      children: [
                        Icon(
                          Icons.fireplace_outlined,
                          size: 12,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5),
                        Text(data.caloriesPerServing, style: TextStyle(fontSize: 12)),
                        SizedBox(width: 10),
                        Icon(Icons.alarm, size: 14, color: Colors.black),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            data.time,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
