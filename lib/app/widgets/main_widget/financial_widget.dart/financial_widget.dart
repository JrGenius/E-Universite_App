import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/payout_model.dart';
import 'package:webinar/app/models/sales_model.dart';
import 'package:webinar/app/models/summary_model.dart';
import 'package:webinar/app/services/user_service/financial_service.dart';
import 'package:webinar/common/badges.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/currency_utils.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../models/offline_payment_model.dart';

class FinancialWidget{

  
  static Widget summaryPage(SummaryModel? summary, Function getData, bool isLoadingCharge, Function onTapCharge){
    
    return summary == null
  ? const SizedBox()
  : SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.hardEdge,

      child: Column(
        children: [

          space(20),

          financialCard(
            CurrencyUtils.calculator(
              summary.balance ?? 0, 
              // fractionDigits: int.tryParse(PublicData.apiConfigData['currency_decimal'].toString()) ?? 0
            ), 
            appText.accountBalance, 
            appText.charge, 
            () async { // charge
            
              onTapCharge();

            }, 
            AppAssets.walletSvg, 
            green77(),
            isLoading: isLoadingCharge
          ),

          space(35),


          Padding(
            padding: padding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                  appText.balancesHistory,
                  style: style16Bold(),
                ),

                space(16),

                (summary.history?.isEmpty ?? true)
              ? Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: emptyState(AppAssets.noBalanceEmptyStateSvg, appText.noBalance, appText.noBadgesDesc)
                )
              : Column(
                  children: List.generate(summary.history?.length ??0, (index) {
                    return historyItem(
                      summary.history?[index].description ?? '', 
                      timeStampToDateHour((summary.history?[index].createdAt ?? 0) * 1000), 
                      CurrencyUtils.calculator(summary.history?[index].amount), 
                      summary.history?[index].balanceType == 'addition' // addition | deduction
                    );
                  }),
                )
              ],
            ),
          )


        ],
      ),
    );
    
  }

  static Widget offlinePaymentPage(List<OfflinePaymentModel> offlinePayments){
    return (offlinePayments.isEmpty)
  ? Center(child: emptyState(AppAssets.offlinePaymentEmptyStateSvg, appText.noOfflinePayments, appText.noOfflinePaymentsDesc))
  : Padding(
      padding: padding(),
      child: SingleChildScrollView(
        child: Column(
          children: [
          
            space(12),
          
            ...List.generate(offlinePayments.length, (index) {
              return offlinePaymentItem(offlinePayments[index]);
            }),
            
            space(12),
          ],
        ),
      ),
    );
  }
  
  static Widget payoutPage(PayoutModel? payout, Function getData){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [

          space(20),

          financialCard(
            CurrencyUtils.calculator(
              payout?.currentPayout?.amount ?? 0, 
              // fractionDigits: int.tryParse(PublicData.apiConfigData['currency_decimal'].toString()) ?? 0
            ),
            appText.readyToPayout, 
            (payout?.currentPayout?.amount ?? 0) == 0.0 ? '' : appText.requestPayout, 
            () async { // request
              bool? res = await payoutRequestSheet(payout!.currentPayout!);

              if(res != null && res){
                getData();
              }
            }, 
            AppAssets.walletSvg, 
            blue64()
          ),

          space(35),


          Padding(
            padding: padding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                  appText.payoutHistory,
                  style: style16Bold(),
                ),
                
                
                (payout?.payouts?.isEmpty ?? true)
              ? Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 60),
                  child: emptyState(AppAssets.noBalanceEmptyStateSvg, appText.noPayout, appText.noPayoutDesc)
                )
              : Column(
                  children: [

                    space(12),

                    ...List.generate(payout?.payouts?.length ?? 0, (index) {
                      return payoutItem(
                        payout?.payouts?[index].accountBankName?.getTitle() ?? '', 
                        timeStampToDateHour((payout?.payouts?[index].createdAt ?? 0) * 1000), 
                        CurrencyUtils.calculator(double.parse(payout?.payouts?[index].amount?.toString() ?? '0.0')), 
                        payout?.payouts?[index].status ?? '', 
                      );
                    })
                  ],
                ),


              ]
            )
          ),


        ],
      ),
    );
  }

  static Widget salesPage(SaleModel? data){
    
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: padding(vertical: 20),
      
      child: Column(
        children: [

          // 3 item
          Container(
            width: getSize().width,
            padding: padding(horizontal: 4,vertical: 18),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: borderRadius(),
              border: Border.all(color: greyE7)
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                // pending
                Column(
                  children: [

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: green50.withOpacity(.3),
                        shape: BoxShape.circle
                      ),
                      alignment: Alignment.center,

                      child: SvgPicture.asset(AppAssets.videoSvg, colorFilter:  ColorFilter.mode(green50, BlendMode.srcIn), width: 20,),
                    ),

                    space(8),

                    Text(
                      data?.webinarsCount?.toString() ?? '0',
                      style: style14Bold(),
                    ),

                    space(4),

                    Text(
                      appText.classSales,
                      style: style12Regular().copyWith(color: greyB2),
                    ),
                    
                    space(4),
                    
                    Text(
                      CurrencyUtils.calculator(double.tryParse(data?.classSales?.toString() ?? '0') ?? 0),
                      style: style12Regular().copyWith(color: green50),
                    ),

                  ],
                ),

                // Passed
                Column(
                  children: [

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: blueFE.withOpacity(.3),
                        shape: BoxShape.circle
                      ),
                      alignment: Alignment.center,

                      child: SvgPicture.asset(AppAssets.provideresSvg, colorFilter:  ColorFilter.mode(blueFE, BlendMode.srcIn), width: 20,),
                    ),

                    space(8),

                    Text(
                      data?.meetingsCount?.toString() ?? '0',
                      style: style14Bold(),
                    ),

                    space(4),

                    Text(
                      appText.meetingSales,
                      style: style12Regular().copyWith(color: greyB2),
                    ),

                    space(4),
                    
                    Text(
                      CurrencyUtils.calculator(double.tryParse(data?.meetingSales?.toString() ?? '0') ?? 0),
                      style: style12Regular().copyWith(color: blueFE),
                    ),

                  ],
                ),

                // Total Sales
                Column(
                  children: [

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: yellow4C.withOpacity(.3),
                        shape: BoxShape.circle
                      ),
                      alignment: Alignment.center,

                      child: SvgPicture.asset(AppAssets.walletSvg, colorFilter:  ColorFilter.mode(yellow4C.withOpacity(.6), BlendMode.srcIn), width: 20,),
                    ),

                    space(8),

                    Text(
                      ((data?.meetingsCount ?? 0) + (data?.webinarsCount ?? 0)).toString(),
                      style: style14Bold(),
                    ),

                    space(4),

                    Text(
                      appText.totalSales,
                      style: style12Regular().copyWith(color: greyB2),
                    ),

                    space(4),
                    
                    Text(
                      CurrencyUtils.calculator(double.tryParse(data?.totalSales?.toString() ?? '0') ?? 0),
                      style: style12Regular().copyWith(color: yellow4C),
                    ),

                  ],
                ),

              ],
            ),
          ),
          
          space(16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              space(0,width: getSize().width),
              
              Text(
                appText.salesHistory,
                style: style16Bold(),
              ),

              space(16),

              (data?.sales?.isEmpty ?? true)
            ? Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 60),
                child: emptyState(AppAssets.salesEmptyStateSvg, appText.noSales, appText.noSalesDesc)
              )
            : Column(
                children: [

                  ...List.generate(data?.sales?.length ?? 0, (index) {
                    return userCard(
                      data!.sales![index].buyer?.avatar ?? '', 
                      data.sales![index].buyer?.fullName ?? '', 
                      data.sales![index].webinar?.title ?? '', 
                      timeStampToDateHour((data.sales![index].createdAt ?? 0) * 1000), 
                      CurrencyUtils.calculator(double.tryParse(data.sales![index].amount ?? '0') ?? 0), 
                      data.sales![index].type ?? '', 
                      (){

                      }
                    );
                  }),

                  space(12),
                ],
              )
            ],
          ),


        ],
      ),

    );
  }

  



  static Widget financialCard(String amount, String subtitle, String buttonText, Function onTapButton, String icon, Color iconBgColor, {bool isBg=false, Function? onTapBox, bool isLoading=false}){
    return GestureDetector(
      onTap: (){
        onTapBox!();
      },
      child: Container(
        padding: padding(),
        
        width: getSize().width,
        height: 180,
        decoration: const BoxDecoration(),
        child: Stack(
        clipBehavior: Clip.none,
          
          children: [
    
            if(isBg)...{
              // bg
              Positioned(
                bottom: 0,
                right: 12,
                left: 12,
                child: Container(
                  width: getSize().width,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius()
                  ),
                )
              ),
    
            },
            
            Positioned(
              right: 0,
              left: 0,
              bottom: isBg ? 10 : 0,
              top: 0,
              child: Container(
                width: getSize().width,
                height: 180,
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius(radius: 20),
                  boxShadow: [boxShadow(Colors.black.withOpacity(.03), blur: 15 ,y: 3)]
                ),
                clipBehavior: Clip.hardEdge,
                
                padding: const EdgeInsetsDirectional.only(
                  start: 16,
                ),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                
                        
                        Text(
                          amount,
                          style: style24Bold(),
                        ),
                
                        space(2),
                
                        Text(
                          subtitle,
                          style: style16Regular().copyWith(color: greyB2),
                        ),
                
                        if(buttonText.isNotEmpty)...{
    
                          space(16),
                  
                          button(
                            onTap: (){
                              onTapButton();
                            },
                            width: 90, 
                            height: 45, 
                            text: buttonText, 
                            bgColor: Colors.white, 
                            textColor: green77(),
                            borderColor: green77(),
                            raduis: 15,
                            horizontalPadding: 18,
                            isLoading: isLoading,
                            loadingColor: green77()
                          ),
                  
                        },
    
                      ],
                    ),
                
                    
                
                  ],
                ),
                
              ),
            ),
    
            PositionedDirectional(
              end: -20,
              bottom: 0,
              top: 0,
              child: Center(
                child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 10),
                  width: 80,
                  height: 80,
                        
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: borderRadius(radius: 20)
                  ),
                  alignment: Alignment.center,
    
                  child: SvgPicture.asset(icon),
                ),
              )
            ),
    
            
          ],
        ),
      ),
    );
  }


  static Widget historyItem(String title, String date, String amount, bool isUp){
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: getSize().width,
      height: 100,
      padding: padding(horizontal: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius(),
      ),

      child: Row(
        children: [

          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: isUp ? green77() : red49,
              borderRadius: borderRadius(radius: 10) 
            ),

            child: Icon(
              isUp ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),

          space(0, width: 10),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: style14Bold(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                space(8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Text(
                      date,
                      style: style12Regular().copyWith(color: greyA5),
                    ),


                    Text(
                      '${isUp ? '+' : '-'}$amount',
                      style: style16Bold().copyWith(color: isUp ? green77() : red49),
                    )
                    
                  ],
                )
              ],
            )
          ),



        ],
      ),
    );
  } 

  static Widget offlinePaymentItem(OfflinePaymentModel data){
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: getSize().width,
        height: 100,
        padding: padding(horizontal: 14,vertical: 14),
        margin: const EdgeInsets.only(bottom: 16),
        
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius()
        ),

        child: Row(
          children: [
          
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: data.status == 'approved' 
                  ? green77() 
                  : data.status == 'waiting'
                    ? yellow29
                    : red49,
                borderRadius: borderRadius(radius: 10) 
              ),
              alignment: Alignment.center,

              child: SvgPicture.asset(AppAssets.walletSvg, width: 20),
            ),

            space(0, width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '',
                        style: style14Regular(),
                      ),

                      if(data.status == 'waiting' )...{
                        Badges.pending(),
                      }else if(data.status == 'rejected' )...{
                        Badges.rejected(),
                      }
                    ],
                  ),

                  space(2),
                  
                  Text(
                    '${appText.ref}: ${data.referenceNumber}',
                    style: style10Regular().copyWith(color: greyA5),
                    maxLines: 1,
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // date
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.calendarSvg),
                          
                          space(0,width: 4),

                          Text(
                            timeStampToDateHour((int.parse(data.payDate ?? '0')) * 1000),
                            style:style10Regular().copyWith(color: greyA5), 
                          )
                        ],
                      ),


                      Text(
                        CurrencyUtils.calculator(data.amount),
                        style: style16Regular().copyWith(color: green77()), 
                      )
                    ],
                  )

            
                ],
              ),
            )
          ],
        ),

      ),
    );

  } 

  static Widget payoutItem(String title, String date, String amount, String status){
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: getSize().width,
      height: 100,
      padding: padding(horizontal: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius(),
      ),

      child: Row(
        children: [

          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: status == 'done' 
                ? green77() 
                : status == 'waiting'
                  ? yellow29
                  : red49,
              borderRadius: borderRadius(radius: 10) 
            ),
            alignment: Alignment.center,

            child: SvgPicture.asset(AppAssets.walletSvg, width: 20),
          ),

          space(0, width: 10),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      title,
                      style: style14Bold(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),


                    status == 'done' 
                    ? const SizedBox()
                    : status == 'waiting'
                      ? Badges.pending()
                      : Badges.rejected(),

                  ],
                ),

                space(8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Text(
                      date,
                      style: style12Regular().copyWith(color: greyA5),
                    ),


                    Text(
                      amount,
                      style: style16Bold().copyWith(color: green77()),
                    )
                    
                  ],
                )
              ],
            )
          ),



        ],
      ),
    );
  } 




  static payoutRequestSheet(CurrentPayout data) async {
    bool isLoading = false;
    
    return await baseBottomSheet(
      child: Padding(
        padding: padding(),
        child: StatefulBuilder(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
      
                space(16),
                
                Text(
                  appText.requestPayout,
                  style: style16Bold(),
                ),
      
                space(6),
                
                Text(
                  appText.requestPayoutDesc,
                  style: style12Regular().copyWith(color: greyA5),
                ),
      
                space(32),
      
                Center(
                  child: Column(
                    children: [
                      
                      Image.asset(AppAssets.paypalPng),
                      
                      space(4),
                      
                      Text(
                        'Paypal',
                        style: style16Bold(),
                      ),
                    ],
                  ),
                ),

                space(30),

                // amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      appText.amount,
                      style: style14Bold(),
                    ),
                    
                    Text(
                      CurrencyUtils.calculator(data.amount),
                      style: style14Regular().copyWith(color: greyB2),
                    ),
                  ],
                ),

                space(18),

                // card id
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      appText.cardID,
                      style: style14Bold(),
                    ),
                    
                    Text(
                      data.accountId?.toString() ?? '-',
                      style: style14Regular().copyWith(color: greyB2),
                    ),
                  ],
                ),

                space(18),

                // card id
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      appText.iban,
                      style: style14Bold(),
                    ),
                    
                    Text(
                      data.iban?.toString() ?? '-',
                      style: style14Regular().copyWith(color: greyB2),
                    ),
                  ],
                ),

                space(18),

                Center(
                  child: button(
                    onTap: () async {
                      isLoading = true;
                      state((){});
                      
                      bool res = await FinancialService.requestPayout(data.amount);
                      
                      isLoading = false;
                      state((){});

                      if(res){
                        backRoute(arguments: true);
                      }
                    }, 
                    width: getSize().width, 
                    height: 52, 
                    text: appText.send, 
                    bgColor: green77(), 
                    textColor: Colors.white,
                    isLoading: isLoading
                  ),
                ),

                space(40),
      
              ],
            );
          }
        ),
      )
    );
  }

}