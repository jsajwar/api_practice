// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "dart:convert";
import 'dart:async';

import "package:api_practice/model.dart";
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Quote> myQuotes = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    color: const Color.fromARGB(255, 149, 220, 255),
                    margin: EdgeInsets.all(23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Id: ${myQuotes[index].id}'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Quote:${myQuotes[index].quote}'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Author:${myQuotes[index].author}'),
                      ],
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<List<Quote>> getData() async {
    final response = await http.get(Uri.parse("https://dummyjson.com/quotes"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        myQuotes.add(Quote.fromJson(index));
      }
      return myQuotes;
    } else {
      return myQuotes;
    }
  }
}
