import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/common/data/app_language.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/locator.dart';
import '../config/assets.dart';



final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Widget loading({Color? color,double stroke = 3.5,int radius=12}){
  return Center(
    child: CupertinoActivityIndicator(
      color: color ?? Colors.green,
      radius: radius.toDouble(),
    ),
  );
}

Widget space(double height,{double width = 0}){
  return SizedBox(
    height: height,
    width: width,
  );
}


nextRoute(String page,{bool isClearBackRoutes=false,dynamic arguments}) async {

  if(isClearBackRoutes){
    return await Navigator.pushNamedAndRemoveUntil(
      navigatorKey.currentContext!,
      page,
      (route) => false,
      arguments: arguments
    );
  }else{
    return await Navigator.pushNamed(
      navigatorKey.currentContext!,
      page,
      arguments: arguments
    );
  }

}

backRoute({dynamic arguments}){
  navigatorKey.currentState!.pop(arguments);
}


baseBottomSheet({required Widget child}) async {
  return await showModalBottomSheet(
    isScrollControlled: true,
    context: navigatorKey.currentContext!, 
    backgroundColor: Colors.transparent,
    builder: (context) {
      return directionality(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: (){
              backRoute();
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                
                Padding(
                  padding: padding(),
                  child: closeButton(AppAssets.arrowClearSvg),
                ),
          
                space(16),
          
                GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    width: getSize().width,
                  
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      color: Colors.white,
                    ),
                    
                    child: child,
                  ),
                ),
          
              ],
            ),
          ),
        ),
      );
    },
  );
}


Size getSize(){
  return MediaQuery.of(navigatorKey.currentContext!).size;
}

Widget fadeInImage(String url,double width,double height,){
  // return FadeInImage.assetNetwork(
  //   placeholder: AppAssets.placePng, 
  //   image: url,
  //   width: width.toDouble(),
  //   height: height.toDouble(),
  //   fit: BoxFit.cover,
  //   imageErrorBuilder: (context, error, stackTrace) {

  //     return Container(
  //       height: 200,
  //       color: Colors.grey.shade900,
  //     );
  //   },
  // );

  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => Image.asset(AppAssets.placePng, width: width.toDouble(), height: height.toDouble(), fit: BoxFit.cover),

    width: width.toDouble(),
    height: height.toDouble(),
    fit: BoxFit.cover,

    errorWidget: (context, url, _) => Image.asset(AppAssets.placePng, width: width.toDouble(), height: height.toDouble(), fit: BoxFit.cover),
  );
}

Widget closeButton(String icon,{Function onTap=backRoute,double? width, Color? icColor}){
  return GestureDetector(
    onTap: (){
      onTap();
    },
    behavior: HitTestBehavior.opaque,
    child: Container(
      width: 52,
      height: 52,
  
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius()
      ),
      alignment: Alignment.center,
  
      child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode( icColor ?? grey3A, BlendMode.srcIn), width: width),
    ),
  );
}


// Widget fadeImage(String path, double width, double height,{int borderRadius=0}){
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(borderRadius.toDouble()),
//     child: FadeInImage(
//       placeholder: const AssetImage(AppAssets.placePng),
//       image: NetworkImage(path),
//       width: width,
//       height: height,
//       fit: BoxFit.cover,
//       imageErrorBuilder: (context, error, stackTrace) {
//         return Image.asset(AppAssets.placePng,width: width,height: height,fit: BoxFit.cover);
//       },
//     ),
//   );
// }

BorderRadius borderRadius({double radius=20}){
  return BorderRadius.circular(radius);
}

EdgeInsets padding({double horizontal= 21, double vertical = 0}){
  return EdgeInsets.symmetric(horizontal: horizontal,vertical: vertical);
}


Directionality directionality({required Widget child}){
  return Directionality(
    textDirection: locator<AppLanguage>().isRtl() ? TextDirection.rtl : TextDirection.ltr,
    child: child
  );
}


class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
    mass: 1,
    stiffness: 100,
    damping: 13.8,
  );
}

class RoundedTabIndicator extends Decoration {
  RoundedTabIndicator({
    Color color = Colors.black,
    double radius = 100.0,
    double width = 22.0,
    double height = 4.0,
    double bottomMargin = 0.0,
  }) : _painter = _RoundedRectanglePainter(
          color,
          width,
          height,
          radius,
          bottomMargin,
        );

  final BoxPainter _painter;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _RoundedRectanglePainter extends BoxPainter {
  _RoundedRectanglePainter(
    Color color,
    this.width,
    this.height,
    this.radius,
    this.bottomMargin,
  ) : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  final Paint _paint;
  final double radius;
  final double width;
  final double height;
  final double bottomMargin;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final centerX = (cfg.size?.width ?? 0) / 2 + offset.dx;
    final bottom = (cfg.size?.height) ?? 0 - bottomMargin;
    final halfWidth = width / 2;
    
    canvas.drawRRect(
      RRect.fromLTRBR(
        centerX - halfWidth,
        bottom - height,
        centerX + halfWidth,
        bottom,
        Radius.circular(radius),
      ),
      _paint,
    );
    
  }
}


class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;

  const MarqueeWidget({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 6000),
    this.backDuration = const Duration(milliseconds: 6000),
    this.pauseDuration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0);
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( 
      physics: const NeverScrollableScrollPhysics(),
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: Curves.ease,
        );
      }
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          0.0,
          duration: widget.backDuration,
          curve: Curves.easeOut,
        );
      }
    }
  }
}


