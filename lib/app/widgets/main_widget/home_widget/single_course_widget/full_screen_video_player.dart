import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  
  final VideoPlayerController videoPlayerController;
  const FullScreenVideoPlayer(this.videoPlayerController,{super.key});

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {

  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();

    chewieController = ChewieController(videoPlayerController: widget.videoPlayerController,);

    chewieController.play();
  }


  @override
  void dispose() {
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: true,
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}