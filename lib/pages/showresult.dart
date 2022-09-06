// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/pages/detailspage.dart';

class ShowResults extends StatelessWidget {
  String title;
  List results;
  ShowResults({required this.title, required this.results});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 8),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 25,
              ),
              child: Text(
                title,
                style: GoogleFonts.lobster(),
              ),
            ),
          ),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: results.length,
              itemBuilder: (BuildContext context, int index) {
                return results[index]['title'] != null
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => DetailsPage(
                                    bannelUrl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            results[index]['backdrop_path'],
                                    rating: results[index]['vote_average']
                                        .toString(),
                                    name: results[index]['title'],
                                    popularity:
                                        results[index]['popularity'].toString(),
                                    language: results[index]
                                        ['original_language'],
                                    posterUrl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            results[index]['poster_path'],
                                            desc: results[index]['overview'],
                                  )),
                            ),
                          );
                        },
                        splashColor: Color.fromARGB(255, 134, 4, 48),
                        highlightColor: Color.fromARGB(255, 134, 4, 48),
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            results[index]['poster_path'],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    child: Text(
                                      results[index]['title'],
                                      style: GoogleFonts.lobster(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
