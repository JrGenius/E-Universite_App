import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:webinar/app/widgets/main_widget/home_widget/single_course_widget/full_screen_video_player.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/common/utils/download_manager.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../../../common/common.dart';

class CourseVideoPlayer extends StatefulWidget {
  final String url;
  final String imageCover;
  
  final bool isLoadNetwork;
  final String? localFileName;
  final RouteObserver<ModalRoute<void>> routeObserver;

  const CourseVideoPlayer(this.url, this.imageCover,this.routeObserver, {this.isLoadNetwork = true, this.localFileName, super.key});
  

  @override
  State<CourseVideoPlayer> createState() => _CourseVideoPlayerState();
}

class _CourseVideoPlayerState extends State<CourseVideoPlayer>  with RouteAware {

  late VideoPlayerController controller;
  bool isShowPlayButton=false;
  bool isPlaying=true;

  Duration videoDuration = const Duration(seconds: 0);
  Duration videoPosition = const Duration(seconds: 0);


  bool isShowVideoPlayer = false;

  @override
  void initState() {
    super.initState();
    initVideo();
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


  initVideo() async {
    
    if(widget.isLoadNetwork){
      controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
      )..initialize().then((_) {
        
        isShowVideoPlayer = true;
        
        controllerListener();
        setState(() {});
        controller.play();
      });
    }else{
      
      String directory = (await getApplicationSupportDirectory()).path;
      print('${directory.toString()}/${widget.localFileName}');
      
      bool isExistFile = await DownloadManager.findFile(directory, widget.localFileName!,isOpen: false);


      if(isExistFile){

        controller = VideoPlayerController.file(
          File('${directory.toString()}/${widget.localFileName}'),
        )..initialize().then((_) {
          print('33333');
          isShowVideoPlayer = true;

          controllerListener();
          setState(() {});
          controller.play();
        });
      }
    }

  }

  controllerListener(){
    controller.addListener(() {

      if(mounted){
        if(controller.value.isPlaying){

          if(!isPlaying){
            setState(() {
              isPlaying = true;
              isShowPlayButton = true;
            });

            Future.delayed(const Duration(milliseconds: 1500)).then((value) {
              setState(() {
                isShowPlayButton = false;
              });
            });
          }

        }else{

          if(isPlaying){
            setState(() {
              isPlaying = false;
              isShowPlayButton = true;
            });

            Future.delayed(const Duration(milliseconds: 1500)).then((value) {
              setState(() {
                isShowPlayButton = false;
              });
            });
          }
        }

        if(videoPosition.inSeconds != controller.value.position.inSeconds){
          log("duration: ${controller.value.duration.inSeconds.toString()}  position: ${controller.value.position.inSeconds.toString()}");

          setState(() {
            videoPosition = Duration(seconds: controller.value.position.inSeconds);
          });
        }


        if(videoDuration.inSeconds != controller.value.duration.inSeconds){
          setState(() {
            videoDuration = Duration(seconds: controller.value.duration.inSeconds);
          });
        }
      }
      
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // video
        if(isShowVideoPlayer)...{
          ClipRRect(
            borderRadius: borderRadius(),
            child: controller.value.isInitialized
          ? Stack(
              children: [

                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),

                // play or pouse button
                Positioned.fill(
                  child: GestureDetector(
                    onTap: (){
                      
                      if(isPlaying){
                        controller.pause();
                      }else{
                        controller.play();
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: isShowPlayButton ? 1.0 : 0.0, 
                        duration: const Duration(milliseconds: 400),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(.3)
                          ),

                          child: Icon(
                            !isPlaying ? Icons.play_arrow_rounded : Icons.pause_rounded,
                            color: Colors.white,
                            size: 35,
                          ),

                        ),
                      ),
                    ),
                  ),
                ),

              ],
            )
          : AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                widget.imageCover,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppAssets.placePng,
                    width: getSize().width,
                    height: getSize().width,
                  );
                },
              ),
            ),
          ),
        
          space(12),

          AnimatedCrossFade(

            firstChild: Container(
              padding: padding(horizontal: 16,vertical: 16),
              width: getSize().width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius()
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  // duration and play button
                  Row(
                    children: [

                      GestureDetector(
                        onTap: (){
                          if(isPlaying){
                            controller.pause();
                          }else{
                            controller.play();
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: greyE7,
                            )
                          ),
                          child: Icon(!isPlaying ? Icons.play_arrow_rounded : Icons.pause, size: 17,),
                        ),
                      ),

                      space(0,width: 16),
                      
                      Text(
                        '${secondDurationToString(videoPosition.inSeconds)} / ${secondDurationToString(videoDuration.inSeconds)}',
                        style: style12Regular().copyWith(color: greyB2),
                      ),

                    ],
                  ),



                  Row(
                    children: [
                      
                      // sound
                      GestureDetector(
                        onTap: (){
                          if(controller.value.volume == 0.0){
                            controller.setVolume(1.0);
                          }else{
                            controller.setVolume(0.0);
                          }

                          setState(() {});
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SvgPicture.asset(
                          controller.value.volume == 0.0 ? AppAssets.soundOffSvg : AppAssets.soundOnSvg
                        ),
                      ),

                      space(0,width: 22),

                      // full screen
                      GestureDetector(
                        onTap: () async {
                          controller.pause();
                          
                          await navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => FullScreenVideoPlayer(controller)));

                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                          ]);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SvgPicture.asset(
                          AppAssets.fullscreenSvg
                        ),
                      ),

                    ],
                  )

                ],
              ),

            ), 

            secondChild: SizedBox(width: getSize().width), 
            crossFadeState: controller.value.isInitialized ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
            duration: const Duration(milliseconds: 300)
          )
        
        },


      ],
    );
  }



}