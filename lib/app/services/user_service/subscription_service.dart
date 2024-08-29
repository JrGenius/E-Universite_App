import 'dart:convert';

import 'package:http/http.dart';
import 'package:webinar/app/models/saas_package_model.dart';

import '../../../common/enums/error_enum.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/error_handler.dart';
import '../../../common/utils/http_handler.dart';
import '../../models/subscription_model.dart';

class SubscriptionService{

  static Future<SubscriptionModel?> getSubscription()async{
    
    try{
      String url = '${Constants.baseUrl}panel/subscribe';

      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        
        return SubscriptionModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }
  

  static Future<String?> getSubscriptionLink(int id)async{
    
    try{
      String url = '${Constants.baseUrl}panel/subscribe/web_pay';

      Response res = await httpPostWithToken(
        url, 
        {'subscribe_id' : id}
      );
      

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        
        return jsonResponse['data']['link'];
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return null;
      }

    }catch(e){
      return null;
    }
  }
  
  static Future<SaasPackageModel?> getSaasPackages()async{
    
    // try{
      String url = '${Constants.baseUrl}panel/registration-packages';

      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success'] ?? false){
        
        return SaasPackageModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    // }catch(e){
    //   return null;
    // }
  }


  static Future<String?> getSaasPackageLink(int id)async{
    
    try{
      String url = '${Constants.baseUrl}panel/registration-packages/pay';

      Response res = await httpPostWithToken(
        url, 
        {'package_id' : id}
      );
      

      var jsonResponse = jsonDecode(res.body);
      print(jsonResponse);
      
      if(jsonResponse['success']){
        
        return jsonResponse['data']['link'];
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return null;
      }

    }catch(e){
      return null;
    }
  } 
}