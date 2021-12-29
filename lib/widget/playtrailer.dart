import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayTrailer extends StatefulWidget {
  const PlayTrailer({
     Key? key ,
     required this.trailer
  }) : super(key: key);
  final String trailer;

  @override
  _PlayTrailerState createState() => _PlayTrailerState();
}

class _PlayTrailerState extends State<PlayTrailer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState(){
    _controller = VideoPlayerController.network(widget.trailer);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
    _controller.setVolume(0);
    super.initState();
  }

  @override
  void dispose(){
     _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return Container(
            width: 320,
            height: 160,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          );
        }
        else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}