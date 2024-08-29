import 'package:intl/intl.dart';
import 'package:webinar/common/data/app_language.dart';
import 'package:webinar/locator.dart';

extension CustomDate on DateTime {

  

  String toDate() => DateFormat('d MMM y',locator<AppLanguage>().currentLanguage).format(this);

  String toHour() => DateFormat('Hms',locator<AppLanguage>().currentLanguage).format(this);
  
  String toDayHour() {
    return '${DateFormat('d MMMM', locator<AppLanguage>().currentLanguage).format(this)}, ${DateFormat('Hm').format(this)}';
  } 


}


String dayHourMinuteSecondFormatted(Duration date) {
  return [
    date.inDays,
    date.inHours.remainder(24),
    date.inMinutes.remainder(60),
    date.inSeconds.remainder(60)
  ].map((seg) {
    return seg.toString().padLeft(2, '0');
  }).join(':');
}





String timeStampToDate(int timeStamp, {bool isUtc=true}) => DateFormat('d MMM y', locator<AppLanguage>().currentLanguage).format(DateTime.fromMillisecondsSinceEpoch(timeStamp, isUtc: isUtc));
String timeStampToDateHour(int timeStamp,{bool isUtc=true}) => DateFormat('d MMM y  hh:mm', locator<AppLanguage>().currentLanguage).format(DateTime.fromMillisecondsSinceEpoch(timeStamp, isUtc: isUtc));

String formatHHMMSS(int seconds) {
  int hours = (seconds / 3600).truncate();
  seconds = (seconds % 3600).truncate();
  int minutes = (seconds / 60).truncate();

  String hoursStr = (hours).toString().padLeft(2, '0');
  String minutesStr = (minutes).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  if (hours == 0) {
    return "$minutesStr:$secondsStr";
  }

  return "$hoursStr:$minutesStr:$secondsStr";
}

DateTime toLocal(String date){
  if(date.isEmpty){
    return DateTime.now();
  }
  return DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(date).toLocal();
}

String durationToString(int minutes) {
  var d = Duration(minutes:minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}

String secondDurationToString(int seconds) {
  var d = Duration(seconds:seconds);
  List<String> parts = d.toString().split(':');
  return '${parts[1].padLeft(2, '0')}:${parts[2].padLeft(2, '0').split('.').first}';
}
