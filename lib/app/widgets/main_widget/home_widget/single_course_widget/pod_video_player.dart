import 'package:pod_player/pod_player.dart';
import 'package:flutter/material.dart';
import 'package:webinar/common/common.dart';

class PodVideoPlayerDev extends StatefulWidget {
  final String type;
  final String url;
  final RouteObserver<ModalRoute<void>> routeObserver;

  const PodVideoPlayerDev(this.url,this.type, this.routeObserver, {super.key});

  @override
  State<PodVideoPlayerDev> createState() => _VimeoVideoPlayerState();
}

class _VimeoVideoPlayerState extends State<PodVideoPlayerDev> with RouteAware {
  late final PodPlayerController controller;

  @override
  void initState() {
    
    if(widget.type == 'vimeo'){
      controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.vimeo(
          widget.url,
          videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: true,
          ),
        ),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          isLooping: false,
          wakelockEnabled: true,
          videoQualityPriority: [720, 360],
        ),
      );

      controller.initialise();

    }else{
      // widget.type == 'vimeo'
      //     ? PlayVideoFrom.vimeo(widget.url.split('/').last)
      //     : 
      controller = PodPlayerController(
        playVideoFrom: widget.type == 'youtube'
            ? PlayVideoFrom.youtube(widget.url)
            : PlayVideoFrom.network(widget.url),

      )..initialise().then((value){
        setState(() {});
      },onError: (e){});
    }

    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }


  @override
  void dispose() {
    widget.routeObserver.unsubscribe(this);
    controller.dispose();
    super.dispose();
  }

  @override
  void didPush() {}

  @override
  void didPushNext() {
    // final route = ModalRoute.of(context)?.settings.name;
    controller.pause();
  } 

  @override
  void didPopNext() {
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ClipRRect(
        borderRadius: borderRadius(),
        child: SizedBox(
          width: getSize().width,
          child: PodVideoPlayer(controller: controller,),
        ),
      ),
    );
  }
}