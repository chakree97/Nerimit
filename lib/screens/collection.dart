import 'package:flutter/material.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/movielist.dart';
import 'package:movies/widget/texttheme.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWhite("My Collection", 18),
      ),
      body: FutureBuilder(
        future: FetchAllCollection(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            List<Widget> MovieList = [];
            for(var index =0;index <snapshot.data.length;index++){
              MovieList.add(
                MovieListExpired(
                  movie: snapshot.data[index].name,
                  moviebackground: snapshot.data[index].background,
                  movietrailer: snapshot.data[index].trailer,
                  moviehead:  snapshot.data[index].head,
                  rating: snapshot.data[index].rating,
                  type: snapshot.data[index].type,
                  view: snapshot.data[index].view,
                  actor: snapshot.data[index].actor,
                  directors: snapshot.data[index].director,
                  description: snapshot.data[index].description,
                  full: snapshot.data[index].full,
                  datetime: snapshot.data[index].expired
                )
              );
            }
            return GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              childAspectRatio: 1/2.23,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3,
              children: MovieList,
            );
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}