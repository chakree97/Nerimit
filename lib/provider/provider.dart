import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/account.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:provider/provider.dart';

class favoriteMovie with ChangeNotifier,DiagnosticableTreeMixin{
  favoriteMovie({required this.init});
  bool init;
  bool get toggle => init;
  void toggleFavorite(){
    init = !init;
    notifyListeners();
  }

  bool getState(){
    notifyListeners();
    return init;
  }
}

Account account = Account();

class Favorite extends StatelessWidget {
  const Favorite(
    { 
      Key? key,
      required this.logic,
      required this.name,
      required this.background,
      required this.head,
      required this.rating,
      required this.type,
      required this.view,
      required this.trailer,
      required this.director,
      required this.actor,
      required this.description,
      required this.full
    }
  ) : super(key: key);
  final bool logic;
  final String name;
  final String background;
  final String head;
  final double rating;
  final List<String> type;
  final int view;
  final String trailer;
  final List<String> director;
  final List<String> actor;
  final String description;
  final String full;
  
  @override
  Widget build(BuildContext context) {
    getAccount();
    return InkWell(
      onTap: () async {
       if(account.islogin!){
         bool check = context.read<favoriteMovie>().getState();
         print(check);
         if(!check){
           String message = await FavoriteClick(name, background, head, rating, type, view, trailer, director, actor, description, full);
           if(message == "ok"){
             context.read<favoriteMovie>().toggleFavorite();
           }
         }
         else{
           String message = await UnFavoriteClick(name, background, head, rating, type, view, trailer, director, actor, description, full);
           if(message == "ok"){
             context.read<favoriteMovie>().toggleFavorite();
           }
         }
       }
       else{
         NavigatorLoginPage(context);
       }
      },
      child: Icon((context.watch<favoriteMovie>().toggle)?(Icons.favorite):(Icons.favorite_border),color: Colors.red,size: 14,),
    );
  }
  getAccount() async{
    account.username = await GetUsername();
    account.password = await GetPassword();
    account.islogin = await CheckLogin();
  }
}

