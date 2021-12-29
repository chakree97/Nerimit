import 'package:flutter/material.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/movielist.dart';
import 'package:movies/widget/movietitle.dart';
import 'package:movies/widget/texttheme.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xff303030),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            color: const Color(0xff00ccff),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: TextWhite("GENRE", 18),
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
          FutureBuilder(
            future: fetchMovieAll(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return Container(
                  width: width,
                  height: height*0.25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (contxt,index){
                      return InkWell(
                        child: MovieTitle(
                          width: width*0.85,
                          height: height*0.25,
                          type: snapshot.data[index].type,
                          movie: snapshot.data[index].name,
                          moviebackground: snapshot.data[index].background,
                          moviehead: snapshot.data[index].head,
                          rating: snapshot.data[index].rating,
                          movietrailer: snapshot.data[index].trailer,
                          actor: snapshot.data[index].actor,
                          view: snapshot.data[index].view,
                          description: snapshot.data[index].description,
                          directors: snapshot.data[index].director,
                          full: snapshot.data[index].full,
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
                  )
                );
              }
              else{
                return Container(
                  width: width,
                  height: height*0.25,
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }
          ),
          SpaceGap(height*0.005, AxisType.vertical),
          ListTile(
            leading: TextWhite("NEW RELEASE",16),
            trailing: InkWell(
              child: Textblue("VIEW ALL", 12),
              onTap: (){
                NavigatorNewReleasePage(context);
              },
            )
          ),
          FutureBuilder(
            future: fetchNewMovie(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return Container(
                  width: width,
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context,index){
                      return MovieList(
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
                      );
                    }
                  ),
                );
              }
              else{
                return Container(
                  width: width,
                  height: 300,
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }
          ),
          ListTile(
            leading: TextWhite("MOST WATCHED",16),
            trailing: InkWell(
              child: Textblue("VIEW ALL", 12),
              onTap: (){
                NavigatorMostViewPage(context);
              },
            )
          ),
          FutureBuilder(
            future: fetchMostViewMovie(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return Container(
                  width: width,
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context,index){
                      return MovieList(
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
                      );
                    }
                  ),
                );
              }
              else{
                return Container(
                  width: width,
                  height: 300,
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        enableFeedback: false,
        items: const [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "HOME",

          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: "SEARCH"
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.collections),
            label: "COLLECTION"
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.restore_sharp),
            label: "RECENTLY"
          ),
        ],
      )
    );
  }
}
