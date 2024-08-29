import 'package:shared_preferences/shared_preferences.dart';
import '../../app/widgets/authentication_widget/country_code_widget/code_country.dart';
import '../../config/assets.dart';

class AppLanguage{
  
  late String currentLanguage;
  List<String> rtlLanguage = ['ar'];

  bool isRtl() => rtlLanguage.contains(currentLanguage.toLowerCase());

  List<CountryCode> appLanguagesData = [
    CountryCode(
      name: "English (US)",
      code: "EN",
      dialCode: '+1',
      flagUri: '${AppAssets.flags}${"en".toLowerCase()}.png',
    ),

    CountryCode(
      name: "Arabic",
      code: "AR",
      dialCode: '+966',
      flagUri: '${AppAssets.flags}${"sa".toLowerCase()}.png',
    ),
  ];

  Future saveLanguage(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', data);
    await getLanguage();
    return true;
  }

  Future getLanguage() async {    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentLanguage = prefs.getString('language') ?? 'en';
    return currentLanguage;
  }
}