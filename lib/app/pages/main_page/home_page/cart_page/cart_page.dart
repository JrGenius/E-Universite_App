import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/pages/main_page/home_page/cart_page/checkout_page.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/user_service/cart_service.dart';
import 'package:webinar/app/widgets/main_widget/home_widget/cart_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/currency_utils.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';
import 'package:webinar/locator.dart';

class CartPage extends StatefulWidget {
  static const String pageName = '/cart';
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  bool isLoading = false;

  int? discountId;


  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {

    setState(() {
      isLoading = true;
    });

    await CartService.getCart();

    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
 

    return directionality(
      child: Consumer<UserProvider>(
        builder: (context, userProvdider, _) {
          
          return Scaffold(
            
            appBar: appbar(
              title: (userProvdider.cartData?.items?.length ?? 0) > 0 
                ? '${appText.cart} (${userProvdider.cartData?.items?.length})' 
                : appText.cart,
            ),

            body: isLoading
          ? loading()
          : Stack(
              children: [

                // items
                (userProvdider.cartData?.items?.isEmpty ?? true)
              ? Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: getSize().height * .2),
                  child: emptyState(AppAssets.emptyCardSvg, appText.cartIsEmpty, appText.cartIsEmptyDesc)
                )
              : Positioned.fill(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    
                    child: Column(
                      children: [

                        space(5),

                        ...List.generate(userProvdider.cartData?.items?.length ?? 0, (index) {

    
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: red49,
                                  borderRadius: borderRadius()
                                ),
                                margin: padding(),
                                
                                child: Slidable(
                                  key: ValueKey(index),
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    extentRatio: .3,
                                                          
                                    children:  [

                                      GestureDetector(
                                        onTap: (){

                                          setState(() {
                                            isLoading = true;
                                          });

                                          CartService.deleteCourse(userProvdider.cartData!.items![index].id!).then((value) async {

                                            userProvdider.cartData!.items!.removeAt(index);

                                            await Future.delayed(const Duration(seconds: 1));

                                            setState(() {
                                              isLoading = false;
                                            });

                                            if(value){
                                              getData();
                                            }
                                            
                                          });

                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: SizedBox(
                                          width: 90,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                                                  
                                              SvgPicture.asset(AppAssets.deleteSvg),
                                                                  
                                              space(4),
                                                                  
                                              Text(
                                                appText.remove,
                                                style: style10Regular().copyWith(color: Colors.white),
                                              ),
                                                                  
                                            ],
                                          ),
                                        ),
                                      )
                                      
                                    ],
                                  ),
                              
                              
                                  child: directionality(
                                    child: courseItemVertically(
                                      CourseModel(
                                        id: userProvdider.cartData?.items?[index].id,
                                        image: userProvdider.cartData?.items?[index].image,
                                        price: userProvdider.cartData?.items?[index].price,
                                        discountPercent: (userProvdider.cartData?.items?[index].discount) != null 
                                            ? ((((userProvdider.cartData?.items?[index].price ?? 1) - (userProvdider.cartData?.items?[index].discount ?? 1)) / 100 ) * 100).toInt()
                                            : 0,
                                        rate: userProvdider.cartData?.items?[index].rate,
                                        title: userProvdider.cartData?.items?[index].title,

                                        reservedMeeting: userProvdider.cartData?.items?[index].type == 'meeting'
                                          ? '${userProvdider.cartData?.items?[index].day ?? ''} ${userProvdider.cartData?.items?[index].time?.start ?? ''}-${userProvdider.cartData?.items?[index].time?.end ?? ''} ${userProvdider.cartData?.items?[index].timezone ?? ''}'
                                          : null,
                                        reservedMeetingUserTimeZone: userProvdider.cartData?.items?[index].type == 'meeting'
                                          ? '${userProvdider.cartData?.items?[index].day ?? ''} ${userProvdider.cartData?.items?[index].timeUser?.start ?? ''}-${userProvdider.cartData?.items?[index].timeUser?.end ?? ''} ${locator<UserProvider>().profile?.timezone ?? ''}'
                                          : null,
                                      
                                      ),

                                      bottomMargin: 0,
                                      ignoreTap: true,
                                      height: userProvdider.cartData?.items?[index].type == 'meeting' ? 110 : 83,
                                      imageHeight: userProvdider.cartData?.items?[index].type == 'meeting' ? 110 : 83

                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),

                        // space(20),

                        if(userProvdider.cartData?.userGroup != null)...{
                          helperBox(AppAssets.discountSvg, '${userProvdider.cartData?.userGroup?.discount}% ${appText.userGroupDiscount}', '${userProvdider.cartData?.userGroup?.name}'),

                          space(16),
                        },

                        if(userProvdider.cartData?.totalCashbackAmount != null)...{
                          helperBox(
                            AppAssets.walletSvg,
                            appText.getCashback,
                            '${appText.finalizeYourOrderAndGet} '
                            // '${CurrencyUtils.calculator(userProvdider.cartData?.totalCashbackAmount ?? 0, fractionDigits: 1)} ${appText.cashback}'
                            '${CurrencyUtils.calculator(userProvdider.cartData?.totalCashbackAmount ?? 0)} ${appText.cashback}'
                          ),

                          space(16),
                        },

                        space(300),
                      ],
                    ),
                  )
                ),


                // amount
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: getSize().width,
                    padding: padding(vertical: 21),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                      boxShadow: [
                        boxShadow(Colors.black.withOpacity(.1), y: -3, blur: 15)
                      ]
                    ),

                    child: Column(
                      children: [

                        // sub total
                        cartItem(
                          appText.subtotal, 
                          CurrencyUtils.calculator(userProvdider.cartData?.amounts?.subTotal ?? 0)
                        ),
                        
                        // Discount
                        cartItem(
                          appText.discount, 
                          CurrencyUtils.calculator(userProvdider.cartData?.amounts?.totalDiscount ?? 0)
                        ),
                        
                        // Tax
                        cartItem(
                          '${appText.tax} (${userProvdider.cartData?.amounts?.tax ?? 0}%)', 
                          CurrencyUtils.calculator(userProvdider.cartData?.amounts?.taxPrice ?? 0)
                        ),

                        // Total
                        cartItem(
                          appText.total, 
                          CurrencyUtils.calculator(userProvdider.cartData?.amounts?.total ?? 0)
                        ),

                        space(6),

                        Row(
                          children: [

                            Expanded(
                              child: button(
                                onTap: (){
                                  nextRoute(CheckoutPage.pageName);
                                }, 
                                width: getSize().width, 
                                height: 52, 
                                text: appText.checkout, 
                                bgColor: green77(), 
                                textColor: Colors.white
                              )
                            ),

                            space(0, width: 20),
                            
                            Expanded(
                              child: button(
                                onTap: () async {
                                  var res = await CartWidget.showCouponSheet();

                                  if(res != null){
                                    userProvdider.cartData?.amounts = res['amount'];
                                    discountId = res['discount_id'];
                                    
                                    setState(() {});
                                  }

                                }, 
                                width: getSize().width, 
                                height: 52, 
                                text: appText.addCoupon, 
                                bgColor: Colors.white, 
                                textColor: green77(),
                                borderColor: green77()
                              )
                            ),
                          ],
                        ),

                        space(8),
                        
                      ],
                    ),
                  )
                )

              ],
            ),
          );
        }
      ),
    );
  }




  Widget cartItem(String title, String price){
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
    
          Text(
            title,
            style: style16Regular(),  
          ),
          
          
          Text(
            price,
            style: style16Regular().copyWith(color: greyB2),  
          ),
    
        ],
      ),
    );
  }

}