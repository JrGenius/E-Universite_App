import 'dart:convert';

import 'package:http/http.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/locator.dart';

import '../../../common/enums/error_enum.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/error_handler.dart';
import '../../../common/utils/http_handler.dart';

class RewardsService{

  static Future getRewards()async{
    
    try{
      String url = '${Constants.baseUrl}panel/rewards';




      Response res = await httpGetWithToken(
        url, 
        isRedirectingStatusCode: false
      );
      

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        
        locator<UserProvider>().setPoint(jsonResponse['data']['available_points']);

        return null;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }
  
  static Future buyWithPoint(int id)async{
    
    try{
      String url = '${Constants.baseUrl}panel/rewards/webinar/$id/apply';



      Response res = await httpPostWithToken(
        url, 
        {},
        isRedirectingStatusCode: false
      );
      

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
      
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse,readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }
}