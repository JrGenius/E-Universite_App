import 'package:flutter/material.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../country_code_widget/code_countries_en.dart';
import '../country_code_widget/code_country.dart';

class RegisterWidget{

  static List<CountryCode> allCountriesList = countriesEnglish.map((s) { 
    return CountryCode(
      name: s['name'],
      code: s['code'],
      dialCode: s['dial_code'],
      flagUri: '${AppAssets.flags}${s['code'].toLowerCase()}.png',
    );
  }).toList();


  static showCountryDialog() async {
    List<CountryCode> searchList = countriesEnglish.map((s) { 
      return CountryCode(
        name: s['name'],
        code: s['code'],
        dialCode: s['dial_code'],
        flagUri: '${AppAssets.flags}${s['code'].toLowerCase()}.png',
      );
    }).toList();

    TextEditingController searchController = TextEditingController();
    FocusNode searchNode = FocusNode();
    
    return await showDialog(
      context: navigatorKey.currentContext!, 
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: padding(horizontal: 25),
          child: directionality(
            child: Container(
              width: getSize().width,
              padding: padding(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius(radius: 25)
              ),
              child: StatefulBuilder(
                builder: (context,state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
            
                      space(19),
            
                      Text(
                        appText.selectCountry,
                        style: style16Bold(),
                      ),
          
                      space(16),
          
                      Center(
                        child: input(searchController, searchNode, appText.selectCountryDesc, iconPathLeft: AppAssets.searchSvg, isBorder: true, radius: 15,onChange: (text) {
                                
                          if(text.trim().isEmpty){
                            searchList = countriesEnglish.map((s) { 
                              return CountryCode(
                                name: s['name'],
                                code: s['code'],
                                dialCode: s['dial_code'],
                                flagUri: '${AppAssets.flags}${s['code'].toLowerCase()}.png',
                              );
                            }).toList();
                          }else{
                            searchList = [];
                            allCountriesList.forEach((element) {
                              if(element.name?.toLowerCase().contains(text.trim().toLowerCase()) ?? false){
                                searchList.add(element);
                              }
                            });
                          }
                                
                          state((){});
                                
                        },),
                      ),
          
                      space(12),
          
                      // country list
                      SizedBox(
                        width: getSize().width,
                        height: 190,
                        child: ListView.builder(
                          itemCount: searchList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                navigatorKey.currentState!.pop(searchList[index]);
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                padding: padding(horizontal: 12),
                                margin: const EdgeInsets.only(bottom: 24),
                                width: getSize().height,
          
                                child: Row(
                                  children: [
          
                                    ClipRRect(
                                      borderRadius: borderRadius(radius: 50),
                                      child: Image.asset(
                                        searchList[index].flagUri ?? '',
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
          
                                    space(0,width: 14),
          
                                    Expanded(
                                      child: Text(
                                        '${searchList[index].name ?? ''} (${searchList[index].dialCode ?? ''})',
                                        style: style14Regular(),
                                      ),
                                    )
          
          
                                  ],
                                ),
                              ),
                            );
          
                          },
                        ),
                      ),
          
                      space(12),
          
                      button(
                        onTap: (){
                          backRoute();
                        }, 
                        width: getSize().width, 
                        height: 52, 
                        text: appText.cancel, 
                        bgColor: green77(), 
                        textColor: Colors.white, 
                        borderColor: green77()
                      ),
          
                      space(11),
          
                    ],
                  );
                }
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget codeInput(TextEditingController controller, FocusNode focusNode,FocusNode? nextNode,FocusNode? previusNode,Function(String onPastedCode) onPastedCode){
    return Container(
      width: 52,
      height: 75,
      // padding: const EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius(radius: 16),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black.withOpacity(.03),
            offset: const Offset(0, 10),
          )
        ]
      ),

      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          
          if(value.trim().length == 1){
            if(nextNode == null){
              focusNode.unfocus();
            }
            nextNode?.requestFocus();
          }else if(value.trim().isEmpty){
            previusNode?.requestFocus();
          }else if(value.length == 5){
            onPastedCode(value.trim());
          }
          
        },
        cursorHeight: 22,
        style: style24Bold().copyWith(height: 1),

        textAlign: TextAlign.center,

        decoration: const InputDecoration(
          border: InputBorder.none
        ),
      ),
    );
  }

}