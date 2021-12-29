import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:movies/db/summary.dart';
import 'package:movies/main.dart';
import 'package:movies/model/modelmovie.dart';
import 'package:shared_preferences/shared_preferences.dart';

const host = '34.124.172.100:3000';

Future<List<Movie>> fetchMovieAll() async{
  var url = Uri.http(host, '/query/recomment');
  var res = await http.get(url);
  if(res.statusCode == 200){
    var result = movieFromJson((res.body));
    return result;
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<List<Movie>> fetchNewMovie() async{
  var url = Uri.http(host, '/query/newvideo');
  var res = await http.get(url);
  if(res.statusCode == 200){
    var result = movieFromJson((res.body));
    // print(result);
    return result;
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<List<Movie>> fetchMostViewMovie() async{
  var url = Uri.http(host, '/query/mostview');
  var res = await http.get(url);
  if(res.statusCode == 200){
    var result = movieFromJson((res.body));
    // print(result);
    return result;
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<String> Login(String user,String pass) async{
  var url = Uri.http(host, '/account/login');
  var res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{
      'username': user,
      'password': pass
    })
  );
  if(res.statusCode == 200){
    var result = jsonDecode(res.body);
    // print(result['message']);
    return result['message'];
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<String> SignUp(String user,String pass,String phone) async{
  var url = Uri.http(host, '/account/signup');
  var res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{
      'username': user,
      'password': pass,
      'phone': phone
    })
  );
  if(res.statusCode == 200){
    var result = jsonDecode(res.body);
    // print(result['message']);
    return result['message'];
  }
  else{
    throw Exception('Failed to download');
  }
} 

Future<String> SignOut(String user) async{
  var url = Uri.http(host, '/account/logout');
  var res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{
      'username': user,
    })
  );
  if(res.statusCode == 200){
    var result = jsonDecode(res.body);
    // print(result['message']);
    return result['message'];
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<List<Movie>> FetchAllFavorite() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = preferences.getString('username') ?? "Sign in";
  var url = Uri.http(host, '/account/query/allfavorite');
  var res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{
      'username': username,
    })
  );
  if(res.statusCode == 200){
    // print(res.body);
    var result = movieFromJson((res.body));
    return result;
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<List<MovieExpires>> FetchAllCollection() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = preferences.getString('username') ?? "Sign in";
  var url = Uri.http(host, '/account/query/allcollection');
  var res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{
      'username': username,
    })
  );
  if(res.statusCode == 200){
    // print(res.body);
    var result = movieexpiresFromJson(res.body);
    return result;
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<bool>CheckFavorite(String name) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = preferences.getString('username') ?? "Sign in";
  var url = Uri.http(host, '/account/query/favorite');
  var res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{
      'username': username,
      'movie': name
    })
  );
  if(res.statusCode == 200){
    var result = jsonDecode(res.body);
    return result['message'];
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<String>CheckCollection(String name) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = preferences.getString('username') ?? "Sign in";
  var url = Uri.http(host, '/account/query/collection');
  var res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{
      'username': username,
      'movie': name
    })
  );
  if(res.statusCode == 200){
    var result = jsonDecode(res.body);
    if(result['expired'] == null){
      return "No Movie";
    }
    else{
      return result['expired'];
    }
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<bool>AddCollection() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = preferences.getString('username') ?? "Sign in";
  var url = Uri.http(host, '/account/collection');
  Box<summary> box = Hive.box<summary>(MyBox);
  final sum = box.length;
  int total;
  List movie = [];
  DateTime dateTime = DateTime.now();
  for(int i=0;i<sum;i++){
    movie.add({
      'name': box.getAt(i)!.name,
      'background': box.getAt(i)!.background,
      'head': box.getAt(i)!.head,
      'rating': box.getAt(i)!.rating,
      'type': box.getAt(i)!.type,
      'view': box.getAt(i)!.view,
      'trailer': box.getAt(i)!.trailer,
      'director': box.getAt(i)!.director,
      'actor': box.getAt(i)!.actor,
      'description': box.getAt(i)!.description,
      'full': box.getAt(i)!.full,
      'expired': (box.getAt(i)!.buy == "Buy")?'Unlimit':'${dateTime.day}-${dateTime.month}-${dateTime.year+1}',
      'date': '${dateTime.day}-${dateTime.month}-${dateTime.year}'
    });
  }
  var res = await http.put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,dynamic>{
      'username': username,
      'movie': movie
    })
  );
  if(res.statusCode == 200){
    var result = jsonDecode(res.body);
    if(result['message'] == "ok"){
      for(int i=0;i<sum;i++){
        box.deleteAt(0);
      }
      return true;
    }
    else{
      return false;
    }
  }
  else{
    return false;
  }
}

Future<String>FavoriteClick(
  String name,
  String background,
  String head,
  double rating,
  List<String> type,
  int view,
  String trailer,
  List<String> director,
  List<String> actor,
  String description,
  String full
) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = preferences.getString('username') ?? "Sign in";
  var url = Uri.http(host, '/account/favorite');
  var res = await http.put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,dynamic>{
      'username': username,
      'movie': {
        'name': name,
        'background': background,
        'head': head,
        'rating': rating,
        'type': type,
        'view': view,
        'trailer': trailer,
        'director': director,
        'actor': actor,
        'description': description,
        'full': full
      }
    })
  );
  if(res.statusCode == 200){
    var result = jsonDecode(res.body);
    // print(result['message']);
    return result['message'];
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<String>UnFavoriteClick(
  String name,
  String background,
  String head,
  double rating,
  List<String> type,
  int view,
  String trailer,
  List<String> director,
  List<String> actor,
  String description,
  String full
) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = preferences.getString('username') ?? "Sign in";
  var url = Uri.http(host, '/account/unfavorite');
  var res = await http.delete(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,dynamic>{
      'username': username,
      'movie': {
        'name': name,
        'background': background,
        'head': head,
        'rating': rating,
        'type': type,
        'view': view,
        'trailer': trailer,
        'director': director,
        'actor': actor,
        'description': description,
        'full':full
      }
    })
  );
  if(res.statusCode == 200){
    var result = jsonDecode(res.body);
    // print(result['message']);
    return result['message'];
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<List<MovieHistory>>GetOrderHistory() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = preferences.getString('username') ?? "Sign in";
  var url = Uri.http(host, '/account/query/history');
  var res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{
      'username': username,
    })
  );
  if(res.statusCode == 200){
    var result = moviehistoryFromJson(res.body);
    return result;
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<String> DeleteHistory(int position) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = preferences.getString('username') ?? "Sign in";
  var url = Uri.http(host, '/account/deletehistory');
  var res = await http.delete(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,dynamic>{
      'username': username,
      'position': position
    })
  );
  if(res.statusCode == 200){
    var result = jsonDecode(res.body);
    return result['message'];
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<List<Movie>> GetRecently() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = preferences.getString('username') ?? "Sign in";
  var url = Uri.http(host, '/account/query/recently');
  var res = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode(<String,dynamic>{
      'username': username,
    }) 
  );
  if(res.statusCode == 200){
    var result = movieFromJson((res.body));
    return result;
  }
  else{
    throw Exception('Failed to download');
  }
}

Future<void> AddRecently(
  String name,
  String background,
  String head,
  double rating,
  List<String> type,
  int view,
  String trailer,
  List<String> director,
  List<String> actor,
  String description,
  String full
) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = preferences.getString('username') ?? "Sign in";
  var url = Uri.http(host, '/account/recently');
  var res = await http.put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,dynamic>{
      'username': username,
      'movie': {
        'name': name,
        'background': background,
        'head': head,
        'rating': rating,
        'type': type,
        'view': view,
        'trailer': trailer,
        'director': director,
        'actor': actor,
        'description': description,
        'full':full
      }
    })
  );
}