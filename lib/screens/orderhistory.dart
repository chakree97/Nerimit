import 'package:flutter/material.dart';
import 'package:movies/log/auth.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/texttheme.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWhite("Order History", 16),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: GetOrderHistory(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data[index].head),
                        fit: BoxFit.fill
                      ),
                      border: Border.all(
                        color: Colors.white60
                      )
                    ),
                  ),
                  title: TextWhite(snapshot.data[index].name, 16),
                  subtitle: Textblue("Date of purchase : ${snapshot.data[index].date}", 12),
                  trailing: IconButton(
                    onPressed: (){
                      print(snapshot.data.length-index-1);
                      messagedeletehsitory(context,snapshot.data.length-index-1);
                    },
                    icon: const Icon(Icons.delete)
                  ),
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