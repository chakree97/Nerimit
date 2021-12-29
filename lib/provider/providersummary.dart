import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:movies/db/summary.dart';
import 'package:movies/main.dart';

class BuyRentList with ChangeNotifier,DiagnosticableTreeMixin{
  int? _price;
  late String type;
  String get _type => type;
  int get price => _price!;

  void toggleMethod(String isBuy){
    (isBuy == "Buy")?
      type = "Buy":
      type = "Rent";
    _price = checkPrice();
    notifyListeners();
  }

  String checkMethod(int index){
    Box<summary> box = Hive.box<summary>(MyBox);
    final _type = box.getAt(index);
    _price = checkPrice();
    return _type!.buy;
  }

  summary checkData(int index){
    Box<summary> box = Hive.box<summary>(MyBox);
    final sum = box.getAt(index);
    _price = checkPrice();
    return sum!;
  }

  int checklength(){
    Box<summary> box = Hive.box<summary>(MyBox);
    final sum = box.length;
    _price = checkPrice();
    return sum;
  }

  void deletelist(){
    _price = checkPrice();
    notifyListeners();
  }
}

  int checkPrice(){
    Box<summary> box = Hive.box<summary>(MyBox);
    final sum = box.length;
    int total = 0;
    for(var i=0;i<sum;i++){
      final val = box.getAt(i)!.buy;
      if(val == "Buy"){
        total += 500;
      }
      else{
        total += 300;
      }
    }
    return total;
  }