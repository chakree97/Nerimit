import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:movies/provider/provider.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/texttheme.dart';
import 'package:provider/provider.dart';
// import 'package:better_player/better_player.dart';
import 'package:video_player/video_player.dart';

class PlayMovie extends StatefulWidget {
  const PlayMovie(
    { Key? key,
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
  _PlayMovieState createState() => _PlayMovieState();
}

class _PlayMovieState extends State<PlayMovie> {
  late VideoPlayerController _videoPlayerController1;
  // late VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;
  @override
  void initState(){
    super.initState();
    initializePlayer();
  }

  @override
  void dispose(){
    super.dispose();
    _videoPlayerController1.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
      widget.full
      // "https://ideal.ruk-com.cloud/SF/96330/7917-6201.mp4.m3u8"
    );
    await Future.wait([
      _videoPlayerController1.initialize()
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 16/9,
      autoInitialize: true,
      allowFullScreen: true,
      // looping: true,
      errorBuilder: (context,errorMessage){
        return Center(
          child: Text(errorMessage),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: TextWhite(widget.movie, 18),
      ),
      body: FutureBuilder(
        future: CheckFavorite(widget.movie),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_)=>favoriteMovie(
                    init: snapshot.data as bool
                  )
                )
              ],
              child: OrientationBuilder(
                builder: (context, orientation){
                  if(orientation == Orientation.portrait){
                    return Column(
                      children: [
                        Container(
                          width: width,
                          height: height*0.3,
                          color: Colors.black,
                          child: (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized)?
                            Chewie(controller: _chewieController!):
                            const Center(
                              child: CircularProgressIndicator(),
                            )
                        ),
                        ExpansionTile(
                          childrenPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          title: TextWhite(widget.movie, 16),
                          subtitle: Row(
                            children: [
                              const Icon(
                                Icons.visibility,
                                size: 10,
                                color: Color(0xff00ccff),
                              ),
                              SpaceGap(5, AxisType.horizontal),
                              TextWhite('${widget.view}',12),
                              SpaceGap(15, AxisType.horizontal),
                              const Icon(Icons.star_rate,color: Colors.amber,size: 14,),
                              SpaceGap(5, AxisType.horizontal),
                              TextWhite('${widget.rating}', 12),
                              TextWhite('/10', 12),
                              SpaceGap(15, AxisType.horizontal),
                              Favorite(
                                logic: snapshot.data as bool,
                                name: widget.movie,
                                background: widget.moviebackground,
                                head: widget.moviehead,
                                rating: widget.rating,
                                type: widget.type,
                                view: widget.view,
                                trailer: widget.movietrailer,
                                director: widget.directors,
                                actor: widget.actor,
                                description: widget.description,
                                full: widget.full
                              ),
                              SpaceGap(5, AxisType.horizontal),
                              TextWhite('Favorite', 14),
                            ],
                          ),
                          children: [
                            TextWhite(widget.description, 10)
                          ],
                        )
                      ]
                    );
                  }
                  else{
                    return ListView(
                      children: [
                        Container(
                          width: width*0.6,
                          height: height*0.6,
                          color: Colors.black,
                          child: (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized)?
                            Chewie(controller: _chewieController!):
                            const Center(
                              child: CircularProgressIndicator(),
                            )
                        ),
                        ExpansionTile(
                          childrenPadding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                          title: TextWhite(widget.movie, 16),
                          subtitle: Row(
                            children: [
                              const Icon(
                                Icons.visibility,
                                size: 10,
                                color: Color(0xff00ccff),
                              ),
                              SpaceGap(5, AxisType.horizontal),
                              TextWhite('${widget.view}',12),
                              SpaceGap(15, AxisType.horizontal),
                              const Icon(Icons.star_rate,color: Colors.amber,size: 14,),
                              SpaceGap(5, AxisType.horizontal),
                              TextWhite('${widget.rating}', 12),
                              TextWhite('/10', 12),
                              SpaceGap(15, AxisType.horizontal),
                              Favorite(
                                logic: snapshot.data as bool,
                                name: widget.movie,
                                background: widget.moviebackground,
                                head: widget.moviehead,
                                rating: widget.rating,
                                type: widget.type,
                                view: widget.view,
                                trailer: widget.movietrailer,
                                director: widget.directors,
                                actor: widget.actor,
                                description: widget.description,
                                full: widget.full
                              ),
                              SpaceGap(5, AxisType.horizontal),
                              TextWhite('Favorite', 14),
                            ],
                          ),
                          children: [
                            TextWhite(widget.description, 10)
                          ],
                        )
                      ],
                    );
                  }
                }
              ),
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
