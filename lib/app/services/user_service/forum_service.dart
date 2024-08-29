import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:webinar/app/models/forum_answer_model.dart';
import 'package:webinar/app/models/forum_model.dart';
import 'package:webinar/common/utils/http_handler.dart';

import '../../../common/enums/error_enum.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/error_handler.dart';
import 'package:dio/dio.dart' as dio;

class ForumService{



  static Future<ForumModel?> getForumData(int id,String search)async{
    
    try{
      String url = '${Constants.baseUrl}panel/webinars/$id/forums';

      if(search.isNotEmpty){
        url += '?search=$search';
      }


      Response res = await httpGetWithToken(
        url, 
        isRedirectingStatusCode: false
      );
      

      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){

        return ForumModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }
  
  static Future<bool> pin(int id)async{
    
    try{
      String url = '${Constants.baseUrl}panel/webinars/forums/$id/pin';


      Response res = await httpPostWithToken(
        url,
        {}, 
        isRedirectingStatusCode: false
      );
      

      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){

        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  static Future<bool> answerPin(int id)async{
    
    try{
      String url = '${Constants.baseUrl}panel/webinars/forums/answers/$id/pin';


      Response res = await httpPostWithToken(
        url,
        {}, 
        isRedirectingStatusCode: false
      );

      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  static Future<bool> answerResolve(int id)async{
    
    try{
      String url = '${Constants.baseUrl}panel/webinars/forums/answers/$id/resolve';


      Response res = await httpPostWithToken(
        url,
        {}, 
        isRedirectingStatusCode: false
      );

      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  static Future<bool> setAnswer(int id, String desc)async{
    
    try{
      String url = '${Constants.baseUrl}panel/webinars/forums/$id/answers';


      Response res = await httpPostWithToken(
        url,
        {
          "description" : desc
        }, 
        isRedirectingStatusCode: false
      );

      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  static Future<bool> updateAnswer(int id, String desc)async{
    
    try{
      String url = '${Constants.baseUrl}panel/webinars/forums/answers/$id';


      Response res = await httpPutWithToken(
        url,
        {
          "description" : desc
        }, 
      );

      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }

  static Future<List<ForumAnswerModel>> getAnswers(int id)async{
    List<ForumAnswerModel> data = [];
    try{
      String url = '${Constants.baseUrl}panel/webinars/forums/$id/answers';


      Response res = await httpGetWithToken(
        url, 
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        jsonResponse['data']['answers'].forEach((json){
          data.add(ForumAnswerModel.fromJson(json));
        });
        return data;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return data;
      }

    }catch(e){
      return data;
    }
  }

  static Future<bool> newQuestion(int id, String title, String desc,File? file)async{
    
    try{
      String url = '${Constants.baseUrl}panel/webinars/$id/forums';

      dio.FormData formData = dio.FormData.fromMap({
        "title": title,
        "description": desc,
        
        if(file != null)...{
          "attachment": await dio.MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
        }
      });
      
      dio.Response res = await dioPostWithToken(
        url,
        formData, 
        isRedirectingStatusCode: false
      );

      print(res.data);
      
      if(res.data['success']){
        ErrorHandler().showError(ErrorEnum.success, res.data,readMessage: true);
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, res.data);
        return false;
      }

    }catch(e){
      return false;
    }
  }
   
}