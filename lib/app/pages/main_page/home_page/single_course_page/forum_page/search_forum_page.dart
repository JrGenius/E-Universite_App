import 'package:flutter/material.dart';
import 'package:webinar/app/models/forum_model.dart';
import 'package:webinar/app/services/user_service/forum_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';

class SearchForumPage extends StatefulWidget {
  static const String pageName = '/search-forum';
  const SearchForumPage({super.key});

  @override
  State<SearchForumPage> createState() => _SearchForumPageState();
}

class _SearchForumPageState extends State<SearchForumPage> {

  ForumModel? data;
  bool isLoading = true;

  String search = '';

  int? courseId;

  @override
  void initState() {
    
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      search = (ModalRoute.of(context)!.settings.arguments as List)[0];
      courseId = (ModalRoute.of(context)!.settings.arguments as List)[1];

      getData();
    });

  }


  getData() async {
    
    setState(() {
      isLoading = true;
    });
    
    data = await ForumService.getForumData(courseId!, search);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        
        appBar: appbar(
          title: isLoading ? '' : '${data?.forums?.length ?? 0} ${appText.resultsFoundFor} "$search"'
        ),

        body: isLoading
      ? loading()
      : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: padding(),
          child: Column(
            children: [
              
              space(6),

              ...List.generate(data?.forums?.length ?? 0, (index) {
                return forumQuestionItem(data!.forums![index], (){
                  
                  setState(() {});
                });
              }),
              
            ],
          ),
        ),

      )
    );
  }
}