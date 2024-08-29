
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:webinar/app/models/checkout_model.dart';
import 'package:webinar/app/pages/main_page/main_page.dart';
import 'package:webinar/app/services/user_service/cart_service.dart';
import 'package:webinar/app/widgets/main_widget/home_widget/cart_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/enums/error_enum.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/constants.dart';
import 'package:webinar/common/utils/currency_utils.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../single_course_page/single_content_page/web_view_page.dart';

class CheckoutPage extends StatefulWidget {
  static const String pageName = '/checkout';
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  CheckoutModel? checkoutData;
  PaymentChannels? selectedPaymentChannels;

  bool isLoading = true;
  bool isCharge = false;

  bool isLoadingStartPay = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      
      isCharge = ((ModalRoute.of(context)!.settings.arguments ?? false) as bool);

      if(!isCharge){
        getData();
      }
      
    });
  }


  getData() async {

    setState(() {
      isLoading = true;
    });

    checkoutData = await CartService.checkout();

    checkoutData?.paymentChannels?.add(
      PaymentChannels(id: -2, image: AppAssets.accountChargeSvg, type: 'charge', title: appText.accountCharge)
    );
    
    // checkoutData?.paymentChannels?.add(
    //   PaymentChannels(id: -1, image: AppAssets.offlinePaymentSvg, type: 'offline', title: appText.offlinePayment)
    // );

    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return directionality(
      child: Scaffold(
        appBar: appbar(title: appText.paymentMethod),

        body: isLoading 
      ? loading()
      : Stack(
          children: [
            
            Positioned.fill(
              child: Column(
                children: [

                  space(8),

                  // payment channels
                  SizedBox(
                    width: getSize().width,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: padding(),
                      itemCount: checkoutData?.paymentChannels?.length ?? 0,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 20, mainAxisSpacing: 20), 
                      itemBuilder: (context, index) {
                        
                        return GestureDetector(
                          onTap: (){
                            selectedPaymentChannels = checkoutData?.paymentChannels?[index];
                            
                            setState(() {});
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                        
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: borderRadius(),
                              border: Border.all(
                                color: (checkoutData?.paymentChannels?[index].id == selectedPaymentChannels?.id) ? green77() : Colors.white,
                                width: 2
                              )
                            ),
                        
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                if(checkoutData?.paymentChannels?[index].type == 'charge')...{
                                  space(20),
                                },

                                if(checkoutData?.paymentChannels?[index].type == 'online')...{
                                  
                                  Image.network(
                                    '${Constants.dommain}${checkoutData?.paymentChannels?[index].image}',
                                    height: 50,
                                  ),
                                }else ...{
                                  
                                  SvgPicture.asset(
                                    checkoutData?.paymentChannels?[index].image ?? '',
                                    height: 50,
                                  ),

                                },
                        
                                space(10),
                        
                                Text(
                                  checkoutData?.paymentChannels?[index].title ?? '',
                                  style: style14Regular(),
                                ),

                                if(checkoutData?.paymentChannels?[index].type == 'charge')...{

                                  space(8),
                          
                                  Container(
                                    padding: padding(horizontal: 5, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: greyE7,
                                      borderRadius: borderRadius()
                                    ),

                                    child: Text(
                                      CurrencyUtils.calculator(
                                        checkoutData?.userCharge ?? '',
                                        // fractionDigits: 2
                                      ).seRagham(),
                                      style: style10Regular().copyWith(color: greyB2),
                                    ),
                                  )

                                }
                        
                        
                              ],
                            ),
                          ),
                        );

                      },
                    ),
                  )

                ],
              ),
            ),


            // start payment
            if(!isCharge)...{
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                bottom: selectedPaymentChannels != null ? 0 : -150,
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
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Text(
                            appText.total,
                            style: style16Regular(),
                          ),
                          
                          
                          Text(
                            CurrencyUtils.calculator(checkoutData?.amounts?.total ?? 0),
                            style: style14Regular().copyWith(color: greyA5),
                          ),

                        ],
                      ),
                      
                      space(20),

                      Center(
                        child: button(
                          onTap: () async {

                            if(selectedPaymentChannels?.type == 'charge'){  // pay with account charge
                              
                              setState(() {
                                isLoadingStartPay = true;
                              });

                              bool res = await CartService.credit(checkoutData!.order!.id!);
                              CartService.getCart();

                              if(res){
                                nextRoute(MainPage.pageName,isClearBackRoutes: true);
                                showSnackBar(ErrorEnum.success, appText.successfulPaymentDesc);
                              }

                              setState(() {
                                isLoadingStartPay = false;
                              });

                            }else if(selectedPaymentChannels?.type == 'offline'){  // offline payment

                              CartWidget.showOfflinePaySheet(checkoutData!.order!.id!);

                            }else if(selectedPaymentChannels?.type == 'online'){  // online payment
                              
                              setState(() {
                                isLoadingStartPay = true;
                              });


                              nextRoute(
                                WebViewPage.pageName, 
                                arguments: [
                                  '${Constants.baseUrl}panel/payments/request?gateway_id=${selectedPaymentChannels!.id!}&order_id=${checkoutData!.order!.id!}', 
                                  selectedPaymentChannels?.title ?? '',
                                ]
                              );

                              setState(() {
                                isLoadingStartPay = false;
                              });

                            }
                            
                          },
                          width: getSize().width, 
                          height: 52, 
                          text: appText.startPayment, 
                          bgColor: green77(), 
                          textColor: Colors.white,
                          isLoading: isLoadingStartPay
                        ),
                      ),
                    ],
                  )
                )
              ),

            }

          ],
        )
      )
    );
  }
}