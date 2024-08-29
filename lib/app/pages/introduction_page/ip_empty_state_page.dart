import 'package:flutter/material.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/config/styles.dart';


bool isNavigatedIpPage = false;

class IpEmptyStatePage extends StatefulWidget {
  static const String pageName = '/ip-empty-state';
  const IpEmptyStatePage({super.key});

  @override
  State<IpEmptyStatePage> createState() => _IpEmptyStatePageState();
}

class _IpEmptyStatePageState extends State<IpEmptyStatePage> {

  Map? data;

  @override
  void initState() {
    super.initState();
    isNavigatedIpPage = true;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      data = ModalRoute.of(context)!.settings.arguments as Map;

      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            space(0,width: getSize().width),

            fadeInImage(data?['image'] ?? '', getSize().width * .5, getSize().width * .5),
            
            space(20),

            Text(
              data?['title'] ?? '',
              style: style12Bold().copyWith(fontSize: 18),
            ),

            space(10),

            Text(
              data?['description'] ?? '',
              style: style14Regular(),
            ),
          ],
        ),
      )
    );
  }


  @override
  void dispose() {
    isNavigatedIpPage = false;
    super.dispose();
  }
}