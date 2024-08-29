import 'dart:convert';

import 'package:http/http.dart';
import 'package:webinar/app/models/certificate_model.dart';

import '../../../common/enums/error_enum.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/error_handler.dart';
import '../../../common/utils/http_handler.dart';

class CertificateService{


  static Future<List<CertificateModel>> getAchievements()async{
    List<CertificateModel> data = [];
    try{
      String url = '${Constants.baseUrl}panel/certificates/achievements';


      Response res = await httpGetWithToken(
        url, 
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        jsonResponse['data'].forEach((json){
          data.add(CertificateModel.fromJson(json));
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

  static Future<List<CertificateModel>> getCompletion()async{
    List<CertificateModel> data = [];
    try{
      String url = '${Constants.baseUrl}panel/webinars/certificates';


      Response res = await httpGetWithToken(
        url, 
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        jsonResponse['data']['certificates'].forEach((json){
          data.add(CertificateModel.fromJson(json));
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

  static Future<List<CertificateModel>> getClassData()async{
    List<CertificateModel> data = [];
    try{
      String url = '${Constants.baseUrl}panel/certificates/created';


      Response res = await httpGetWithToken(
        url, 
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        jsonResponse['data']['certificates'].forEach((json){
          data.add(CertificateModel.fromJson(json));
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