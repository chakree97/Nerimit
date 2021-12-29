import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:movies/db/summary.dart';
import 'package:movies/main.dart';
import 'package:movies/provider/provider.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/movielist.dart';
import 'package:movies/widget/movietitle.dart';
import 'package:movies/widget/playtrailer.dart';
import 'package:movies/widget/texttheme.dart';
import 'package:provider/provider.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail(
    { 
      Key? key ,
      required this.title,
      required this.background,
      required this.trailer,
      required this.head,
      required this.type,
      required this.view,
      required this.rating,
      required this.directors,
      required this.actor,
      required this.description,
      required this.full
    }
  ) : super(key: key);
  final String title;
  final String background;
  final String trailer;
  final String head;
  final List<String> type;
  final int view;
  final double rating;
  final List<String> directors;
  final List<String> actor;
  final String description;
  final String full;

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  
  @override
  Widget build(BuildContext context) {
    print("build scaffold");
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    List<Widget> _type = [];
    List<Widget> _directors = [];
    List<Widget> _actors = [];
    for (var i=0;i<widget.type.length;i++) {
      _type.add(TypeMoviceTitle(widget.type[i]));
    }
    for (var i=0;i<widget.directors.length;i++) {
      _directors.add(Textblue(widget.directors[i],12));
      _directors.add(Padding(padding: EdgeInsets.only(right: 6)));
    }
    for (var i=0;i<widget.actor.length;i++) {
      _actors.add(Textblue(widget.actor[i],12));
      _actors.add(Padding(padding: EdgeInsets.only(right: 6)));
    }
    return FutureBuilder(
      future: CheckFavorite(widget.title),
      builder: (context,snapshot){
        if(snapshot.hasData){
          print("logic = ${snapshot.data}");
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_)=>favoriteMovie(
                  init: snapshot.data as bool
                )
              )
            ],
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                title: TextWhite(widget.title, 18),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: (){
                      
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: (){
                        NavigatorSettingPage(context);
                      },
                    ),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  Container(
                    width: width,
                    height: height*0.32,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: width,
                            height: height*0.25,
                            child: PlayTrailer(
                              trailer: widget.trailer,
                            ),
                            // decoration: BoxDecoration(
                            //   image: DecorationImage(
                            //     image: NetworkImage(widget.background),
                            //     fit: BoxFit.cover
                            //   )
                            // ),
                          ),
                        ),
                        Positioned(
                          top: height*0.16,
                          left: 10,
                          child: Container(
                            width: 80,
                            height: 120,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.head),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                        ),
                        Positioned(
                          top: height*0.27,
                          left: 110,
                          child: Row(
                            children: _type,
                          )
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.visibility,color: Color(0xff00ccff),size: 14,),
                        SpaceGap(5, AxisType.horizontal),
                        TextWhite('${widget.view}', 14),
                        SpaceGap(40, AxisType.horizontal),
                        const Icon(Icons.star_rate,color: Colors.amber,size: 14,),
                        SpaceGap(5, AxisType.horizontal),
                        TextWhite('${widget.rating}', 14),
                        TextWhite('/10', 12),
                        SpaceGap(40, AxisType.horizontal),
                        Favorite(
                          logic: snapshot.data as bool,
                          name: widget.title,
                          background: widget.background,
                          head: widget.head,
                          rating: widget.rating,
                          type: widget.type,
                          view: widget.view,
                          trailer: widget.background,
                          director: widget.directors,
                          actor: widget.actor,
                          description: widget.description,
                          full: widget.full,
                        ),
                        SpaceGap(5, AxisType.horizontal),
                        TextWhite('Favorite', 14),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          child: TextWhite('Directors : ', 14),
                        ),
                        Container(
                          child: Row(
                            children: _directors,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          child: TextWhite('Stars : ', 14),
                        ),
                        Container(
                          child: Row(
                            children: _actors,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 6),
                    child: TextWhite(widget.description, 12),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                    child: Row(
                      children: [
                        TextWhite('Share: ', 14),
                        SpaceGap(8, AxisType.horizontal),
                        const FaIcon(FontAwesomeIcons.facebookF,color: Colors.white,size: 16,),
                        SpaceGap(20, AxisType.horizontal),
                        const FaIcon(FontAwesomeIcons.twitter,color: Colors.white,size: 16,),
                        SpaceGap(20, AxisType.horizontal),
                        const FaIcon(FontAwesomeIcons.line,color: Colors.white,size: 16,),
                      ],
                    )
                  ),
                  SpaceGap(12, AxisType.vertical),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                    child: TextWhite('SPECIAL BUNDLE', 18),
                  ),
                  FutureBuilder(
                    future: fetchMovieAll(),
                    builder: (BuildContext context,AsyncSnapshot snapshot){
                      if(snapshot.hasData){
                        return Container(
                          width: width,
                          height: 360,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context,index){
                              return MovieListAddtoChart(
                                movieList: MovieList(
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
                                )
                              );
                            }
                          ),
                        );
                      }
                      else{
                        return Container(
                          width: width,
                          height: 360,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }
                  ),
                  SpaceGap(16, AxisType.vertical),
                  FutureBuilder(
                    future: CheckCollection(widget.title),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        if(snapshot.data != "No Movie"){
                          if(snapshot.data == "Unlimit"){
                            return InkWell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 0.0
                                ),
                                child: Container(
                                  width: width,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.white
                                    )
                                  ),
                                  child: Center(
                                    child: TextWhite("Play Video", 14),
                                  ),
                                ),
                              ),
                              onTap: ()async{
                                // print("collect");
                                await AddRecently(
                                  widget.title, 
                                  widget.background, 
                                  widget.head, 
                                  widget.rating, 
                                  widget.type, 
                                  widget.view, 
                                  widget.trailer, 
                                  widget.directors, 
                                  widget.actor, 
                                  widget.description, 
                                  widget.full
                                );
                                NavigatorToPlayMovie(
                                    context,
                                    widget.title,
                                    widget.background,
                                    widget.trailer,
                                    widget.head,
                                    widget.type,
                                    widget.rating,
                                    widget.view,
                                    widget.directors,
                                    widget.actor,
                                    widget.description,
                                    widget.full
                                ); 
                              },
                            );
                          }
                          else{
                            bool? expired;
                            DateTime now = DateTime.now();
                            final d = now.day;
                            final m = now.month;
                            final y = now.year;
                            var ref = snapshot.data.toString().split('-');
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
                            if(expired){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 0.0
                                      ),
                                      child: Container(
                                        width: width*0.45,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff33FFFF),
                                              Color(0xff00ccff),
                                            ]
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff33FFFF).withOpacity(0.4),
                                              spreadRadius: 3,
                                              blurRadius: 3,
                                              offset: const Offset(0, 3),
                                            ),
                                          ]
                                        ),
                                        child: Center(
                                          child: TextWhite('฿500 Buy', 16)
                                        ),
                                      ),
                                    ),
                                    onTap: (){
                                      Box<summary> box = Hive.box<summary>(MyBox);
                                      box.add(
                                        summary(
                                          name: widget.title,
                                          background: widget.background,
                                          head: widget.head,
                                          rating: widget.rating,
                                          type: widget.type,
                                          view: widget.view,
                                          trailer: widget.trailer,
                                          director: widget.directors,
                                          actor: widget.actor,
                                          description: widget.description,
                                          full: widget.full,
                                          buy: "Buy"
                                        )
                                      );
                                      NavigatorOrderSummaryPage(context);
                                    },
                                  ),
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 0.0
                                      ),
                                      child: Container(
                                        width: width*0.45-1,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff33FFFF),
                                              Color(0xff00ccff),
                                            ]
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff33FFFF).withOpacity(0.4),
                                              spreadRadius: 3,
                                              blurRadius: 3,
                                              offset: const Offset(0, 3),
                                            ),
                                          ]
                                        ),
                                        child: Center(
                                          child: TextWhite('฿300 Rent', 16)
                                        ),
                                      ),
                                    ),
                                    onTap: (){
                                      Box<summary> box = Hive.box<summary>(MyBox);
                                      box.add(
                                        summary(
                                          name: widget.title,
                                          background: widget.background,
                                          head: widget.head,
                                          rating: widget.rating,
                                          type: widget.type,
                                          view: widget.view,
                                          trailer: widget.trailer,
                                          director: widget.directors,
                                          actor: widget.actor,
                                          description: widget.description,
                                          full: widget.full,
                                          buy: "Rent"
                                        )
                                      );
                                      NavigatorOrderSummaryPage(context);
                                    },
                                  )
                                ],
                              );
                            }
                            else{
                              return InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 0.0
                                  ),
                                  child: Container(
                                    width: width,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Colors.white
                                      )
                                    ),
                                    child: Center(
                                      child: TextWhite("Play Video", 14),
                                    ),
                                  ),
                                ),
                                onTap: ()async{
                                  await AddRecently(
                                    widget.title, 
                                    widget.background, 
                                    widget.head, 
                                    widget.rating, 
                                    widget.type, 
                                    widget.view, 
                                    widget.trailer, 
                                    widget.directors, 
                                    widget.actor, 
                                    widget.description, 
                                    widget.full
                                  );
                                  NavigatorToPlayMovie(
                                    context,
                                    widget.title,
                                    widget.background,
                                    widget.trailer,
                                    widget.head,
                                    widget.type,
                                    widget.rating,
                                    widget.view,
                                    widget.directors,
                                    widget.actor,
                                    widget.description,
                                    widget.full
                                  );
                                },
                              ); 
                            }
                          }
                        }
                        else{
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 0.0
                                  ),
                                  child: Container(
                                    width: width*0.45,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xff33FFFF),
                                          Color(0xff00ccff),
                                        ]
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff33FFFF).withOpacity(0.4),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    ),
                                    child: Center(
                                      child: TextWhite('฿500 Buy', 16)
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Box<summary> box = Hive.box<summary>(MyBox);
                                  box.add(
                                    summary(
                                      name: widget.title,
                                      background: widget.background,
                                      head: widget.head,
                                      rating: widget.rating,
                                      type: widget.type,
                                      view: widget.view,
                                      trailer: widget.trailer,
                                      director: widget.directors,
                                      actor: widget.actor,
                                      description: widget.description,
                                      full: widget.full,
                                      buy: "Buy"
                                    )
                                  );
                                  NavigatorOrderSummaryPage(context);
                                },
                              ),
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 0.0
                                  ),
                                  child: Container(
                                    width: width*0.45-1,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xff33FFFF),
                                          Color(0xff00ccff),
                                        ]
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff33FFFF).withOpacity(0.4),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    ),
                                    child: Center(
                                      child: TextWhite('฿300 Rent', 16)
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Box<summary> box = Hive.box<summary>(MyBox);
                                  box.add(
                                    summary(
                                      name: widget.title,
                                      background: widget.background,
                                      head: widget.head,
                                      rating: widget.rating,
                                      type: widget.type,
                                      view: widget.view,
                                      trailer: widget.trailer,
                                      director: widget.directors,
                                      actor: widget.actor,
                                      description: widget.description,
                                      full: widget.full,
                                      buy: "Rent"
                                    )
                                  );
                                  NavigatorOrderSummaryPage(context);
                                },
                              )
                            ],
                          );
                        }
                      }
                      else{
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 0.0
                            ),
                            child: Container(
                              width: width,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xff33FFFF),
                                    Color(0xff00ccff),
                                  ]
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff33FFFF).withOpacity(0.4),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              ),
                              child: Center(
                                child: AddtoCart(16),
                              ),
                            ),
                          ),
                          onTap: (){
                            print("No future");
                          },
                        );
                      }
                    }
                  )
                ],
              ),
            ),
          );
        }
        else{
          return Scaffold(
            appBar: AppBar(
              title: TextWhite(widget.title, 18),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: (){
                    
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: (){
                      NavigatorSettingPage(context);
                    },
                  ),
                ),
              ],
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
    );
  }
}
