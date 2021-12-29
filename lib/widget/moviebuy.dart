import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:movies/db/summary.dart';
import 'package:movies/main.dart';
import 'package:movies/provider/providersummary.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/widget/texttheme.dart';
import 'package:provider/provider.dart';

class Moviebuy extends StatelessWidget {
  const Moviebuy(
    { 
      Key? key,
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
      required this.full,
      required this.buy,
      required this.index
    }
  ) : super(key: key);

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
  final String buy;
  final int index;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Box<summary> box = Hive.box<summary>(MyBox);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> BuyRentList()
        ),
      ],
      builder: (context,child){
        return Container(
          width: width,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(head),
                    fit: BoxFit.cover
                  )
                ),
              ),
              SpaceGap(15, AxisType.horizontal),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWhite(name, 14),
                  DropdownButton<String>(
                      value: context.watch<BuyRentList>().checkMethod(index),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Color(0xff00ccff)),
                      onChanged: (String? newValue) {
                        box.putAt(
                          index,
                          summary(
                            name: name,
                            background: background,
                            head: head,
                            rating: rating,
                            type: type,
                            view: view,
                            trailer: trailer,
                            director: director,
                            actor: actor,
                            description: description,
                            full: full,
                            buy: newValue!
                          )
                        );
                        context.read<BuyRentList>().toggleMethod(newValue);
                      },
                      items: <String>['Buy', 'Rent']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  Row(
                    children: (context.watch<BuyRentList>().checkMethod(index) == "Buy")?
                    [
                        TextOrange("B 500", 16)
                      ]:
                      [
                        TextOrange("B 300", 16)
                      ]
                    // (
                    //   (box.length > 1)?[
                    //     TextGrey("฿ 500", 12),
                    //     SpaceGap(10, AxisType.horizontal),
                    //     TextOrange("B 450", 16)
                    //   ]:[
                    //     TextOrange("B 500", 16)
                    //   ]
                    // ):[ 
                    //   TextOrange("B 300", 16)
                    // ],
                  )
                ],
              ),
              Expanded(child: SpaceGap(0.001, AxisType.horizontal)),
              IconButton(
                onPressed: (){
                  SureDelete(context,index);
                }, 
                icon: const FaIcon(FontAwesomeIcons.trashAlt),
                iconSize: 20,
                color: Colors.white54,
              ),
            ],
          ),
        );
      },
    );
  }
}

void SureDelete(BuildContext context,int index){
    showDialog(
    context: context, 
    builder: (context){
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> BuyRentList())
        ],
        builder: (context,child){
          return AlertDialog(
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
            title: TextWhite("Are you sure delete?", 16),
            actions: [
              InkWell(
                child: Textblue("Ok", 12),
                onTap: (){
                  Box<summary> box = Hive.box<summary>(MyBox);
                  box.deleteAt(index);
                  NavigatorOrderSummaryPage(context);
                },
              ),
              InkWell(
                child: Textblue("Cancel", 12),
                onTap: (){
                  context.read<BuyRentList>().deletelist();
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }
  );
}