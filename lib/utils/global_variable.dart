import 'package:rabka_movie/screens/home_screen.dart';
import 'package:rabka_movie/screens/local_screen.dart';
import 'package:rabka_movie/screens/movies_screen.dart';
import 'package:rabka_movie/screens/series_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

const apiKey = "b822a913ac91d291333b43feddcaac11";

List<Widget> homeScreenItems = [
  const HomeScreen(),
  const SeriesScreen(),
  const MoviesScreen(),
  const LocalScreen(),
];
