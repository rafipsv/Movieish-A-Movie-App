// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, prefer_const_constructors_in_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatelessWidget {
  final String bannelUrl;
  final String rating;
  final String name;
  final String popularity;
  final String language;
  final String posterUrl;
  final String desc;
  DetailsPage({
    required this.bannelUrl,
    required this.rating,
    required this.name,
    required this.popularity,
    required this.language,
    required this.posterUrl,
    required this.desc,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        bannelUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    child: DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        child: Text(
                          "⭐ Avarage Rating $rating",
                          style: GoogleFonts.lobster(),
                        )),
                    bottom: 40,
                    left: 10,
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    child: Text(
                      name,
                      style: GoogleFonts.lobster(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    child: Text(
                      "Original Language: $language",
                      style: GoogleFonts.lobster(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    child: Text(
                      "⭐ Total Ratings: $popularity",
                      style: GoogleFonts.lobster(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 200,
                        width: 150,
                        child: Image.network(posterUrl),
                      ),
                      Flexible(
                        child: DefaultTextStyle(
                            style: TextStyle(color: Colors.white, fontSize: 17),
                            child: Text(
                              desc,
                              style: GoogleFonts.lobster(),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
