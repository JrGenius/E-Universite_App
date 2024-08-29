import 'dart:convert';

import 'package:http/http.dart';
import 'package:webinar/app/models/cart_model.dart';
import 'package:webinar/app/models/checkout_model.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/error_handler.dart';
import 'package:webinar/locator.dart';

import '../../../common/enums/error_enum.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/http_handler.dart';

class CartService{


  static Future<CartModel?> getCart()async{
    try{
      String url = '${Constants.baseUrl}panel/cart/list';


      Response res = await httpGetWithToken(
        url,   
        isRedirectingStatusCode: false
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      
      if(jsonResponse['success']){
        locator<UserProvider>().setCartData(CartModel.fromJson(jsonResponse['data']?['cart'] ?? {}));
        return CartModel.fromJson(jsonResponse['data']?['cart'] ?? {});
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return null;
      }

    }catch(e){
      return null;
    }
  }

  static Future validateCoupon(String coupon)async{
    try{
      String url = '${Constants.baseUrl}panel/cart/coupon/validate';


      Response res = await httpPostWithToken(
        url,   
        {
          "coupon" : coupon
        },
        isRedirectingStatusCode: false
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        
        return {
          'amount' : Amounts.fromJson(jsonResponse['data']['amounts']),
          'discount_id' : jsonResponse['data']['discount']['id']
        };
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return null;
      }

    }catch(e){
      return null;
    }
  }
    
  
  static Future<bool> store(int courseId,int ticketId)async{
    try{
      String url = '${Constants.baseUrl}panel/cart/store';


      Response res = await httpPostWithToken(
        url,   
        {
          "webinar_id" : courseId.toString(),
          "ticket_id" : ticketId.toString()
        },
        isRedirectingStatusCode: false
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        getCart();
        showSnackBar(ErrorEnum.success, appText.successAddToCartDesc);
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }
  
  
  static Future<dynamic> payRequest(int gatewayId,int orderId)async{
    try{
      String url = '${Constants.baseUrl}panel/payments/request';
      


      Response res = await httpPostWithToken(
        url,   
        {
          "gateway_id" : gatewayId.toString(),
          "order_id" : orderId.toString()
        },
        isRedirectingStatusCode: false
      );
      
      var jsonResponse;
      try{
        jsonResponse = jsonDecode(res.body.toString());
      }catch(e){}

      // print(res.statusCode);
      print(res.body);
      
      if(jsonResponse?['success'] ?? true){
        return res.body;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse);
        return null;
      }

    }catch(e){
      return null;
    }
  }
  
  static Future<bool> credit(int orderId)async{
    try{
      String url = '${Constants.baseUrl}panel/payments/credit';


      Response res = await httpPostWithToken(
        url,   
        {
          "order_id" : orderId.toString(),
        },
        isRedirectingStatusCode: false
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }
    
  
  static Future<bool> subscribeApplay(int courseId)async{
    try{
      String url = '${Constants.baseUrl}panel/subscribe/apply';


      Response res = await httpPostWithToken(
        url,   
        {
          "webinar_id" : courseId.toString(),
        },
        isRedirectingStatusCode: false
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }
    
  
  static Future<bool> add(String itemId, String itemName, String? specifications)async{
    try{
      String url = '${Constants.baseUrl}panel/cart';


      Response res = await httpPostWithToken(
        url,   
        {
          "item_id" : itemId,
          "item_name" : itemName,
          "specifications" : specifications,
          "quantity" : "1"
        },
        isRedirectingStatusCode: false
      );
      
      var jsonResponse = jsonDecode(res.body);
      print(jsonResponse);
      
      if(jsonResponse['success']){
        getCart();
        showSnackBar(ErrorEnum.success, appText.successAddToCartDesc);
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }
    

  static Future<bool> deleteCourse(int id)async{
    try{
      String url = '${Constants.baseUrl}panel/cart/$id';


      Response res = await httpDeleteWithToken(
        url,   
        {},
        isRedirectingStatusCode: false
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        
        return true;
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return false;
      }

    }catch(e){
      return false;
    }
  }
    

  static Future<CheckoutModel?> checkout()async{
    try{
      String url = '${Constants.baseUrl}panel/cart/checkout';


      Response res = await httpPostWithToken(
        url,   
        {},
        isRedirectingStatusCode: false
      );
      
      var jsonResponse = jsonDecode(res.body);
      
      if(jsonResponse['success']){
        
        return CheckoutModel.fromJson(jsonResponse['data']);
      }else{
        ErrorHandler().showError(ErrorEnum.error, jsonResponse, readMessage: true);
        return null;
      }

    }catch(e){
      return null;
    }
  }
    
}