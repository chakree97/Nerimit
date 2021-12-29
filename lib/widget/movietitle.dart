import 'package:flutter/material.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/widget/texttheme.dart';

class MovieTitle extends StatelessWidget {
  const MovieTitle(
    { Key? key ,
    required this.width,
    required this.height,
    required this.movie,
    required this.moviebackground,
    required this.movietrailer,
    required this.moviehead,
    required this.type,
    required this.rating,
    required this.view,
    required this.directors,
    required this.actor,
    required this.description,
    required this.full
    }
  ) : super(key: key);
  final double width;
  final double height;
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
    List<Widget> _type = [];
    for (var i =0;i<type.length;i++) {
      _type.add(TypeMoviceTitle(type[i]));
    }
    return Container(
      width: width,
      height: height,
      color: Colors.black,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: width-10,
              height: height*0.65,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(moviebackground),
                  fit: BoxFit.cover
                )
              ),
            )
          ),
          Positioned(
            left: 10,
            top: height*0.4,
            child: Container(
              width: 75,
              height: 100,
               decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(moviehead),
                  fit: BoxFit.cover
                )
              ),
            )
          ),
          Positioned(
            left: 100,
            top: height*0.43,
            child: TextWhite(movie, 16)
          ),
          Positioned(
            left: 100,
            top: height*0.59,
            child: Row(
              children: _type,
            ),
          ),
          Positioned(
            left: 108,
            top: height*0.75,
            child: RatingScore(rating)
          ),
          Positioned(
            left: 180,
            top: height*0.75,
            child: TrailerButton(context, movie,moviebackground,movietrailer,moviehead,type,rating,view,directors,actor,description,full)
          )
        ],
      ),
    );
  }
}

Widget TypeMoviceTitle(String text){
  return Padding(
    padding: EdgeInsets.only(right: 8),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white)
      ),
      child: Center(
        child: TextWhite(text,12),
      )
    ),
  );
}

Widget RatingScore(double score){
  return Container(
    height: 40,
    child: Column(
      children: [
        Row(
          children: [
            TextWhite("${score}", 18),
            TextWhite("/10", 14)
          ],
        ),
        Expanded(child: SpaceGap(0.001, AxisType.vertical)),
        Textblue("RATING", 8)
      ],
    ),
  );
}

// Widget TrailerButton(BuildContext context,String url){
//   return InkWell(
//     child: Container(
//       height: 40,
//       child: Column(
//         children: [
//           const Icon(
//             Icons.play_arrow,
//             color: Colors.white,
//             size: 28,
//           ),
//           Expanded(child: SpaceGap(0.001, AxisType.vertical)),
//           Textblue("TRAILER", 8)
//         ],
//       ),
//     ),
//     onTap: (){
//       NavigatorToPlayMovie(context, url);
//     },
//   );
// }


Widget TrailerButton(
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
  return InkWell(
    child: Container(
      height: 40,
      child: Column(
        children: [
          const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 28,
          ),
          Expanded(child: SpaceGap(0.001, AxisType.vertical)),
          Textblue("TRAILER", 8)
        ],
      ),
    ),
    onTap: (){
      NavigatorToPlayMovie(context, movie,moviebackground,movietrailer,moviehead,type,rating,view,directors,actor,description,full);
    },
  );
}