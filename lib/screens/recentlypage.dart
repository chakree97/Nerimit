import 'package:flutter/material.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/playtrailer.dart';
import 'package:movies/widget/texttheme.dart';

class RecentlyPage extends StatelessWidget {
  const RecentlyPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWhite("Recently", 16),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: GetRecently(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data[index].head),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                    title: TextWhite(snapshot.data[index].name, 16),
                    onTap: (){
                      NavigatorToMovieDetail(
                        context, 
                        snapshot.data[index].name, 
                        snapshot.data[index].background, 
                        snapshot.data[index].trailer, 
                        snapshot.data[index].head, 
                        snapshot.data[index].type, 
                        snapshot.data[index].view, 
                        snapshot.data[index].rating, 
                        snapshot.data[index].director, 
                        snapshot.data[index].actor, 
                        snapshot.data[index].description, 
                        snapshot.data[index].full
                      );
                    },
                  ),
                );
              }
            );
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}