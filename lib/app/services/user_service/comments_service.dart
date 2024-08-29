import 'dart:convert';

import 'package:http/http.dart';
import 'package:webinar/common/components.dart';

import '../../../common/enums/error_enum.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/error_handler.dart';
import '../../../common/utils/http_handler.dart';
import '../../models/blog_model.dart';

class CommentsService{

  static Future<(List<Comments> webinar,List<Comments> classComment)> getAllComments()async{
    List<Comments> webinar = [];
    List<Comments> classComment = [];
    try{
      String url = '${Constants.baseUrl}panel/comments';


      Response res = await httpGetWithToken(
        url, 
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        jsonResponse['data']['my_comment']['webinar'].forEach((json){
          webinar.add(Comments.fromJson(json));
        });
        
        jsonResponse['data']['class_comment'].forEach((json){
          classComment.add(Comments.fromJson(json));
        });

        return (webinar,classComment);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return (webinar,classComment);
      }

    }catch(e){
      return (webinar,classComment);
    }
  }
  
  static Future<bool> instructorReplay(int id, String desc)async{
    
    try{
      String url = '${Constants.baseUrl}panel/comments/$id/reply';


      Response res = await httpPostWithToken(
        url,
        {
          "reply" : desc
        }, 
      );

      var jsonResponse = jsonDecode(res.body);


      if(jsonResponse['success']){
        showSnackBar(ErrorEnum.success, jsonResponse['message'].toString());
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  static Future<bool> report(int id, String desc)async{
    
    try{
      String url = '${Constants.baseUrl}panel/comments/$id/report';


      Response res = await httpPostWithToken(
        url,
        {
          "message" : desc
        }, 
      );

      var jsonResponse = jsonDecode(res.body);


      if(jsonResponse['success']){
        showSnackBar(ErrorEnum.success, jsonResponse['message'].toString());
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  
  static Future<bool> update(int id, String desc)async{
    
    try{
      String url = '${Constants.baseUrl}panel/comments/$id';


      Response res = await httpPutWithToken(
        url,
        {
          "comment" : desc
        }, 
      );

      var jsonResponse = jsonDecode(res.body);


      if(jsonResponse['success']){
        showSnackBar(ErrorEnum.success, jsonResponse['message'].toString());
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  static Future<bool> delete(int id)async{
    
    try{
      String url = '${Constants.baseUrl}panel/comments/$id';


      Response res = await httpDeleteWithToken(
        url,
        {}, 
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


}