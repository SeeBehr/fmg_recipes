import 'dart:convert';
import 'data/example_my_recipe.dart' as file;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fmg_recipes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  

  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState.fromJson();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Recipe> recipes = [];
  var jrecipes = jsonDecode(file.x)['data']['recipes'];
  _MyHomePageState.dummy() {
    recipes = [Recipe.dummy()];
  }
  
  _MyHomePageState.fromJson () {
     recipes = jrecipes.map((value) => Recipe.fromJson(value)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  recipes[0].name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  recipes[0].headline,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  recipes[0].descriptionMarkdown,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Image.network(
                      "https://img.hellofresh.com/w_400/hellofresh_s3/${recipes[0].imagePath}"
                      ),
                    Text(
                      recipes[0].difficulty.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "${recipes[0].prepTime}\n${recipes[0].totalTime}",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                for (var item in recipes[0].ingredients)
                Row(
                    children: [
                      Image.network("https://img.hellofresh.com/w_400/hellofresh_s3/${item.imagePath}"),
                      Column(
                        children: [
                          Text(
                            item.family.name
                          ),
                          for (var ingr in jsonDecode(recipes[0].yieldsJson)['ingredients']) 
                            if (ingr['id'] == item.id) 
                              Text(
                                ingr['amount']
                              )
                        ],
                      )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Recipe {
  late String country;
  late List<Cuisines> cuisines = [];
  late String description;
  late String descriptionMarkdown;
  late int difficulty;
  late String headline;
  late String id;
  late String imagePath;
  late List<Ingredient> ingredients = [];
  late String name;
  late String prepTime;
  late String slug;
  late List<Tag> tags = [];
  late String totalTime;
  late String yieldsJson;
  Recipe.dummy() {
    country = "country";
    cuisines = [Cuisines.dummy()];
    description = "description";
    descriptionMarkdown = "descriptionMarkdown";
    difficulty = 1;
    headline = "headline";
    id = "id";
    imagePath = "imagePath";
    ingredients = [Ingredient.dummy()];
    name = "name";
    prepTime = "prepTime";
  }

  Recipe.fromJson(json) {
    country = json['country'];
    var cuisine = json['cuisines'];
    cuisines.add(Cuisines.fromJson(cuisine['cuisines']));
    /*
    for (var item in json['cuisines']['cuisines']) {
      cuisines.add(Cuisines.fromJson(item));
    }
    */
    description = json['description'];
    descriptionMarkdown = json['descriptionMarkdown'];
    difficulty = int.parse(json['difficulty']);
    headline = json['headline'];
    id = json['id'];
    imagePath = json['imagePath'];
    for (var item in json['ingredients']['ingredients']) {
      ingredients.add(Ingredient.fromJson(item));
    }
    name = json['name'];
    prepTime = json['prepTime'];
    slug = json['slug'];
    for (var item in json['tags']['tags']) {
      tags.add(Tag.fromJson(item));
    }
    totalTime = json['totalTime'];
    yieldsJson = json['yieldsJson'];
  }
}

class Cuisines {
  late String iconPath;
  late String id;
  late String name;
  late String slug;
  late String type;
  Cuisines.dummy() {
    iconPath = "hallo";
    id = "1";
    name = "name";
    slug = "slug";
    type = "type";
  }

  Cuisines.fromJson(json) {
    iconPath = json['iconPath'];
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    type = json['type'];
  }
}

class Ingredient {
  late String country;
  late Family family;
  late String id;
  late String imagePath;
  late String slug;
  late String type;
  Ingredient.dummy() {
    country = "country";
    family = Family.dummy();
    id = "id";
    imagePath = "imagePath";
    slug = "slug";
    type = "type";
  }

  Ingredient.fromJson(json) {
    country = json['country'];
    family = Family.fromJson(json['family']);
    id = json['id'];
    imagePath = json['imagePath'];
    slug = json['slug'];
    type = json['type'];
  }
}

class Tag {
  late String id;
  late String name;
  late String numberOfRecipesByCountry;
  late String slug;
  late String type;

  Tag.dummy() {
    id = "id";
    name = "name";
    numberOfRecipesByCountry = "number";
    slug = "slug";
    type = "type";
  }

  Tag.fromJson(json) {
    id = json['id'];
    name = json['name'];
    numberOfRecipesByCountry = json['numberOfRecipesByCountry'];
    slug = json['slug'];
    type = json['type'];
  }
}

class Family {
  late String iconPath;
  late String id;
  late String name;
  late String slug;
  late String type;
  Family.dummy() {
    iconPath = "iconPath";
    id = "id";
    name = "name";
    slug = "slug";
    type = "type";
  }

  Family.fromJson(json) {
    iconPath = json['iconPath'];
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    type = json['type'];
  }
}