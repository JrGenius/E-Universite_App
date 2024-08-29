import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:webinar/app/models/login_history_model.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/guest_service/guest_service.dart';
import 'package:webinar/app/services/guest_service/location_service.dart';
import 'package:webinar/app/services/user_service/user_service.dart';
import 'package:webinar/app/widgets/main_widget/setting_widget/setting_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/enums/error_enum.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/styles.dart';
import 'package:webinar/locator.dart';

import '../../../../../config/colors.dart';
import '../../../../models/location_model.dart';

class SettingPage extends StatefulWidget {
  static const String pageName = '/profile';
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with TickerProviderStateMixin{

  late TabController tabController;

  bool isLocalImage = false;
  File? localImage;



  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  FocusNode nameNode = FocusNode();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneNode = FocusNode();
  TextEditingController refUrlController = TextEditingController();
  FocusNode refUrlNode = FocusNode();
  TextEditingController languageController = TextEditingController();
  FocusNode languageNode = FocusNode();

  bool newsletter = false;

  TextEditingController currentPasswordController = TextEditingController();
  FocusNode currentPasswordNode = FocusNode();
  TextEditingController newPasswordController = TextEditingController();
  FocusNode newPasswordNode = FocusNode();
  TextEditingController retypePasswordController = TextEditingController();
  FocusNode retypePasswordNode = FocusNode();


  TextEditingController accountTypeController = TextEditingController();
  FocusNode accountTypeNode = FocusNode();
  TextEditingController ibanController = TextEditingController();
  FocusNode ibanNode = FocusNode();
  TextEditingController accountIdController = TextEditingController();
  FocusNode accountIdNode = FocusNode();
  TextEditingController addressController = TextEditingController();
  FocusNode addressNode = FocusNode();

  File? indentityScanImage;
  File? certificateImage;
  bool isApprovedIndentity = false;
  bool isApprovedCertificate = false;

  List<LocationModel> countries = [];
  LocationModel? selectedCountry;
  
  List<String> timeZoneData = [];
  String? timeZoneSelected;

  int? provinceSelectedId;
  int? citySelectedId;
  int? districtSelectedId;


  bool isLoading = false;

  List<LoginHistoryModel> loginHistory = [];


  @override
  void initState() {
    super.initState();
    
    tabController = TabController(length: 4, vsync: this);

    emailController.text = locator<UserProvider>().profile?.email ?? '';
    nameController.text = locator<UserProvider>().profile?.fullName ?? '';
    phoneController.text = locator<UserProvider>().profile?.mobile ?? '';
    refUrlController.text = locator<UserProvider>().profile?.mobile ?? '';

    newsletter = locator<UserProvider>().profile?.newsletter ?? false;

    addressController.text = locator<UserProvider>().profile?.address ?? '';
    ibanController.text = locator<UserProvider>().profile?.iban ?? '';
    accountIdController.text = locator<UserProvider>().profile?.accountId ?? '';

    timeZoneSelected = locator<UserProvider>().profile?.timezone;
    provinceSelectedId = locator<UserProvider>().profile?.provinceId;
    citySelectedId = locator<UserProvider>().profile?.cityId;
    districtSelectedId = locator<UserProvider>().profile?.districtId;



    LocationService.getCountries().then((value) {
      countries = value;
      selectedCountry = countries.singleWhere((element) => element.id == (locator<UserProvider>().profile?.countryId));

      setState(() {});
    });

    GuestService.getTimeZone().then((value) {
      timeZoneData = value;
      setState(() {});
    });

    UserService.getLoginHistory().then((value){
      loginHistory = value;
      setState(() {});
    });

  }


  Future<File> compressImage(XFile file) async {
    
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String address = '${appDocDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      address,
      quality: 55,
      minWidth: 550,
    );   

    
    return File(result!.path);
  }



  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.settings),

        body: Stack(
          children: [

            Positioned.fill(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  
                  // image and name
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        space(20),

                        // image
                        Stack(
                          clipBehavior: Clip.none,
                          children: [

                            GestureDetector(
                              onTap: () async {
                                // final ImagePicker picker = ImagePicker();
                                // final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                                // if(image != null){
                                //   localImage = await compressImage(image);

                                //   setState(() {});
                                // }
                              },
                              child: Container(
                                width: 95,
                                height: 95,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: green77(),
                                    width: 5
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    boxShadow(
                                      green77().withOpacity(.25), blur: 30, y: 2
                                    )
                                  ]
                                ),
                            
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: borderRadius(radius: 120),
                                    child: localImage == null 
                                      ? fadeInImage( (locator<UserProvider>().profile?.avatar) ?? '', 80, 80 )
                                      : Image.file( localImage!, width: 80, height: 80, fit: BoxFit.cover ),
                                  ),
                                ),
                              ),
                            ),


                            // Positioned(
                            //   bottom: -10,
                            //   left: 0,
                            //   right: 0,
                            //   child: Container(
                            //     width: 35,
                            //     height: 35,

                            //     decoration: const BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       color: Colors.white
                            //     ),

                            //     alignment: Alignment.center,
                            //     child: SvgPicture.asset(AppAssets.cameraSvg),
                            //   )
                            // )
                          ],
                        ),

                        space(20),

                        Text(
                          locator<UserProvider>().profile?.fullName ?? '',
                          style: style20Bold(),
                        ),
                        
                        space(4),
                        
                        Text(
                          locator<UserProvider>().profile?.roleName ?? '',
                          style: style12Regular().copyWith(color: greyA5),
                        ),
                      ],
                    ),
                  ),

                  SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: greyFA,
                    titleSpacing: 0,
                    elevation: 10,
                    shadowColor: Colors.black12,
                    title: tabBar((p0) {}, tabController, [
                      Tab(text: appText.general, height: 32),
                      Tab(text: appText.security, height: 32),
                      Tab(text: appText.financial, height: 32),
                      Tab(text: appText.localization, height: 32),
                    ]),
                  ),

                  

                  SliverFillRemaining(
                    child: TabBarView(
                      controller: tabController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        
                        SettingWidget.generalPage(
                          emailController, emailNode, nameController, nameNode, phoneController, phoneNode, 
                          refUrlController, refUrlNode, languageController, languageNode, newsletter,
                          (){
                            setState(() {});
                          },
                          (val){
                            newsletter = val;
                            setState(() {});
                          }
                        ),
                        
                        
                        SettingWidget.securityPage(
                          currentPasswordController, currentPasswordNode,
                          newPasswordController, newPasswordNode, 
                          retypePasswordController, retypePasswordNode,
                          loginHistory
                        ),


                        SettingWidget.financialPage(
                          accountTypeController, accountTypeNode, ibanController, ibanNode,
                          accountIdController, accountIdNode, addressController, addressNode, 
                          (){
                            setState(() {});
                          },
                          indentityScanImage,
                          certificateImage,
                          locator<UserProvider>().profile?.identityScan != null,
                          locator<UserProvider>().profile?.certificate != null,
                          (ImageSource source) async { //selectIndentityImage 
                            
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: source);

                            if(image != null){
                              indentityScanImage = await compressImage(image);

                              setState(() {});
                            }

                          },
                          () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                            if(image != null){
                              certificateImage = await compressImage(image);

                              setState(() {});
                            }
                          }
                        ),
                        

                        SettingWidget.localizationPage(
                          countries,
                          selectedCountry,
                          (data){
                            selectedCountry = data;
                            setState(() {});
                          },

                          timeZoneData,
                          timeZoneSelected,
                          (data){
                            timeZoneSelected = data;
                            setState(() {});
                          },
                          
                          provinceSelectedId,
                          (id){
                            provinceSelectedId = id;
                            setState(() {});
                          },
                          
                          citySelectedId,
                          (id){
                            citySelectedId = id;
                            setState(() {});
                          },
                          
                          districtSelectedId,
                          (id){
                            districtSelectedId = id;
                            setState(() {});
                          },

                        )

                      ]
                    ),
                  )


                ],
              )
            ),




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

                child: Center(
                  child: button(
                    onTap: () async {
                
                      setState(() {
                        isLoading = true;
                      });

                      
                      bool res = await UserService.updateInfo(
                        emailController.text.trim().toEnglishDigit(), 
                        nameController.text.trim().toEnglishDigit(), 
                        phoneController.text.trim().toEnglishDigit(), 
                        timeZoneSelected ?? '', 
                        newsletter, 
                        ibanController.text.trim().toEnglishDigit(), 
                        accountTypeController.text.trim().toEnglishDigit(), 
                        accountIdController.text.trim().toEnglishDigit(), 
                        addressController.text.trim().toEnglishDigit(), 
                        selectedCountry?.id, 
                        provinceSelectedId, citySelectedId, districtSelectedId
                      );
                
                      
                      if(res){
                        if(currentPasswordController.text.trim().isNotEmpty && newPasswordController.text.trim().isNotEmpty){

                          if(newPasswordController.text.trim().compareTo(retypePasswordController.text.trim()) == 0){
                            await UserService.updatePassword(
                              currentPasswordController.text.trim().toEnglishDigit(), 
                              newPasswordController.text.trim().toEnglishDigit(),
                            ); 
                          }else{
                            showSnackBar(ErrorEnum.success, appText.passwordAndRetypePassNotMatch);
                          }
                        }


                        if(localImage != null || indentityScanImage != null || certificateImage != null){
                          await UserService.updateImage(localImage, indentityScanImage, certificateImage);
                        }

                        if(mounted){
                          backRoute();
                        }
                      }
                      
                      setState(() {
                        isLoading = false;
                      });
                    }, 
                    width: getSize().width, 
                    height: 51, 
                    text: appText.save, 
                    bgColor: green77(), 
                    textColor: Colors.white,
                    isLoading: isLoading
                  ),
                ),
              
              ),
            ),


          ],
        ),
      )
    );
  }
}