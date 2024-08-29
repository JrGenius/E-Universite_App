import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:webinar/app/models/support_model.dart';
import 'package:webinar/common/utils/constants.dart';
import 'package:webinar/common/utils/http_handler.dart';
import 'package:dio/dio.dart' as dio;
import '../../../common/enums/error_enum.dart';
import '../../../common/utils/error_handler.dart';

class SupportService{

  static Future<List<SupportModel>> getMyClassSupport()async{
    List<SupportModel> data = [];

    try{
      String url = '${Constants.baseUrl}panel/support/my_class_support';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        jsonResponse['data'].forEach((json){
          data.add(SupportModel.fromJson(json));
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
  

  static Future<List<SupportModel>> getClassSupport()async{
    List<SupportModel> data = [];

    try{
      String url = '${Constants.baseUrl}panel/support/class_support';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        jsonResponse['data'].forEach((json){
          data.add(SupportModel.fromJson(json));
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
  

  static Future<List<SupportModel>> getTickets()async{
    List<SupportModel> data = [];

    try{
      String url = '${Constants.baseUrl}panel/support/tickets';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        jsonResponse['data'].forEach((json){
          data.add(SupportModel.fromJson(json));
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
  
  static Future<List> getDepartments()async{

    try{
      String url = '${Constants.baseUrl}panel/support/departments';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);

      if(res.statusCode == 200){
        return jsonResponse;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return [];
      }

    }catch(e){
      return [];
    }
  }
  
  static Future<SupportModel?> getOne(int id)async{

    try{
      String url = '${Constants.baseUrl}panel/support/$id';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);

      if(res.statusCode == 200){
        return SupportModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }


  static Future<bool> createMessage(String title, String desc, int? departmentId, int? courseId, File? file) async {
    try{
      String url = '${Constants.baseUrl}panel/support';

      dio.FormData formData = dio.FormData.fromMap({
        "title": title,
        "message": desc,
        "type": departmentId != null ? 'platform_support' : 'course_support',

        if(departmentId != null)...{
          "department_id": departmentId,
        },
        
        if(courseId != null)...{
          "webinar_id": courseId,
        },
        
        if(file != null)...{
          "attach": await dio.MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
        }
      });

      
      dio.Response res = await dioPostWithToken(
        url,
        formData, 
        isRedirectingStatusCode: false
      );

      if(res.data['success']){
        ErrorHandler().showError(ErrorEnum.success, res.data, readMessage: true);
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, res.data);
        return false;
      }

    } on dio.DioException catch (_){
      return false;
    }
  }
  

  static Future<bool> sendMessage(String title, File? file, int chatId) async {
    try{
      String url = '${Constants.baseUrl}panel/support/$chatId/conversations';

      dio.FormData formData = dio.FormData.fromMap({
        "message": title,
        if(file != null)...{
          "attach": await dio.MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
        }
      });

      
      dio.Response res = await dioPostWithToken(
        url,
        formData, 
        isRedirectingStatusCode: false
      );

      if(res.data['success']){
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, res.data);
        return false;
      }

    } on dio.DioException catch (_){
      return false;
    }
  }
  
  

}