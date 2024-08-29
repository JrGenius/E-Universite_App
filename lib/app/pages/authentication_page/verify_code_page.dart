import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/services/authentication_service/authentication_service.dart';
import 'package:webinar/app/widgets/authentication_widget/register_widget/register_widget.dart';
import 'package:webinar/common/common.dart';

import '../../../common/data/api_public_data.dart';
import '../../../common/enums/page_name_enum.dart';
import '../../../common/utils/app_text.dart';
import '../../../config/assets.dart';
import '../../../config/colors.dart';
import '../../../config/styles.dart';
import '../../../common/components.dart';
import '../../../locator.dart';
import '../../providers/page_provider.dart';
import '../main_page/main_page.dart';

class VerifyCodePage extends StatefulWidget {
  static const String pageName = '/verify-code';
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();

  FocusNode codeNode1 = FocusNode();
  FocusNode codeNode2 = FocusNode();
  FocusNode codeNode3 = FocusNode();
  FocusNode codeNode4 = FocusNode();
  FocusNode codeNode5 = FocusNode();

  bool isEmptyInputs = true;
  bool isSendingData = false;
  bool isCodeAgain = false;

  late Map data;

  @override
  void initState() {
    super.initState();
    
    controller1.addListener(() {
      if(getCode().length == 5){
        if(isEmptyInputs){
          setState(() {
            isEmptyInputs = false;
          });
        }
      }else{
        if(!isEmptyInputs){
          setState(() {
            isEmptyInputs = true;
          });
        }
      }
    });
    
    controller2.addListener(() {
      if(getCode().length == 5){
        if(isEmptyInputs){
          setState(() {
            isEmptyInputs = false;
          });
        }
      }else{
        if(!isEmptyInputs){
          setState(() {
            isEmptyInputs = true;
          });
        }
      }
    });

    controller3.addListener(() {
      if(getCode().length == 5){
        if(isEmptyInputs){
          setState(() {
            isEmptyInputs = false;
          });
        }
      }else{
        if(!isEmptyInputs){
          setState(() {
            isEmptyInputs = true;
          });
        }
      }
    });

    controller4.addListener(() {
      if(getCode().length == 5){
        if(isEmptyInputs){
          setState(() {
            isEmptyInputs = false;
          });
        }
      }else{
        if(!isEmptyInputs){
          setState(() {
            isEmptyInputs = true;
          });
        }
      }
    });

    controller5.addListener(() {
      if(getCode().length == 5){
        if(isEmptyInputs){
          setState(() {
            isEmptyInputs = false;
          });
        }
      }else{
        if(!isEmptyInputs){
          setState(() {
            isEmptyInputs = true;
          });
        }
      }
    });


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      data = ModalRoute.of(context)!.settings.arguments as Map;
    });


  }

  String getCode(){
    return controller1.text.trim() + controller2.text.trim() + controller3.text.trim() + controller4.text.trim() + controller5.text.trim();
  }

  onPastedCode(String code){
    List<String> items = code.split('');
    controller1.text = items[0];
    controller2.text = items[1];
    controller3.text = items[2];
    controller4.text = items[3];
    controller5.text = items[4];
    FocusScope.of(navigatorKey.currentContext!).unfocus();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return directionality(
      child: Scaffold(
        body: Stack(
          children: [

            Positioned.fill(
              child: Image.asset(
                AppAssets.introBgPng,
                width: getSize().width,
                height: getSize().height,
                fit: BoxFit.cover,
              )
            ),

            Positioned.fill(
              child: Padding(
                padding: padding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    space(getSize().height * .11),
              
                    // title
                    Row(
                      children: [
              
                        Text(
                          appText.accountVerification,
                          style: style24Bold(),
                        ),
              
                        space(0,width: 4),
              
                        SvgPicture.asset(AppAssets.emoji2Svg)
                      ],
                    ),
              
                    // desc
                    Text(
                      appText.accountVerificationDesc,
                      style: style14Regular().copyWith(color: greyA5),
                    ),
              
                    const Spacer(),
              
              
                    Directionality(
                      textDirection: TextDirection.ltr,
              
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          RegisterWidget.codeInput(controller1, codeNode1, codeNode2, null, onPastedCode),
                    
                          space(0,width: 10),
                          
                          RegisterWidget.codeInput(controller2, codeNode2, codeNode3, codeNode1, onPastedCode),
                          
                          space(0,width: 10),
                          
                          RegisterWidget.codeInput(controller3, codeNode3, codeNode4, codeNode2, onPastedCode),
                          
                          space(0,width: 10),
                          
                          RegisterWidget.codeInput(controller4, codeNode4, codeNode5, codeNode3, onPastedCode),
                          
                          space(0,width: 10),
                          
                          RegisterWidget.codeInput(controller5, codeNode5, null, codeNode4, onPastedCode),
                        ],
                      ),
                    ),

                    const Spacer(),


                    Center(
                      child: button(
                        onTap: () async {
                    
                          if(!isEmptyInputs){
                            String code = controller1.text + controller2.text + controller3.text + controller4.text + controller5.text;
                          
                            if(code.length == 5){
                              setState(() {
                                isSendingData = true;
                              });
                            
                              bool res = await AuthenticationService.verifyCode(data['user_id'], code);
                    
                              if(res){
                                await FirebaseMessaging.instance.deleteToken();
                                
                                locator<PageProvider>().setPage(PageNames.home);
                                nextRoute(MainPage.pageName, isClearBackRoutes: true, arguments: data['user_id']);
                              }
                              
                              setState(() {
                                isSendingData = false;
                              });
                            }
                          }
                    
                        }, 
                        width: getSize().width, 
                        height: 52, 
                        text: appText.verifyMyAccount, 
                        bgColor: isEmptyInputs ? greyCF : green77(), 
                        textColor: Colors.white, 
                        borderColor: Colors.transparent,
                        isLoading: isSendingData
                      ),
                    ),

                    space(16),

                    Center(
                      child: Text(
                        appText.haventReceiveTheCode,
                        style: style14Regular().copyWith(color: greyB2),
                      ),
                    ),
                    
                    Center(
                      child: isCodeAgain
                    ? loading()
                    : GestureDetector(
                        onTap: () async {

                          if(PublicData.apiConfigData['register_method'] == 'email'){

                            setState(() {
                              isCodeAgain = true;
                            });

                            Map? res = await AuthenticationService.registerWithEmail( // email
                              PublicData.apiConfigData?['register_method'],
                              data['email'], 
                              data['password'], 
                              data['retypePassword'],
                              'user',
                              []
                            );

                            if(res != null){
                              controller1.clear();
                              controller2.clear();
                              controller3.clear();
                              controller4.clear();
                              controller5.clear();
                            }
                            
                            setState(() {
                              isCodeAgain = false;
                            });
                            
                          }else{
                            
                            setState(() {
                              isCodeAgain = true;
                            });

                            Map? res = await AuthenticationService.registerWithPhone( // mobile
                              PublicData.apiConfigData?['register_method'],
                              data['countryCode'], 
                              data['phone'], 
                              data['password'],
                              data['retypePassword'],
                              'user',
                              []
                            );
                            
                            if(res != null){
                              controller1.clear();
                              controller2.clear();
                              controller3.clear();
                              controller4.clear();
                              controller5.clear();
                            }
                            
                            setState(() {
                              isCodeAgain = false;
                            });
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Text(
                          appText.resendCode,
                          style: style16Regular(),
                        ),
                      ),
                    ),
                  
                    const Spacer(),
                    const Spacer(),

                  ],
                ),
              )
            )
          ],
        ),
      )
    );
  }
}