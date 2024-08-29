
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/download_manager.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../../../common/data/app_data.dart';
import '../../../../../common/utils/constants.dart';
import '../../../../../common/utils/date_formater.dart';
import '../../../../../config/assets.dart';
import '../../../../models/certificate_model.dart';
import '../../../../widgets/main_widget/home_widget/single_course_widget/single_course_widget.dart';

class CertificatesDetailsPage extends StatefulWidget {
  static const String pageName = '/certificates-details';
  const CertificatesDetailsPage({super.key});

  @override
  State<CertificatesDetailsPage> createState() => _CertificatesDetailsPageState();
}

class _CertificatesDetailsPageState extends State<CertificatesDetailsPage> {

  CertificateModel? data;
  String? type;

  String? token;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      data = (ModalRoute.of(context)!.settings.arguments as List)[0];
      type = (ModalRoute.of(context)!.settings.arguments as List)[1];
      print(type);

      if(type == 'achievements'){
        data?.link = data?.certificate?.link;
        
      }


      setState(() {});
    });


    AppData.getAccessToken().then((value){
      setState(() {
        token = value;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        
        appBar: appbar(title: appText.certificateDetails),

        body: Stack(
          children: [

            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: padding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    space(20),
              
                    Text(
                      type == 'completion'
                        ? data?.webinar?.title ?? ''
                        : data?.quiz?.title ?? '',
                      style: style16Bold(),
                    ),


                    if(type == 'achievements')...{
                      space(4),
                      
                      Text(
                        data?.webinar?.title ?? '',
                        style: style12Regular().copyWith(color: greyA5),
                      ),
                    },

                    space(20),


                    if(type == 'completion' || data?.certificate != null)...{
                      AspectRatio(
                        aspectRatio: 16 / 10,
                        child: ClipRRect(
                          borderRadius: borderRadius(),
                          child: Image.network(
                            data?.link ?? '',
                            headers: {
                              "Authorization": "Bearer $token",
                              "Content-Type" : "application/json", 
                              'Accept' : 'application/json',
                              'x-api-key' : Constants.apiKey,
                            },
                            width: getSize().width,
                            height: getSize().width,
                          ),
                        ),
                      )
                    }else...{
                      AspectRatio(
                        aspectRatio: 16 / 10,
                        child: ClipRRect(
                          borderRadius: borderRadius(),
                          child: fadeInImage(
                            data?.webinar?.image ?? '', 
                            getSize().width, 
                            getSize().width
                          ),
                        ),
                      )
                    },

                    space(30),


                    if(type == 'completion')...{
                      
                      Column(
                        children: [
                          
                          space(0,width: getSize().width),

                          Text(
                            appText.shareCertificate,
                            style: style20Bold(),
                          ),
                          
                          space(10),
                          
                          Text(
                            appText.shareCertificateDesc,
                            style: style14Regular().copyWith(color: greyA5),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      )


                    }else...{
                      // info
                      Container(
                        padding: padding(),
                        width: getSize().width,
                        child: Wrap(
                          runSpacing: 21,
                          children: [

                            SingleCourseWidget.courseStatus(
                              appText.yourGrade, 
                              data?.userGrade?.toString() ?? '-', 
                              AppAssets.starSvg,
                              width:(getSize().width * .5) - 42,
                            ),
                            
                            SingleCourseWidget.courseStatus(
                              appText.passGrade, 
                              data?.quiz?.passmark?.toString() ?? '-', 
                              AppAssets.starSvg,
                              width:(getSize().width * .5) - 42,
                            ),

                            SingleCourseWidget.courseStatus(
                              appText.dateCreated, 
                              timeStampToDate((data?.createdAt ?? 0) * 1000), 
                              AppAssets.calendarSvg,
                              width:(getSize().width * .5) - 42,
                            ),
                           
                            SingleCourseWidget.courseStatus(
                              appText.certificateID, 
                              data?.certificate?.id.toString() ?? '-', 
                              AppAssets.starSvg,
                              width:(getSize().width * .5) - 42,
                            ),

                            
                          ],
                        ),
                      ),
                    },


                    space(130),
              
                  ],
                ),
              )
            ),




            if(data?.link != null)...{
              
              // button
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                bottom: 0,
                child: Container(
                  width: getSize().width,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 30
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      boxShadow(Colors.black.withOpacity(.1),blur: 15,y: -3)
                    ],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30))
                  ),

                  child: Row(
                    children: [

                      Expanded(
                        child: button(
                          onTap: () async {
                            downloadSheet(
                              data!.link!, 
                              '${data!.date ?? data!.quiz?.title!.replaceAll(' ', '_')}.png'
                            );
                          }, 
                          width: getSize().width, 
                          height: 51, 
                          text: appText.download, 
                          bgColor: green77(), 
                          textColor: Colors.white
                        ),
                      ),

                      space(0,width: 16),

                      Expanded(
                        child: button(
                          onTap: () async {
                            String directory = (await getApplicationSupportDirectory()).path;

                            if(await DownloadManager.findFile(directory, '${data!.date}.png', isOpen: false)){
                              Share.shareXFiles([XFile('$directory/${data!.date}.png')]);
                            }else{
                              String? res = await downloadSheet(data!.link!, '${data!.date}.png', isOpen: false);

                              Share.shareXFiles([XFile(res!)]);
                            }
                          }, 
                          width: getSize().width,
                          height: 52, 
                          text: appText.share, 
                          bgColor: Colors.white, 
                          textColor: green77(),
                          borderColor: green77()
                        ),
                      ),
                      
                    
                    ],
                  ),
                ),
              ),

            }

          ],
        ),

      )
    );
  }
}