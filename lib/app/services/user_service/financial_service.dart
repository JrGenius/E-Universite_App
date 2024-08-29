import 'dart:convert';

import 'package:http/http.dart';
import 'package:webinar/app/models/banks_model.dart';
import 'package:webinar/app/models/offline_payment_model.dart';
import 'package:webinar/app/models/payout_model.dart';
import 'package:webinar/app/models/sales_model.dart';
import 'package:webinar/app/models/summary_model.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/constants.dart';
import 'package:dio/dio.dart' as dio;
import '../../../common/enums/error_enum.dart';
import '../../../common/utils/error_handler.dart';
import '../../../common/utils/http_handler.dart';

class FinancialService{

  static Future<List<BanksModel>> getBankAccounts()async{
    List<BanksModel> data = [];
    try{
      String url = '${Constants.baseUrl}panel/financial/platform-bank-accounts';


      Response res = await httpGetWithToken(
        url, 
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        jsonResponse['data']['accounts'].forEach((json){
          data.add(BanksModel.fromJson(json));
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

  static Future<List<OfflinePaymentModel>> getOfflinePayments()async{
    List<OfflinePaymentModel> data = [];
    try{
      String url = '${Constants.baseUrl}panel/financial/offline-payments';


      Response res = await httpGetWithToken(
        url, 
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        jsonResponse['data'].forEach((json){
          data.add(OfflinePaymentModel.fromJson(json));
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

  static Future<bool> store(int amount, String bank, String reference, int date, int orderId)async{
    
    try{
      String url = '${Constants.baseUrl}panel/financial/offline-payments';


      dio.Response res = await dioPostWithToken(
        url, 
        dio.FormData.fromMap({
          'amount' : amount,
          'bank' : bank,
          'reference_number' : reference,
          'pay_date' : date
        })
      );
      
      
      if(res.data['success']){
        showSnackBar(ErrorEnum.success, appText.successfulyRequest);
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, res.data);
        return false;
      }

    }on dio.DioException catch (e,_) {
      showSnackBar(ErrorEnum.error, e.message);
      return false;
    }
  }


  static Future<SummaryModel?> getSummaryData()async{
    
    try{
      String url = '${Constants.baseUrl}panel/financial/summary';


      Response res = await httpGetWithToken(
        url, 
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        return SummaryModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse,readMessage: true);
        return null;
      }

    }catch (e) {
      return null;
    }
  }

  static Future<String?> webLinkCharge()async{
    
    try{
      String url = '${Constants.baseUrl}panel/financial/web_charge';


      Response res = await httpPostWithToken(
        url, 
        {}
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){

        return jsonResponse['data']['link'];
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse,readMessage: true);
        return null;
      }

    }catch (e) {
      return null;
    }
  }

  static Future<PayoutModel?> getPayoutData()async{
    
    try{
      String url = '${Constants.baseUrl}panel/financial/payout';


      Response res = await httpGetWithToken(
        url, 
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){

        return PayoutModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return null;
      }

    }catch (e) {
      return null;
    }
  }
  
  static Future<SaleModel?> getSalesData()async{
    
    try{
      String url = '${Constants.baseUrl}panel/financial/sales';


      Response res = await httpGetWithToken(
        url, 
      );
      
      var jsonResponse = jsonDecode(res.body);      
      if(jsonResponse['success']){

        return SaleModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return null;
      }

    }catch (e) {
      return null;
    }
  }

  static Future<bool> requestPayout(var amount)async{
    
    try{
      String url = '${Constants.baseUrl}panel/financial/payout';


      Response res = await httpPostWithToken(
        url, 
        {
          "amount" : amount
        }
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){

        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return false;
      }

    }catch (e) {
      return false;
    }
  }

  

}