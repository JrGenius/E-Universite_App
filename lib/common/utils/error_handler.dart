
import 'package:webinar/common/enums/error_enum.dart';

import '../components.dart';

class ErrorHandler{

  showError(ErrorEnum type,dynamic jsonResponse,{String? title,bool readMessage=false}){

    if(!readMessage){
      List<String> errors = [];
      
      jsonResponse['data']?['errors']?.forEach((k,v){
        errors.add(v.first);
      });

      if(errors.isNotEmpty){
        showSnackBar(type, null, desc: errors.first);
      }

    }else{
      showSnackBar(type, null, desc: jsonResponse['message']);
    }
    
  }
}