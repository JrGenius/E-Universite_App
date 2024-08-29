import 'package:flutter/material.dart';
import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/pages/main_page/home_page/search_page/result_search_page.dart';
import 'package:webinar/app/services/guest_service/course_service.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../../../config/assets.dart';

class SuggestedSearchPage extends StatefulWidget {
  static const String pageName = '/suggested-search-page';
  const SuggestedSearchPage({super.key});

  @override
  State<SuggestedSearchPage> createState() => SuggestedSearchPageState();
}

class SuggestedSearchPageState extends State<SuggestedSearchPage> {


  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();

  bool isShowButton = false;

  List<CourseModel> suggestedData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      if(searchController.text.trim().isNotEmpty){
        
        if(!isShowButton){
          setState(() {
            isShowButton = true;
          });
        }
      }else{

        if(isShowButton){
          setState(() {
            isShowButton = false;
          });
        }
      }
    });

    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    
    suggestedData = await CourseService.getAll(offset: 0);

    suggestedData.shuffle();
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        appBar: appbar(title: appText.search),

        body: Stack(
          children: [
            

            // course
            Positioned.fill(
              child: SingleChildScrollView(
                padding: padding(),
                physics: const BouncingScrollPhysics(),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    space(20),

                    input(searchController, searchNode, appText.searchInputDesc,iconPathLeft: AppAssets.searchSvg),

                    space(30),

                    Text(
                      appText.suggestedRandom,
                      style: style20Bold(),
                    ),


                    space(20),

                    if(isLoading)...{
                      loading()
                    }else...{
                    
                      ...List.generate(suggestedData.length > 3 ? 3 : suggestedData.length, (index) {
                        return courseItemVertically(suggestedData[index]);
                      })
                    }

                  ],
                ),
                
              ),
            ),


            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: isShowButton ? 0 : -150,
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
                    nextRoute(ResultSearchPage.pageName, arguments: searchController.text.trim());
                  }, 
                  width: getSize().width, 
                  height: 52, 
                  text: appText.search, 
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