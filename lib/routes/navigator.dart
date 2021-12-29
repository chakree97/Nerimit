import 'package:flutter/material.dart';
import 'package:movies/log/auth.dart';
import 'package:movies/screens/addslip.dart';
import 'package:movies/screens/collection.dart';
import 'package:movies/screens/confirmsummary.dart';
import 'package:movies/screens/favoritepage.dart';
import 'package:movies/screens/home.dart';
import 'package:movies/screens/loginpage.dart';
import 'package:movies/screens/mostview.dart';
import 'package:movies/screens/moviedetail.dart';
import 'package:movies/screens/newrelease.dart';
import 'package:movies/screens/orderhistory.dart';
import 'package:movies/screens/ordersummary.dart';
import 'package:movies/screens/playmovie.dart';
import 'package:movies/screens/recentlypage.dart';
import 'package:movies/screens/settings.dart';
import 'package:movies/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PageRouting{
  Home,
  PlayMovie
}

void NavigatorPage(BuildContext context){
  Navigator.pushAndRemoveUntil<dynamic>(
    context,
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => const Home(),
    ),
    (route) => false,
  );
}

void NavigatorNewReleasePage(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NewRelease()),
  );
}

void NavigatorMostViewPage(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MostView()),
  );
}

void NavigatorToPlayMovie(
  BuildContext context,
  String movie,
  String moviebackground,
  String movietrailer,
  String moviehead,
  List<String> type,
  double rating,
  int view,
  List<String> directors,
  List<String> actor,
  String description,
  String full
){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => 
      PlayMovie(
        movie: movie,
        moviebackground: moviebackground,
        movietrailer: movietrailer,
        moviehead: moviehead,
        type: type,
        rating: rating,
        view: view,
        directors: directors,
        actor: actor,
        description: description,
        full: full,
      )
    ),
  );
}

void NavigatorToMovieDetail(
  BuildContext context,
  String title,
  String background,
  String trailer,
  String head,
  List<String> type,
  int view,
  double rating,
  List<String> directors,
  List<String> actor,
  String description,
  String full
){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => 
        MovieDetail(title: title, background: background, trailer: trailer,head: head, type: type, view: view, rating: rating, directors: directors, actor: actor, description: description,full: full)
    ),
  );
}

void NavigatorLoginPage(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}

void NavigatorSettingPage(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SettingPage()),
  );
}

void NavigatorFavoritePage(BuildContext context) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool islogin = preferences.getBool('islogin') ?? false;
  if(islogin){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoritePage()),
    );
  }
  else{
    NavigatorLoginPage(context);
  }
}

void NavigatorCollectionPage(BuildContext context) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool islogin = preferences.getBool('islogin') ?? false;
  if(islogin){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CollectionPage()),
    );
  }
  else{
    NavigatorLoginPage(context);
  }
}

void NavigatorOrderSummaryPage(BuildContext context) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool islogin = preferences.getBool('islogin') ?? false;
  if(islogin){
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const OrderSummary(),
      ),
      (route) => false,
    );
  }
  else{
    NavigatorLoginPage(context);
  }
}

void NavigatorComfirmSummary(BuildContext context){
   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfirmSummary()),
    );
}

void NavigatorOrderHistory(BuildContext context){
   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderHistory()),
    );
}

void NavigatorSignUpPage(BuildContext context){
   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
}

void NavigatorAddSlipPage(BuildContext context){
   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSlip()),
    );
}

void NavigatorRecentlyPage(BuildContext context){
   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecentlyPage()),
    );
}