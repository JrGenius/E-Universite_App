import 'dart:io';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/enums/error_enum.dart';
import 'package:webinar/locator.dart';

import '../data/app_data.dart';
import '../data/app_language.dart';
import 'constants.dart';

class DownloadManager{

  static List<FileSystemEntity> files = [];


  static Future<void> download(String url,Function(int progress) onDownlaod,{CancelToken? cancelToken,String? name,Function? onLoadAtLocal, bool isOpen=true}) async {

    PermissionStatus res = await Permission.storage.request();
    PermissionStatus res2 = await Permission.photos.request();

    if(res.isGranted || res2.isGranted){
      String directory = (await getApplicationSupportDirectory()).path;

      
      if(! (await findFile(directory, name ?? url.split('/').last, onLoadAtLocal: onLoadAtLocal )) ){
        
        String token = await AppData.getAccessToken();

        Map<String, String> headers = {
          "Authorization": "Bearer $token",
          "Accept" : "application/json",
          'x-api-key' : Constants.apiKey,
          'x-locale' : locator<AppLanguage>().currentLanguage.toLowerCase(),
        };

        try{
          await locator<Dio>().download(
            url, 
            '$directory/${ name ?? url.split('/').last}',
            onReceiveProgress: (count, total) {
              onDownlaod((count / total * 100).toInt());
            },
            cancelToken: cancelToken,
            options: Options(
              followRedirects: true,
              headers: headers
            )
            
          ).then((value) {

            if(value.statusCode == 200){
              if(navigatorKey.currentContext!.mounted){
                backRoute(arguments: '$directory/${ name ?? url.split('/').last}');
              }

              if(isOpen){
                OpenFile.open('$directory/${ name ?? url.split('/').last}');
              }
            }

          });
        }on DioException catch (e) {
          showSnackBar(ErrorEnum.error, e.message);
        }


      } 
    }
    

  }

  static Future<bool> findFile(String directory, String name,{Function? onLoadAtLocal, bool isOpen=true}) async {
    bool state=false;

    files = Directory(directory).listSync().toList();
    
    for (var i = 0; i < files.length; i++) {
      if(files[i].path.contains(name)){
        
        if(onLoadAtLocal != null){
          onLoadAtLocal();
        }

        if(isOpen){
          OpenFile.open(files[i].path);
        }
        return true;
      }
    }

    return state;
  }
}