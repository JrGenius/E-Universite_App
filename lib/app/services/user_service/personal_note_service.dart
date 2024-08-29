import 'dart:convert';

import 'package:http/http.dart';
import 'package:webinar/app/models/note_model.dart';
import 'package:webinar/common/enums/error_enum.dart';
import 'package:webinar/common/utils/constants.dart';
import 'package:webinar/common/utils/error_handler.dart';
import 'package:webinar/common/utils/http_handler.dart';

class PersonalNoteService{


  static Future<bool> create(int courseId, int itemId, String desc,)async{
    
    try{
      String url = '${Constants.baseUrl}panel/webinars/personal-notes/$courseId';


      Response res = await httpPostWithToken(
        url,
        {
          "course_id": courseId.toString(),
          "item_id": "$itemId",
          "item_type": "course",
          "note": desc
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
  
  
  
  
  static Future<NoteModel?> getNote(int id)async{
    
    try{
      String url = '${Constants.baseUrl}panel/webinars/personal-notes/$id';


      Response res = await httpGetWithToken(url);

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        return NoteModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }
  
  static Future<bool> delete(int id)async{
    
    try{
      String url = '${Constants.baseUrl}panel/webinars/personal-notes/delete/$id';

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