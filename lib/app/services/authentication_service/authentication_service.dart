import 'dart:convert';
import 'dart:developer';
import 'package:webinar/app/models/register_config_model.dart';
import 'package:webinar/common/data/app_data.dart';
import 'package:webinar/common/enums/error_enum.dart';
import 'package:webinar/common/utils/constants.dart';
import 'package:webinar/common/utils/error_handler.dart';
import 'package:webinar/common/utils/http_handler.dart';
import 'package:http/http.dart';

class AuthenticationService{

  static Future google(String email,String token, String name)async{
    try{
      String url = '${Constants.baseUrl}google/callback';

      Response res = await httpPost(
        url, 
        {
          'email': email,
          'name': name,
          'id': token,
        }
      );

      print(res.body);

      if(res.statusCode == 200){
        await AppData.saveAccessToken(jsonDecode(res.body)['data']['token']);
        return true;
      }else{

        return false;
      }

    }catch(e){
      return false;
    }
  }

  static Future facebook(String email, String token, String name)async{
    try{
      String url = '${Constants.baseUrl}facebook/callback';

      Response res = await httpPost(
        url, 
        {
          'id': token,
          'name': name,
          'email': email
        }
      );

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        await AppData.saveAccessToken(jsonDecode(res.body)['data']['token']);
        return true;
      }else{
        
        return false;
      }

    }catch(e){
      return false;
    }
  }

  static Future login(String username, String password)async{
    try{
      String url = '${Constants.baseUrl}login';

      Response res = await httpPost(
        url, 
        {
          'username': username,
          'password': password
        }
      );

      log(res.body.toString());

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        await AppData.saveAccessToken(jsonResponse['data']['token']);
        await AppData.saveName('');
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse,readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }

  static Future<Map?> registerWithEmail(String registerMethod,String email, String password,String repeatPassword, String? accountType, List<Fields>? fields)async{
    try{
      String url = '${Constants.baseUrl}register/step/1';

      Map body = {
        "register_method": registerMethod,
        "country_code": null,
        'email': email,
        'password': password,
        'password_confirmation': repeatPassword
      };
      
      if(fields != null){
        Map bodyFields = {};
        for (var i = 0; i < fields.length; i++) {
          if(fields[i].type != 'upload'){
            bodyFields.addEntries(
              {
                fields[i].id: (fields[i].type == 'toggle') 
                  ? fields[i].userSelectedData == null ? 0 : 1
                  : fields[i].userSelectedData
              }.entries
            );
          }
        }

        body.addEntries({'fields': bodyFields.toString()}.entries);        
      }

      Response res = await httpPost(
        url, 
        body
      );


      var jsonResponse = jsonDecode(res.body);
      if( jsonResponse['success'] || jsonResponse['status'] == 'go_step_2' || jsonResponse['status'] == 'go_step_3' ){
        
        return {
          'user_id': jsonResponse['data']['user_id'],
          'step': jsonResponse['status']
        };
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }

  static Future<Map?> registerWithPhone(String registerMethod,String countryCode, String mobile, String password,String repeatPassword, String? accountType, List<Fields>? fields)async{
    // try{
      String url = '${Constants.baseUrl}register/step/1';

      Map body = {
        "register_method": registerMethod,
        "country_code": countryCode,
        'mobile': mobile,
        'password': password,
        'password_confirmation': repeatPassword,
      };
      
      if(fields != null){
        Map bodyFields = {};
        for (var i = 0; i < fields.length; i++) {
          if(fields[i].type != 'upload'){
            bodyFields.addEntries(
              {
                fields[i].id: (fields[i].type == 'toggle') 
                  ? fields[i].userSelectedData == null ? 0 : 1
                  : fields[i].userSelectedData
              }.entries
            );
          }
        }

        body.addEntries({'fields': bodyFields.toString()}.entries);        
      }

      Response res = await httpPost(
        url, 
        body
      );

      print(res.body);
      
      var jsonResponse = jsonDecode(res.body);
       if( jsonResponse['success'] || jsonResponse['status'] == 'go_step_2' || jsonResponse['status'] == 'go_step_3' ){ // || stored
        
        return {
          'user_id': jsonResponse['data']['user_id'],
          'step': jsonResponse['status']
        };
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    // }catch(e){
    //   return null;
    // }
  }
  
  static Future<bool> forgetPassword(String email)async{
    try{
      String url = '${Constants.baseUrl}forget-password';

      Response res = await httpPost(
        url, 
        {
          "email": email
        }
      );

      log(res.body.toString());

      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        
        ErrorHandler().showError(ErrorEnum.success, jsonResponse, readMessage: true);
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  static Future<bool> verifyCode(int userId,String code)async{
    try{
      String url = '${Constants.baseUrl}register/step/2';

      Response res = await httpPost(
        url, 
        {
          "user_id": userId.toString(),
          "code": code,
        }
      );

      log(res.body.toString());

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
  
  static Future<bool> registerStep3(int userId, String name, String referralCode)async{
    try{
      String url = '${Constants.baseUrl}register/step/3';

      Response res = await httpPost(
        url, 
        {
          "user_id": userId.toString(),
          "full_name": name,
          "referral_code": referralCode
        }
      );


      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        await AppData.saveAccessToken(jsonResponse['data']['token']);
        await AppData.saveName(name);
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