import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webinar/app/models/login_history_model.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';

import '../../../../common/data/app_language.dart';
import '../../../../config/colors.dart';
import '../../../../config/styles.dart';
import '../../../../locator.dart';
import '../../../models/location_model.dart';
import '../../../services/guest_service/location_service.dart';
import '../main_widget.dart';

class SettingWidget {


  static Widget generalPage(
    TextEditingController emailController,
    FocusNode emailNode,
    TextEditingController nameController,
    FocusNode nameNode,
    TextEditingController phoneController,
    FocusNode phoneNode,
    TextEditingController refUrlController,
    FocusNode refUrlNode,
    TextEditingController languageController,
    FocusNode languageNode,
    bool newsletter,

    Function onTapChangeState,
    Function(bool value) onTapChangeNewsletter,
  ){

    languageController.text = locator<AppLanguage>().appLanguagesData[locator<AppLanguage>().appLanguagesData.indexWhere((element) => element.code!.toLowerCase() == locator<AppLanguage>().currentLanguage.toLowerCase())].name ?? '';

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: padding(),

      child: Column(
        children: [


          space(12),

          input(emailController, emailNode, appText.email, isBorder: true, title: appText.email),

          space(14),
          
          input(nameController, nameNode, appText.name, isBorder: true, title: appText.name),

          space(14),
          
          input(phoneController, phoneNode, appText.phone, isBorder: true, title: appText.phone),

          space(14),
          
          input(languageController, languageNode, appText.language, isBorder: true, title: appText.language, isReadOnly: true, rightIconPath: AppAssets.arrowDownSvg, rightIconSize: 16, onTap: () async {
            await MainWidget.showLanguageDialog();

            onTapChangeState();
          }),

          // space(14),

          // input(refUrlController, refUrlNode, appText.referralURL, isBorder: true, title: appText.referralURL, rightIconPath: AppAssets.copySvg, rightIconSize: 16,isReadOnly: true,  onTap: (){

          // }),

          space(14),

          switchButton(
            appText.joinNewsletter, 
            newsletter, 
            (value) {
              onTapChangeNewsletter(value);
            }
          ),

          space(150),

        ],
      ),
    );

  }

  static Widget securityPage(
    
    TextEditingController currentPasswordController,
    FocusNode currentPasswordNode,
    
    TextEditingController newPasswordController,
    FocusNode newPasswordNode,
    TextEditingController retypePasswordController,
    FocusNode retypePasswordNode,

    List<LoginHistoryModel> loginHistory
  ){
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),

      child: Column(
        children: [

          Padding(
            padding: padding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space(12),
            
                input(currentPasswordController, currentPasswordNode, '', isBorder: true, title: appText.currentPassword),
              
                space(14),
              
                input(newPasswordController, newPasswordNode, '', isBorder: true, title: appText.newPassword),
            
                space(14),
                
                input(retypePasswordController, retypePasswordNode, '', isBorder: true, title: appText.retypePassword),
            
                space(18),
                
                Text(
                  appText.loginHistory,
                  style: style14Bold(),
                ),
            
                space(4),
            
                Text(
                  appText.loginHistoryDesc,
                  style: style12Regular().copyWith(color: greyB2),
                ),
            
                space(12),
              ],
            ),
          ),



          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              
              headingRowColor: MaterialStateProperty.all(greyE7.withOpacity(.2)),
              border: const TableBorder(
                horizontalInside: BorderSide(color: Colors.white, width: 2),
              ),
              
              decoration: const BoxDecoration(),

              columns: [
                DataColumn(label: Text(appText.os, style: style14Bold().copyWith(color: Colors.black))),
                DataColumn(label: Text(appText.browser, style: style14Bold().copyWith(color: Colors.black))),
                DataColumn(label: Text(appText.device, style: style14Bold().copyWith(color: Colors.black))),
                DataColumn(label: Text(appText.ip, style: style14Bold().copyWith(color: Colors.black))),
              ], 
              
              rows: List.generate(loginHistory.length, (index) {
                return DataRow(
                  selected: false,
                  color: MaterialStateProperty.all((index % 2 == 1) ? greyE7.withOpacity(.2) : Colors.white),
                  cells: [
                    DataCell(Text(loginHistory[index].os ?? '', style: style12Regular().copyWith(color: greyA5))),
                    DataCell(Text(loginHistory[index].browser ?? '', style: style12Regular().copyWith(color: greyA5))),
                    DataCell(Text(loginHistory[index].device ?? '', style: style12Regular().copyWith(color: greyA5))),
                    DataCell(Text(loginHistory[index].ip ?? '', style: style12Regular().copyWith(color: greyA5))),
                  ]
                );
              }),

            ),
          )


        ],
      ),
    );
  }

  static Widget financialPage(
    TextEditingController accountTypeController,
    FocusNode accountTypeNode,
    TextEditingController ibanController,
    FocusNode ibanNode,
    TextEditingController accountIdController,
    FocusNode accountIdNode,
    TextEditingController addressController,
    FocusNode addressNode,
    
    Function onTapChangeState,

    File? indentityScanImage,
    File? certificateImage,
    bool isApprovedIndentity,
    bool isApprovedCertificate,

    Function(ImageSource source) selectIndentityImage,
    Function() selectCertificateImage,
    
  ){


    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: padding(),

      child: Column(
        children: [

          // space(12),

          // // important
          // Container(
          //   width: getSize().width,
          //   padding: padding(horizontal: 10, vertical: 10),

          //   decoration: BoxDecoration(
          //     borderRadius: borderRadius(),
          //     border: Border.all(color: greyE7),
          //   ),
            
          //   child: Row(
          //     children: [

          //       // icon
          //       Container(
          //         width: 45,
          //         height: 45,
          //         decoration: BoxDecoration(
          //           color: red49,
          //           shape: BoxShape.circle,
          //         ),
                  
          //         alignment: Alignment.center,
          //         child: SvgPicture.asset(AppAssets.dangerSvg, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn), width: 20),
          //       ),

          //       space(0, width: 10),

          //       Expanded(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
                
          //             Text(
          //               appText.financialApproval,
          //               style: style14Bold(),
          //             ),

          //             space(5),                                  
                      
          //             Text(
          //               appText.financialApprovalDesc,
          //               style: style12Regular().copyWith(color: greyA5),
          //             ),
                
          //           ],
          //         ),
          //       ),


                

          //     ],
          //   ),
          // ),


          space(12),

          input(accountTypeController, accountTypeNode, appText.accountType, isBorder: true, title: appText.accountType, isReadOnly: true, rightIconPath: AppAssets.arrowDownSvg, rightIconSize: 16, onTap: () async {
            // await MainWidget.showCurrencyDialog();

            // onTapChangeState();
          }),
          
          space(14),
          
          
          input(ibanController, ibanNode, appText.iban, isBorder: true, title: appText.iban),

          space(14),
          
          input(accountIdController, accountIdNode, appText.accountID, isBorder: true, title: appText.accountID),

          // space(14),

          // // identity
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [

          //     Padding(
          //       padding: padding(horizontal: 6),
          //       child: Text(
          //         appText.identityScan,
          //         style: style12Regular().copyWith(color: greyA5),
          //       ),
          //     ),

          //     space(8),

          //     Row(
          //       children: [

          //         if(isApprovedIndentity)...{
          //           Expanded(
          //             child: button(
          //               onTap: (){}, 
          //               width: getSize().width, 
          //               height: 52, 
          //               text: appText.approved,
          //               bgColor: greyE7, 
          //               textColor: greyB2
          //             )
          //           )
          //         }else...{
          //           Expanded(
          //             child: button(
          //               onTap: (){
          //                 selectIndentityImage(ImageSource.camera);
          //               }, 
          //               width: getSize().width, 
          //               height: 52, 
          //               text: appText.camera,
          //               bgColor: green77(), 
          //               textColor: Colors.white,
          //               iconPath: AppAssets.camera2Svg,
          //               iconColor: Colors.white
          //             )
          //           ),

          //           space(0,width: 16),

          //           Expanded(
          //             child: button(
          //               onTap: (){
          //                 selectIndentityImage(ImageSource.gallery);
          //               }, 
          //               width: getSize().width, 
          //               height: 52, 
          //               text: appText.upload,
          //               bgColor: green77(), 
          //               textColor: Colors.white,
          //               iconPath: AppAssets.uploadSvg,
          //               iconColor: Colors.white
          //             )
          //           ),
          //         }

          //       ],
          //     )
          //   ],
          // ),
          
          // space(14),

          // // certificate
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [

          //     Padding(
          //       padding: padding(horizontal: 6),
          //       child: Text(
          //         appText.certificatesDocuments,
          //         style: style12Regular().copyWith(color: greyA5),
          //       ),
          //     ),

          //     space(8),

          //     button(
          //       onTap: (){
          //         if(!isApprovedCertificate){
          //           selectCertificateImage();
          //         }
          //       }, 
          //       width: getSize().width, 
          //       height: 52, 
          //       text: isApprovedCertificate ? appText.approved : appText.upload,
          //       bgColor: isApprovedCertificate ? greyE7 : green77(), 
          //       textColor: isApprovedCertificate ? greyA5 :Colors.white,
          //       iconPath: isApprovedCertificate ? null : AppAssets.uploadSvg,
          //       iconColor: Colors.white
          //     ),
          //   ],
          // ),

          space(14),
          
          input(addressController, addressNode, appText.address, isBorder: true, title: appText.address),

          

          space(150),

        ],
      ),
    );

  }

  static Widget localizationPage(
    List<LocationModel> countries,
    LocationModel? selectedCountry,
    Function(LocationModel val) onTapCountry,

    List<String> timeZoneData,
    String? timeZoneSelected,
    Function(String val) onTapTimezone,
    
    int? provinceSelectedId,
    Function(int? val) onTapProvince,
    
    int? citySelectedId,
    Function(int? val) onTapCity,

    int? districtSelectedId,
    Function(int? val) onTapDistrict,
  ){

    bool isOpenTimeZone = false;
    bool isOpenCountry = false;
    bool isOpenProvince = false;
    bool isOpenCities = false;
    bool isOpenDistrict = false;

    List<LocationModel> provinces = [];
    List<LocationModel> cities = [];
    List<LocationModel> districts = [];


    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: padding(),
      
      child: StatefulBuilder(
        builder: (context, state) {
          return Column(
            children: [

              space(12),

              // timeZone
              dropDown(
                appText.timeZone, 
                timeZoneSelected ?? '', 
                List.generate(timeZoneData.length, (index) {
                  return timeZoneData[index];
                }), 
                (){
                  
                  isOpenTimeZone = !isOpenTimeZone;
                  state((){});
                }, 
                (newValue, index) {
                  onTapTimezone(newValue);
                  isOpenTimeZone = false;
                  state((){});
                }, 
                isOpenTimeZone,
                title: appText.timeZone
              ),
              
              space(12),

              // country
              dropDown(
                appText.country, 
                selectedCountry?.title ?? '', 
                List.generate(countries.length, (index) {
                  return countries[index].title ?? '';
                }), 
                (){
                  
                  isOpenCountry = !isOpenCountry;
                  state((){});
                }, 
                (newValue, index) {
                  onTapProvince(null);
                  onTapCity(null);
                  onTapDistrict(null);

                  onTapCountry(countries[index]);
                  isOpenCountry = false;
                  state((){});
                }, 
                isOpenCountry,
                title: appText.country
              ),

              space(12),

              // province
              FutureBuilder(
                future: selectedCountry == null ? null : LocationService.getProvince(selectedCountry.id!),
                builder: (context, snapshot) {
          
                  String title = '';

                  if(snapshot.connectionState == ConnectionState.done){
                    provinces.clear();
                    provinces.addAll(snapshot.data as List<LocationModel>);
                  }

                  for (var element in provinces) {
                    if(element.id == provinceSelectedId){
                      title = element.title ?? '';
                    }
                  }


                  return dropDown(
                    appText.province, 
                    title, 
                    List.generate(provinces.length, (index) {
                      return provinces[index].title ?? '';
                    }), 
                    (){
                      isOpenProvince = !isOpenProvince;
                      state((){});
                    }, 
                    (newValue, index) {
                      onTapProvince(provinces[index].id!);
                      isOpenProvince = false;
                      state((){});
                    }, 
                    isOpenProvince,
                    title: appText.province,
                  );
                },
              ),
              
              space(12),

              // city
              FutureBuilder(
                future: provinceSelectedId == null ? null : LocationService.getCity(provinceSelectedId),
                builder: (context, snapshot) {
          
                  String title = '';

                  if(snapshot.connectionState == ConnectionState.done){
                    cities.clear();
                    cities.addAll(snapshot.data as List<LocationModel>);
                  }

                  for (var element in cities) {
                    if(element.id == citySelectedId){
                      title = element.title ?? '';
                    }
                  }


                  return dropDown(
                    appText.city, 
                    title, 
                    List.generate(cities.length, (index) {
                      return cities[index].title ?? '';
                    }), 
                    (){
                      isOpenCities = !isOpenCities;
                      state((){});
                    }, 
                    (newValue, index) {
                      onTapCity(cities[index].id!);
                      isOpenCities = false;
                      state((){});
                    }, 
                    isOpenCities,
                    title: appText.city,
                  );
                },
              ),

              space(12),

              // district
              FutureBuilder(
                future: citySelectedId == null ? null : LocationService.getDistricts(citySelectedId),
                builder: (context, snapshot) {
          
                  String title = '';

                  if(snapshot.connectionState == ConnectionState.done){
                    districts.clear();
                    districts.addAll(snapshot.data as List<LocationModel>);
                  }

                  for (var element in districts) {
                    if(element.id == districtSelectedId){
                      title = element.title ?? '';
                    }
                  }


                  return dropDown(
                    appText.district, 
                    title, 
                    List.generate(districts.length, (index) {
                      return districts[index].title ?? '';
                    }), 
                    (){
                      isOpenDistrict = !isOpenDistrict;
                      state((){});
                    }, 
                    (newValue, index) {
                      onTapDistrict(districts[index].id!);
                      isOpenDistrict = false;
                      state((){});
                    }, 
                    isOpenDistrict,
                    title: appText.district,
                  );
                },
              )




            ],
          );
        }
      ),

    );
  }


}