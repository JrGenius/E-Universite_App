import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/models/login_history_model.dart';
import 'package:webinar/app/models/profile_model.dart';
import 'package:webinar/app/models/purchase_course_model.dart';
import 'package:webinar/app/models/reward_point_model.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/data/app_data.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/http_handler.dart';
import 'package:webinar/locator.dart';

import 'package:dio/dio.dart' as dio;

import '../../../common/enums/error_enum.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/error_handler.dart';
import '../../models/dashboard_model.dart';
import '../../models/favorite_model.dart';
import '../../models/notification_model.dart';

class UserService{

  static Future<List<PurchaseCourseModel>> getPurchaseCourse()async{
    List<PurchaseCourseModel> data = [];
    // try{
      String url = '${Constants.baseUrl}panel/webinars/purchases';

      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        jsonResponse['data']?['purchases']?.forEach((json){
          data.add(PurchaseCourseModel.fromJson(json));
        });
        return data;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return data;
      }

    // }catch(e){
    //   return data;
    // }
  }

  static Future<String?> getPurchaseCourseJSON()async{
    try{
      String url = '${Constants.baseUrl}panel/webinars/purchases';

      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        
        return jsonEncode(jsonResponse['data']?['webinars'] ?? []);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }

  static Future<List<CourseModel>> getOrganizationCourse()async{
    List<CourseModel> data = [];
    try{
      String url = '${Constants.baseUrl}panel/webinars/organization';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        jsonResponse['data']?['webinars']?.forEach((json){
          data.add(CourseModel.fromJson(json));
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

  static Future<List<NotificationModel>> getAllNotification()async{
    List<NotificationModel> data = [];
    try{
      String url = '${Constants.baseUrl}panel/notifications';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        jsonResponse['data']?['notifications']?.forEach((json){
          data.add(NotificationModel.fromJson(json));
        });

        locator<UserProvider>().setNotification(data);
        return data;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return data;
      }

    }catch(e){
      return data;
    }
  }
  
  static Future<List<FavoriteModel>> getFavorites()async{
    List<FavoriteModel> data = [];
    // try{
      String url = '${Constants.baseUrl}panel/favorites';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
        print(jsonResponse);
      
      if(jsonResponse['success'] ?? false){

        jsonResponse['data']?['favorites']?.forEach((json){
          data.add(FavoriteModel.fromJson(json));
        });

        return data;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return data;
      }

    // }catch(e){
    //   return data;
    // }
  }
  
  
  static Future<List<LoginHistoryModel>> getLoginHistory()async{
    List<LoginHistoryModel> data = [];
    try{
      String url = '${Constants.baseUrl}panel/users/login/history';


      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        jsonResponse['data'].forEach((json){
          data.add(LoginHistoryModel.fromJson(json));
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
  
  static Future<bool> deleteFavorite(int id)async{
    
    try{
      String url = '${Constants.baseUrl}panel/favorites/$id';

      Response res = await httpDeleteWithToken(
        url, 
        {}
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

  static Future<( List<CourseModel> myClasses, List<PurchaseCourseModel> purchases, List<CourseModel> organizations, List<CourseModel> invitations )> getTeacherClassess()async{
    List<CourseModel> myClasses = [];
    List<PurchaseCourseModel> purchases = [];
    List<CourseModel> organizations = [];
    List<CourseModel> invitations = [];
    
    // try{
      String url = '${Constants.baseUrl}panel/classes';



      Response res = await httpGetWithToken(
        url, 
      );
      

      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success'] ?? true){
        
        jsonResponse['my_classes']?.forEach((json){
          myClasses.add(CourseModel.fromJson(json));
        });
        
        jsonResponse['purchases']?.forEach((json){
          purchases.add(PurchaseCourseModel.fromJson(json));
        });
        
        jsonResponse['organizations']?.forEach((json){
          organizations.add(CourseModel.fromJson(json));
        });
        
        jsonResponse['invitations']?.forEach((json){
          invitations.add(CourseModel.fromJson(json));
        });

        return ( myClasses, purchases, organizations, invitations );
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return ( myClasses, purchases, organizations, invitations );
      }

    // }catch(e){
    //   return ( myClasses, purchases, organizations, invitations );
    // }
  }


  static Future<ProfileModel?> getProfile()async{
    
    try{
      String url = '${Constants.baseUrl}panel/profile-setting';

      Response res = await httpGetWithToken(
        url, 
      );


      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success']){
        locator<UserProvider>().setProfile(ProfileModel.fromJson(jsonResponse['data']['user']));
        return ProfileModel.fromJson(jsonResponse['data']['user']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }

  static Future<DashboardModel?> getDashboardData()async{
    
    try{
      String url = '${Constants.baseUrl}panel/quick-info';

      Response res = await httpGetWithToken(
        url, 
      );


      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success'] ?? true){
        return DashboardModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }

  static Future<RewardPointModel?> getRewardPointsData()async{
    
    try{
      String url = '${Constants.baseUrl}panel/rewards';

      Response res = await httpGetWithToken(
        url, 
      );


      var jsonResponse = jsonDecode(res.body);
      if(jsonResponse['success'] ?? true){
        return RewardPointModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }

  static Future<bool> seenNotification(int id)async{
    
    try{
      String url = '${Constants.baseUrl}panel/notifications/$id/read';

      Response res = await httpGetWithToken(
        url, 
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

  static Future<bool> storeReview(int postId, int contentQuality, int instructorSkills, int purchaseWorth, int supportQuality, String description)async{
    
    try{
      String url = '${Constants.baseUrl}panel/reviews';

      Response res = await httpPostWithToken(
        url, 
        {
          "webinar_id" : postId,
          "content_quality" : contentQuality,
          "instructor_skills" : instructorSkills,
          "purchase_worth" : purchaseWorth,
          "support_quality" : supportQuality,
          "description" : description
        }
      );


      var jsonResponse = jsonDecode(res.body);
      // print(jsonResponse);

      if(jsonResponse['success']){
        ErrorHandler().showError(ErrorEnum.success, jsonResponse, readMessage: true); 
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }

  
  static Future<bool> updateInfo(String email, String name, String phone, String timezone, bool newsletter, String iban, String accountType, String accountId, String address, int? countryId,int? provinceId, int? cityId, int? districtId) async {
    try{
      String url = '${Constants.baseUrl}panel/profile-setting';

      Response res = await httpPutWithToken(
        url, 
        {
          "email": email,
          "full_name": name,
          "mobile": phone,
          // "language": "string",
          if(timezone.isNotEmpty)...{
            "timezone": timezone,
          },
          "newsletter": newsletter ? 1 : 0,
          "account_type": accountType,
          "iban": iban,
          "account_id": accountId,
          // "bio": "nullable|string|min:3|max:48",
          // "level_of_training": "array|in:beginner,middle,expert",
          // "meeting_type": "in:in_person,all,online",
          // "gender": "nullable|in:man,woman",
          // "location": "array|size:2",
          // "location.latitude": "required_with:location",
          // "location.longitude": "required_with:location",
          if(address.isNotEmpty)...{
            "address": address,
          },

          if(countryId != null)...{
            "country_id": countryId,
          },

          if(provinceId != null)...{
            "province_id": provinceId,
          },

          if(cityId != null)...{
            "city_id": cityId,
          },
          
          if(districtId != null)...{
            "district_id": districtId,
          },
        }
      );


      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        await getProfile();
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
  
  static Future<bool> updatePassword(String currentPassword, String newPassword) async {
    try{
      String url = '${Constants.baseUrl}panel/profile-setting/password';

      showSnackBar(ErrorEnum.alert, appText.sendDataDesc);
      
      Response res = await httpPutWithToken(
        url, 
        {
          "current_password": currentPassword,
          "new_password": newPassword
        }
      );


      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        await AppData.saveAccessToken(jsonResponse['data']['token']);
        showSnackBar(ErrorEnum.success, appText.passwordUpdateDesc);
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  
  static Future<bool> sendFirebaseToken(String token) async {
    try{
      String url = '${Constants.baseUrl}panel/users/fcm';

      
      Response res = await httpPutWithToken(
        url, 
        {
          "token": token,
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
  
  
  static Future<bool> logout() async {
    try{
      String url = '${Constants.baseUrl}logout';

      
      Response res = await httpPostWithToken(
        url, 
        {},
        isRedirectingStatusCode: false
      );


      var jsonResponse = jsonDecode(res.body);

      if(jsonResponse['success']){
        return true;
      }else{
        // ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  static Future<bool> updateImage(File? profile, File? indentity, File? certificate) async {
    try{
      String url = '${Constants.baseUrl}panel/profile-setting/images';

      closeSnackBar();
      showSnackBar(ErrorEnum.alert, appText.sendDataDesc);

      dio.FormData body = dio.FormData.fromMap({
        if(profile != null)...{
          "profile_image": await dio.MultipartFile.fromFile(profile.path, filename: profile.path.split('/').last),
        },
        
        if(indentity != null)...{
          "identity_scan": await dio.MultipartFile.fromFile(indentity.path, filename: indentity.path.split('/').last),
        },
        
        if(certificate != null)...{
          "certificate": await dio.MultipartFile.fromFile(certificate.path, filename: certificate.path.split('/').last),
        },

      });
      
      dio.Response res = await dioPostWithToken(
        url, 
        body
      );

      if(res.data['success']){
        await getProfile();
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, res.data);
        return false;
      }

    }on dio.DioException catch(e){
      print(e.response?.data);

      ErrorHandler().showError(ErrorEnum.error, e.response?.data);
      return false;
    }
  }

}