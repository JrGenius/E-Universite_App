import 'dart:convert';

import 'package:http/http.dart';
import 'package:webinar/app/models/meeting_details_model.dart';
import 'package:webinar/app/models/meeting_model.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/http_handler.dart';

import '../../../common/enums/error_enum.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/error_handler.dart';

class MeetingService{


  static Future<MeetingModel?> getMeetings()async{

    try{
      String url = '${Constants.baseUrl}panel/meetings';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){

        return MeetingModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }


  static Future<MeetingDetailsModel?> getMeetingDetails(int id)async{
    try{
      String url = '${Constants.baseUrl}panel/meetings/$id';


      Response res = await httpGetWithToken(
        url, 
      );
      
      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        return MeetingDetailsModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }

  static Future<bool> createLink(int id, String url, String password)async{
    try{
      String url = '${Constants.baseUrl}instructor/meetings/create-link';


      Response res = await httpPostWithToken(
        url, 
        {
          "link" : url,
          "reserved_meeting_id" : id,
          "password" : password
        }
      );
      
      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        showSnackBar(ErrorEnum.success, jsonResponse['message']);
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  

  static Future<bool> addSession(int id)async{
    try{
      String url = '${Constants.baseUrl}instructor/meetings/$id/add-session';


      Response res = await httpPostWithToken(
        url, 
        {}
      );
      
      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['code'] == 200){
        showSnackBar(ErrorEnum.success, appText.liveSessionCreated, desc: appText.youCanJoinItNow);
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  

  static Future<bool> finisheMeeting(int id, bool isConsultant)async{
    try{
      String url = '${Constants.baseUrl}${isConsultant ? 'instructor/meetings/$id/finish' : 'panel/meetings/$id/finish'}';


      Response res = await httpPostWithToken(
        url, 
        {}
      );
      
      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        showSnackBar(ErrorEnum.success, jsonResponse['message']);
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
}