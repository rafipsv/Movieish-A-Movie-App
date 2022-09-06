// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, empty_catches, unused_import, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/pages/loginpage.dart';
import 'package:movies_app/pages/showresult.dart';
import 'package:movies_app/services/auth_services.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  List trendingMovies = [];
  List topRatedMovies = [];
  List upcommingMovies = [];
  List popularMovies = [];
  final apikey = "4abb08ffa654a48f7bb04eef97aafd24";
  final apiAccessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YWJiMDhmZmE2NTRhNDhmN2JiMDRlZWY5N2FhZmQyNCIsInN1YiI6IjYzMTRjZjg4YjNlNjI3MDA3ZTM2NzNlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tNVV1kTy5U_wywHGvw8zvHeE405utioeiEtg8tTjZdo";
  AuthService auth = AuthService();
  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(
        apikey,
        apiAccessToken,
      ),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    Map moviesTrending = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map moviesTopRated = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map moviesUpcomming = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    Map moviesPopular = await tmdbWithCustomLogs.v3.movies.getPopular();
    setState(() {
      trendingMovies = moviesTrending["results"];
      topRatedMovies = moviesTopRated["results"];
      upcommingMovies = moviesUpcomming["results"];
      popularMovies = moviesPopular["results"];
    });
    print(trendingMovies);
  }

  void showSnackBar(BuildContext context, String error) {
    var snackBar = SnackBar(
      content: DefaultTextStyle(
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        child: Text(
          error,
          style: GoogleFonts.lobster(),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 134, 4, 48),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 25),
            child: Text(
              "Movieish-A Movie App",
              style: GoogleFonts.lobster(),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: IconButton(
              splashColor: Color.fromARGB(255, 184, 10, 68),
              onPressed: () async {
                /// We Will add here user sign out function.
                try {
                  await auth.userSignOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ), (route) => false);
                  showSnackBar(context, "Logged Out Successfully");
                } catch (error) {
                  showSnackBar(context, error.toString());
                }
              },
              icon: Icon(
                Icons.logout,
                size: 30,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          ShowResults(
            title: "Upcomming Movies",
            results: upcommingMovies,
          ),
          ShowResults(
            title: "Trending Movies",
            results: trendingMovies,
          ),
          ShowResults(
            title: "Top Rated Movies",
            results: topRatedMovies,
          ),
          ShowResults(
            title: "Trending On Google",
            results: popularMovies,
          ),
        ],
      ),
    );
  }
}
