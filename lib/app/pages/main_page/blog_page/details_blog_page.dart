import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:webinar/app/models/blog_model.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/app/widgets/main_widget/blog_widget/blog_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/data/app_data.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';


Future<BlogModel> blogCommentProcess(BlogModel blogData) async {

  BlogModel data = BlogModel.fromJson(blogData.toJson());

  for (var comment in blogData.comments ?? []) {
    for (var replay in comment.replies!) {
      data.comments!.removeWhere((element) => element.id == replay.id);
    }
  }

  return data;
} 


class DetailsBlogPage extends StatefulWidget {
  static const String pageName = '/details-blog';
  const DetailsBlogPage({super.key});

  @override
  State<DetailsBlogPage> createState() => _DetailsBlogPageState();
}

class _DetailsBlogPageState extends State<DetailsBlogPage> {

  BlogModel? blogData;

  bool userIsLogin = false;
  bool readData=true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      blogData = ModalRoute.of(context)!.settings.arguments as BlogModel;

      isLogin();

      if(blogData != null){
        compute(blogCommentProcess, blogData!).then((value) {
          blogData = value;

          setState(() {});
        });
      }

    });
  }

  isLogin() async {

    await Future.delayed(const Duration(seconds: 1));
    
    AppData.getAccessToken().then((value) {
      if(value.toString().isNotEmpty){
        setState(() {
          userIsLogin = true;
        });
      } 
    });
  }

  @override
  Widget build(BuildContext context) {

    if(readData){
      blogData = ModalRoute.of(context)!.settings.arguments as BlogModel;
      readData = false;
    }

    return directionality(
      child: Scaffold(
        
        appBar: appbar(
          title: appText.blogPost,
        ),

        body: blogData == null
      ? const SizedBox()
      : Stack(
          children: [

            // details
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: padding(),
          
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
          
                    space(6),
          
                    Text(
                      blogData!.title ?? '',
                      style: style16Bold(),
                    ),
          
                    space(10),
          
                    // date
                    Row(
                      children: [
          
                        SvgPicture.asset(AppAssets.calendarSvg),
          
                        space(0,width: 5),
          
                        Text(
                          timeStampToDate((blogData?.createdAt ?? 0) * 1000),
                          style: style10Regular().copyWith(color: greyA5),
                        ),
                        
                        Text(
                          appText.in_,
                          style: style10Regular().copyWith(color: greyA5),
                        ),
                        
                        Text(
                          blogData!.category ?? '',
                          style: style10Regular().copyWith(color: greyA5),
                        ),
          
                      ],
                    ),
          
                    space(20),
          
                    Hero(
                      tag: blogData!.id!,
                      child: ClipRRect(
                        borderRadius: borderRadius(radius: 15),
                        child: fadeInImage(blogData!.image ?? '', getSize().width, 210)
                      ),
                    ),
          
                    space(20),
          
                    if(blogData!.author != null)...{
                      userProfile(blogData!.author!)
                    },
          
                    space(20),
          
                    HtmlWidget(
                      blogData!.content ?? '',
                      textStyle: style14Regular().copyWith(color: greyA5),
                    ),
                    
                    space(20),
          
                    Text(
                      appText.comments,
                      style: style16Bold(),
                    ),
          
                    space(16),

                    if(blogData!.comments?.isEmpty ?? true)...{
                      
                      Center(
                        child: emptyState(
                          AppAssets.commentsEmptyStateSvg, 
                          appText.noComments, 
                          appText.noCommentsDesc
                        ),
                      ),
                      
                    }else ...{
                      
                      // comments
                      ...List.generate(blogData!.comments?.length ?? 0, (index) {
                        
                        return commentUi(blogData!.comments![index], (){
                          BlogWidget.showOptionDialog(blogData!.id!, blogData!.comments![index].id!,userIsLogin);
                        });
                      }),
                    },
                    
                    
                    
                    space(120),
                  ],
                ),
              ),
            ),


            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: userIsLogin ? 0 : -150,
              child: Container(
                width: getSize().width,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 30
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    boxShadow(Colors.black.withOpacity(.1),blur: 15,y: -3)
                  ],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30))
                ),
                child: button(
                  onTap: (){
                    BlogWidget.showReplayDialog(blogData!.id!, null);
                  }, 
                  width: getSize().width, 
                  height: 52, 
                  text: appText.leaveAComment, 
                  bgColor: green77(), 
                  textColor: Colors.white
                ),
              )
            )
          ],
        ),

      )
    );
  }
}