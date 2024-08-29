import 'package:flutter/material.dart';
import 'package:webinar/app/models/banks_model.dart';
import 'package:webinar/app/pages/main_page/home_page/cart_page/bank_accounts_page.dart';
import 'package:webinar/app/pages/main_page/main_page.dart';
import 'package:webinar/app/services/user_service/cart_service.dart';
import 'package:webinar/app/services/user_service/financial_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/utils.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../../common/utils/date_formater.dart';

class CartWidget{

  static showCouponSheet() async {
    bool isLoading = false;
    TextEditingController couponController = TextEditingController();
    FocusNode couponNode = FocusNode();

    return await baseBottomSheet(
      child: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: padding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                space(20),
          
                Text(
                  appText.addCoupon,
                  style: style16Bold(),
                ),
          
                space(18),
          
                input(couponController, couponNode, '200', isBorder: true,iconPathLeft: AppAssets.ticketSvg),
          
                space(18),
          
                Center(
                  child: button(
                    onTap: () async {
                      if(couponController.text.trim().isNotEmpty){
                        
                        setState((){
                          isLoading = true;
                        });
                        
                        var res = await CartService.validateCoupon(couponController.text.trim());
                
                        if(res != null){
                          backRoute(arguments: res);
                        }
                        
                        setState((){
                          isLoading = false;
                        });
                
                      }
                    }, 
                    width: getSize().width, 
                    height: 52, 
                    text: appText.validate, 
                    bgColor: green77(), 
                    textColor: Colors.white,
                    isLoading: isLoading
                  ),
                ),
          
                space(28)
          
              ],
            ),
          );
        },
      )
    );
  }

  static showOfflinePaySheet(int orderId) async {
    bool isLoading = false;
    bool isOpenBankBox = false;


    TextEditingController amountController = TextEditingController();
    FocusNode amountNode = FocusNode();
    
    TextEditingController referenceController = TextEditingController();
    FocusNode referenceNode = FocusNode();
    
    TextEditingController dateController = TextEditingController();
    FocusNode dateNode = FocusNode();
    DateTime? date;

    BanksModel? selectedBank;

    

    return await baseBottomSheet(
      child: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: padding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                space(20),
          
                Text(
                  appText.offlinePaymentDetails,
                  style: style16Bold(),
                ),
          
                space(18),
          
                input(amountController, amountNode, appText.amount, isBorder: true, iconPathLeft: AppAssets.profileSvg, isNumber: true),
          
                space(16),

                FutureBuilder(
                  future: FinancialService.getBankAccounts(),
                  builder: (context, data) {
                    
                    return dropDown(
                      appText.selectBank, 
                      selectedBank != null ? checkTitleWithLanguage(selectedBank!.translations!) : '', 
                      data.data != null 
                        ? List.generate(data.data?.length ?? 0, (index) => checkTitleWithLanguage(data.data?[index].translations ?? []))
                        : [], 
                      (){
                        isOpenBankBox = !isOpenBankBox;
                        setState((){});
                      }, 
                      (newValue, index) {
                        selectedBank = data.data?[index];
                        setState((){});
                      }, 
                      isOpenBankBox,
                      icon: AppAssets.profileSvg,
                    );

                  }
                ),

                space(16),
          
                input(referenceController, referenceNode, appText.reference, isBorder: true,iconPathLeft: AppAssets.profileSvg),
          
                space(16),
                
                input(
                  dateController, dateNode, (date == null) ? appText.date : timeStampToDateHour(date!.millisecondsSinceEpoch, isUtc: false), isBorder: true, iconPathLeft: AppAssets.ticketSvg,
                  onTap: (){
                    showDatePicker(
                      context: context, 
                      initialDate: DateTime.now(), 
                      firstDate: DateTime(2023), 
                      lastDate: DateTime(2030)
                    ).then((value) {
                      
                      if(value != null){

                        date = value.toLocal();
                        
                        showTimePicker(
                          context: context, 
                          initialTime: TimeOfDay.now(), 
                        ).then((time) {
                          date = DateTime(
                            date!.year,
                            date!.month,
                            date!.day,
                            time!.hour,
                            time.minute,
                          ).toLocal();

                          setState((){});
                        });

                        setState((){});
                      }

                    });
                  },
                  isReadOnly: true,
                ),
          
                space(16),

                Center(
                  child: Row(
                    children: [
                    
                      Expanded(
                        child:  button(
                          onTap: () async {

                            if(selectedBank==null || date==null){
                              return;
                            }

                            isLoading = true;
                            setState((){});
                            
                            bool res = await FinancialService.store(
                              int.tryParse(amountController.text) ?? 0, 
                              checkTitleWithLanguage(selectedBank!.translations!), 
                              referenceController.text.trim(), 
                              date!.millisecondsSinceEpoch,
                              orderId
                            );

                            if(res){
                              nextRoute(MainPage.pageName, isClearBackRoutes: true);
                            }
                            
                            isLoading = false;
                            setState((){});
                          }, 
                          width: getSize().width, 
                          height: 52, 
                          text: appText.submit, 
                          bgColor: green77(), 
                          textColor: Colors.white,
                          isLoading: isLoading,
                          raduis: 15
                        ),
                      ),

                      space(0,width: 20),

                      Expanded(
                        child: button(
                          onTap: () async {
                            nextRoute(BankAccountsPage.pageName);
                          }, 
                          width: getSize().width, 
                          height: 52, 
                          text: appText.banksInfo, 
                          bgColor: Colors.white, 
                          textColor: green77(),
                          borderColor: green77(),
                          raduis: 15
                        ),
                      )

                    ],
                  )
                ),
          
                space(28)
          
              ],
            ),
          );
        },
      )
    );
  }

}