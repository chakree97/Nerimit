import 'package:flutter/material.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/widget/texttheme.dart';

class MovieList extends StatelessWidget {
  const MovieList(
    { 
      Key? key ,
      required this.movie,
      required this.moviebackground,
      required this.movietrailer,
      required this.moviehead,
      required this.rating,
      required this.view,
      required this.type,
      required this.directors,
      required this.actor,
      required this.description,
      required this.full
    }
  ) : super(key: key);

  final String movie;
  final String moviebackground;
  final String movietrailer;
  final String moviehead;
  final List<String> type;
  final double rating;
  final int view;
  final List<String> directors;
  final List<String> actor;
  final String description;
  final String full;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: InkWell(
        child: Container(
          width: 150,
          height: 300,
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(moviehead),
                    fit: BoxFit.cover
                  )
                ),
              ),
              SpaceGap(5, AxisType.vertical),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextWhite(movie,14),
                  ],
                ),
              ),
              SpaceGap(5, AxisType.vertical),
              Row(
                children: [
                  const Icon(
                    Icons.visibility,
                    size: 10,
                    color: Color(0xff00ccff),
                  ),
                  TextWhite('${view}',12),
                  Expanded(child: SpaceGap(0.001, AxisType.horizontal)),
                  const Icon(Icons.star_rate,color: Colors.amber,size: 14,),
                  SpaceGap(2, AxisType.horizontal),
                  TextWhite('${rating}',12),
                  TextWhite('/10',10),
                ],
              )
            ],
          ),
        ),
        onTap: (){
          NavigatorToMovieDetail(context, movie, moviebackground,movietrailer, moviehead, type, view, rating, directors, actor, description,full);
        },
      )
    );
  }
}

class MovieListAddtoChart extends StatelessWidget {
  const MovieListAddtoChart({ Key? key ,required this.movieList}) : super(key: key);
  final MovieList movieList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          movieList,
          InkWell(
            onTap: (){

            },
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Container(
                width: 146,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.white
                  )
                ),
                child: Center(
                  child: AddtoCart(14),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}

class MovieListMini extends StatelessWidget {
  const MovieListMini(
    { 
      Key? key ,
      required this.movie,
      required this.moviebackground,
      required this.movietrailer,
      required this.moviehead,
      required this.rating,
      required this.view,
      required this.type,
      required this.directors,
      required this.actor,
      required this.description,
      required this.full
    }
  ) : super(key: key);

  final String movie;
  final String moviebackground;
  final String movietrailer;
  final String moviehead;
  final List<String> type;
  final double rating;
  final int view;
  final List<String> directors;
  final List<String> actor;
  final String description;
  final String full;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 150,
        height: 300,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(moviehead),
                  fit: BoxFit.cover
                )
              ),
            ),
            SpaceGap(5, AxisType.vertical),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: TextWhite(movie,14),
            ),
            SpaceGap(5, AxisType.vertical),
            Row(
              children: [
                const Icon(
                  Icons.visibility,
                  size: 10,
                  color: Color(0xff00ccff),
                ),
                TextWhite('${view}',12),
                Expanded(child: SpaceGap(0.001, AxisType.horizontal)),
                const Icon(Icons.star_rate,color: Colors.amber,size: 14,),
                SpaceGap(2, AxisType.horizontal),
                TextWhite('${rating}',12),
                TextWhite('/10',10),
              ],
            )
          ],
        ),
      ),
      onTap: (){
        NavigatorToMovieDetail(context, movie, moviebackground,movietrailer, moviehead, type, view, rating, directors, actor, description, full);
      },
    );
  }
}

class MovieListExpired extends StatelessWidget {
  const MovieListExpired(
    { 
      Key? key ,
      required this.movie,
      required this.moviebackground,
      required this.movietrailer,
      required this.moviehead,
      required this.rating,
      required this.view,
      required this.type,
      required this.directors,
      required this.actor,
      required this.description,
      required this.full,
      required this.datetime
    }
  ) : super(key: key);

  final String movie;
  final String moviebackground;
  final String movietrailer;
  final String moviehead;
  final List<String> type;
  final double rating;
  final int view;
  final List<String> directors;
  final List<String> actor;
  final String description;
  final String full;
  final String datetime;

  @override
  Widget build(BuildContext context) {
    bool? expired;
    DateTime now = DateTime.now();
    final d = now.day;
    final m = now.month;
    final y = now.year;
    if(datetime != "Unlimit"){
      var ref = datetime.split('-');
      if(int.parse(ref[2]) > y){
        expired = false;
      }
      else if(int.parse(ref[2]) == y){
        if(int.parse(ref[1]) > m){
          expired = false;
        }
        else if(int.parse(ref[1]) == m){
          if(int.parse(ref[0]) > d){
            expired = false;
          }
          else if(int.parse(ref[0]) == d){
            expired = false;
          }
          else{
            expired = true;
          }
        }
        else{
          expired = true;
        }
      }
      else{
        expired = true;
      }
    }
    else{
      expired = false;
    }

    return InkWell(
      child: Container(
        width: 150,
        height: 300,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(moviehead),
                  fit: BoxFit.cover
                )
              ),
            ),
            SpaceGap(5, AxisType.vertical),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: TextWhite(movie,14),
            ),
            SpaceGap(5, AxisType.vertical),
            Row(
              children: [
                const Icon(
                  Icons.visibility,
                  size: 10,
                  color: Color(0xff00ccff),
                ),
                TextWhite('${view}',12),
                Expanded(child: SpaceGap(0.001, AxisType.horizontal)),
                const Icon(Icons.star_rate,color: Colors.amber,size: 14,),
                SpaceGap(2, AxisType.horizontal),
                TextWhite('${rating}',12),
                TextWhite('/10',10),
              ],
            ),
            SpaceGap(5, AxisType.vertical),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 10,
                    color: Color(0xff00ccff),
                  ),
                  SpaceGap(2,AxisType.horizontal),
                  (expired ? 
                    TextRed("Expires:${datetime}", 10):
                    TextWhite("Expires after:${datetime}", 10)
                  )
                ],
              )
            ),
          ],
        ),
      ),
      onTap: (){
        NavigatorToMovieDetail(context, movie, moviebackground,movietrailer, moviehead, type, view, rating, directors, actor, description, full);
      },
    );
  }
}