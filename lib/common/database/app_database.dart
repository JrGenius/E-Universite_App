


import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:webinar/app/models/content_model.dart';
import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/models/purchase_course_model.dart';
import 'package:webinar/app/models/single_content_model.dart';
import 'package:webinar/app/services/guest_service/course_service.dart';
import 'package:webinar/app/services/user_service/user_service.dart';
import 'package:webinar/common/database/model/course_model_db.dart';

class AppDataBase{



  static Future getCoursesAndSaveInDB()async{

    // get all purchase course
    List<PurchaseCourseModel> purchaseData = await UserService.getPurchaseCourse();

    if(purchaseData.isNotEmpty){
      // open course box
      Box<CourseModelDB> courseBox = await Hive.openBox<CourseModelDB>('courseBox');
      
      for (var i = 0; i < purchaseData.length; i++) {
        print('course: ${i + 1}');
        
        int courseId = purchaseData[i].webinar == null ? purchaseData[i].bundle!.id! : purchaseData[i].webinar!.id!; 


        if(purchaseData[i].bundle == null){
          await getCourseAndSave(
            courseBox, 
            courseId, 
            jsonEncode(purchaseData[i].webinar!.toJson())
          );
        }else{
          List<CourseModel> bundleWebinars = await CourseService.getBundleWebinars(courseId);

          for (var j = 0; j < bundleWebinars.length; j++) {
            print('get bundle course: ${bundleWebinars[j].id}');

            await getCourseAndSave(
              courseBox, 
              bundleWebinars[j].id!, 
              jsonEncode(bundleWebinars[j].toJson())
            );
          }
        }
        
      }

      courseBox.close();
      print('Finished !');

    }
  }

  static Future getCourseAndSave(Box<CourseModelDB> courseBox, int courseId, String courseJson) async {
    // check course is exist in db or no
    if(!courseBox.containsKey(courseId)){

      // get contents course
      String? contentJson = await CourseService.getContentJSON(courseId);
      print('get content course: $courseId');

      if(contentJson != null){
        
        List<ContentModel> contents = [];
        var decodedContent = jsonDecode(contentJson);
        
        decodedContent.forEach((json){
          contents.add(ContentModel.fromJson(json));
        });

        List<String> singleContentData = [];

        
        for (var ii = 0; ii < contents.length; ii++) {
          for (var iii = 0; iii < (contents[ii].items?.length ?? 0); iii++) {
            // get single content data
            String? singleContentJson = await CourseService.getSingleContentJSON(contents[ii].items![iii].link ?? '');
            print('get single content: ${iii + 1}');

            if(singleContentJson != null){
              singleContentData.add(singleContentJson);
            }
          }
        }
        
        
        CourseModelDB courseModelDB = CourseModelDB();
        
        courseModelDB.courseDataJson = courseJson;
        courseModelDB.contentDataJson = contentJson;
        courseModelDB.singleContentDataJson = singleContentData;


        await courseBox.put(courseId, courseModelDB);
        print('----------------------------------------------------------------------------------');
      }

    }else{
      print('this course save in db!');
    }
  }


  static Future clearBox() async {
    Box<CourseModelDB> courseBox = await Hive.openBox<CourseModelDB>('courseBox');
    await courseBox.clear();
  }



  static Future<List<CourseModel>> getCoursesAtDB() async {

    List<CourseModel> data = [];
    Box<CourseModelDB> courseBox = await Hive.openBox<CourseModelDB>('courseBox');
    

    for (var i = 0; i < courseBox.values.length; i++) {
      CourseModel course = CourseModel.fromJson(
        jsonDecode(
          courseBox.get(courseBox.keys.toList()[i])!.courseDataJson!
        )
      );

      data.add(course);
    }
    return data;
  }

  static Future<List<ContentModel>> getContentsCoursesAtDB(int courseId) async {

    List<ContentModel> data = [];
    Box<CourseModelDB> courseBox = await Hive.openBox<CourseModelDB>('courseBox');

    CourseModelDB? courseDB = courseBox.get(courseId);

    if(courseDB != null){
      List contents = jsonDecode(courseDB.contentDataJson ?? '');

      for (var i = 0; i < (contents.length); i++) {
        data.add(
          ContentModel.fromJson(
            contents[i]
          )
        );
      }

      return data;
    }else{
      return data;
    }
  
  }

  static Future<SingleContentModel?> getListOfSingleContentDataAtDB(int courseId, int contentId)async{
    
    Box<CourseModelDB> courseBox = await Hive.openBox<CourseModelDB>('courseBox');
    CourseModelDB? courseDB = courseBox.get(courseId);


    for (var i = 0; i < (courseDB?.singleContentDataJson?.length ?? 0); i++) {

      var data = (jsonDecode(courseDB!.singleContentDataJson![i]))['data'];

      if(SingleContentModel.fromJson(data).id == contentId){
        return SingleContentModel.fromJson(data);
      }
    }
    
    return null;
  }

}