import 'dart:convert';

import 'package:http/http.dart';
import 'package:webinar/app/models/location_model.dart';

import '../../../common/utils/constants.dart';
import '../../../common/utils/http_handler.dart';

class LocationService{
  
  static Future<List<LocationModel>> getCountries()async{
    List<LocationModel> data = [];
    try{

      String url = '${Constants.baseUrl}regions/countries';


      Response res = await httpGet(url);
        
      var jsonRes = jsonDecode(res.body);

      if (jsonRes['success']) {
        jsonRes['data'].forEach((json){
          data.add(LocationModel.fromJson(json));
        });

        return data;
      }else{
        return data;
      }


    }catch(e){
      return data;
    }
  }
  
  static Future<List<LocationModel>> getProvince(int countryId)async{
    List<LocationModel> data = [];
    try{

      String url = '${Constants.baseUrl}regions/provinces/$countryId';


      Response res = await httpGet(url);
        
      var jsonRes = jsonDecode(res.body);

      if (jsonRes['success']) {
        jsonRes['data'].forEach((json){
          data.add(LocationModel.fromJson(json));
        });

        return data;
      }else{
        return data;
      }


    }catch(e){
      return data;
    }
  }
  
  static Future<List<LocationModel>> getCity(int provinceId)async{
    List<LocationModel> data = [];
    try{

      String url = '${Constants.baseUrl}regions/cities/$provinceId';


      Response res = await httpGet(url);
        
      var jsonRes = jsonDecode(res.body);

      if (jsonRes['success']) {
        jsonRes['data'].forEach((json){
          data.add(LocationModel.fromJson(json));
        });

        return data;
      }else{
        return data;
      }


    }catch(e){
      return data;
    }
  }
  
  static Future<List<LocationModel>> getDistricts(int cityId)async{
    List<LocationModel> data = [];
    try{

      String url = '${Constants.baseUrl}regions/districts/$cityId';


      Response res = await httpGet(url);
        
      var jsonRes = jsonDecode(res.body);

      if (jsonRes['success']) {
        jsonRes['data'].forEach((json){
          data.add(LocationModel.fromJson(json));
        });

        return data;
      }else{
        return data;
      }


    }catch(e){
      return data;
    }
  }

}