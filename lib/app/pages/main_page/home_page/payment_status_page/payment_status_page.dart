import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

class PaymentStatusPage extends StatefulWidget {
  static const String pageName = '/payment-status';
  const PaymentStatusPage({super.key});

  @override
  State<PaymentStatusPage> createState() => _PaymentStatusPageState();
}

class _PaymentStatusPageState extends State<PaymentStatusPage> {
  
  String status = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      status = (ModalRoute.of(context)!.settings.arguments as String);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        body: Container(
          width: getSize().width,
          height: getSize().height,

          decoration: BoxDecoration(
            image: const DecorationImage(
              alignment: Alignment.bottomCenter,
              image: AssetImage(AppAssets.payBgPng),
            ),
            gradient: status == ''
              ? null
              : status == 'success'
                ? LinearGradient(
                    colors: [
                      const Color(0xff7BFFAA),
                      green77()
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )

                : LinearGradient(
                    colors: [
                      const Color(0xffFC8A8A),
                      red49
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
          ),

          child: status == ''
        ? const SizedBox.shrink()
        : Column(
            children: [

              const Spacer(flex: 1),
              
              SvgPicture.asset(status == 'success' ? AppAssets.successPaySvg : AppAssets.failedPaySvg),

              const Spacer(flex: 2),

              Text(
                status == 'success' ? appText.successfulPayment : appText.paymentFailed,
                style: style16Bold().copyWith(color: Colors.white),
              ),

              space(14),

              Text(
                status == 'success' ? appText.successfulPaymentDesc : appText.paymentFailedDesc,
                style: style14Regular().copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),

              space(32),

              button(
                onTap: (){
                  backRoute();
                }, 
                width: 155, 
                height: 52, 
                text: appText.back, 
                bgColor: Colors.white, 
                textColor: status == 'success' ? green77() : red49,
                raduis: 15
              ),

              const Spacer(flex: 1),



            ],
          ),

        ),
      )
    );
  }
}