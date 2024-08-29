import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:webinar/app/providers/app_language_provider.dart';
import 'package:webinar/app/providers/drawer_provider.dart';
import 'package:webinar/common/data/app_language.dart';
import 'app/providers/filter_course_provider.dart';
import 'app/providers/page_provider.dart';
import 'app/providers/providers_provider.dart';
import 'app/providers/user_provider.dart';
import 'common/utils/currency_utils.dart';

GetIt locator = GetIt.instance;


locatorSetup()async{

  locator.registerSingleton<Dio>(Dio());
  
  locator.registerSingleton<AppLanguage>(AppLanguage());
  locator.registerSingleton<CurrencyUtils>(CurrencyUtils());
  // locator.registerSingleton<AdvancedDrawerController>(AdvancedDrawerController());

  // Providers
  locator.registerSingleton<AppLanguageProvider>(AppLanguageProvider());
  locator.registerSingleton<PageProvider>(PageProvider());
  locator.registerSingleton<FilterCourseProvider>(FilterCourseProvider());
  locator.registerSingleton<ProvidersProvider>(ProvidersProvider());
  locator.registerSingleton<UserProvider>(UserProvider());
  locator.registerSingleton<DrawerProvider>(DrawerProvider());
  
  

}