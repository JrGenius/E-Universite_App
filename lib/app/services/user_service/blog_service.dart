import 'dart:convert';

import 'package:http/http.dart';
import 'package:webinar/app/models/basic_model.dart';
import 'package:webinar/app/models/blog_model.dart';
import 'package:webinar/common/components.dart';

import '../../../common/enums/error_enum.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/error_handler.dart';
import '../../../common/utils/http_handler.dart';

class BlogService {


  static Future<List<BlogModel>> getBlog(int offset,{int? category})async{
    List<BlogModel> data = [];
    try{
      String url = '${Constants.baseUrl}blogs?offset=$offset&limit=10';

      if(category != null){
        url += '&cat=$category';
      }



      Response res = await httpGet(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        jsonResponse['data'].forEach((json){
          data.add(BlogModel.fromJson(json));
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
  
  static Future<bool> saveComments(int postId,int? commentId,String itemName, String comment)async{
    
    try{
      String url = '${Constants.baseUrl}panel/comments';

      print({
          "item_id" : postId,
          "item_name" : itemName,
          "comment" : comment,
          "reply_id": commentId
        });
      Response res = await httpPostWithToken(
        url, 
        {
          "item_id" : postId,
          "item_name" : itemName,
          "comment" : comment,
          "reply_id": commentId
        }
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        showSnackBar(ErrorEnum.success, jsonResponse['message']?.toString());
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  static Future<bool> reportComments(int commentId,String message)async{
    
    try{
      String url = '${Constants.baseUrl}panel/comments/$commentId/report';


      Response res = await httpPostWithToken(
        url, 
        {
          "message" : message
        }
      );
      
      var jsonResponse = jsonDecode(res.body);


      if(jsonResponse['success']){
        showSnackBar(ErrorEnum.success, jsonResponse['message']?.toString());
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }

  static Future<List<BasicModel>> categories()async{
    List<BasicModel> data = [];
    try{
      String url = '${Constants.baseUrl}blogs/categories';

      Response res = await httpGet(
        url, 
      );

      

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        jsonResponse['data'].forEach((json){
          data.add(BasicModel.fromJson(json));
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

}