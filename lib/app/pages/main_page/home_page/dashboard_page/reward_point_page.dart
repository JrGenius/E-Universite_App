import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/reward_point_model.dart';
import 'package:webinar/app/services/user_service/user_service.dart';
import 'package:webinar/app/widgets/main_widget/financial_widget.dart/financial_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

class RewardPointPage extends StatefulWidget {
  static const String pageName = '/reward-points';
  const RewardPointPage({super.key});

  @override
  State<RewardPointPage> createState() => _RewardPointPageState();
}

class _RewardPointPageState extends State<RewardPointPage> {
  
  RewardPointModel? data;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    
    getData();
  }


  getData() async {
    setState(() {
      isLoading = true;
    });
    
    data = await UserService.getRewardPointsData();
    
    setState(() {
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.rewardPoints),

        body: isLoading
      ? loading()
      : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: padding(),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              space(18),

              // 3 item
              Container(
                padding: padding(horizontal: 12,vertical: 18),
                width: getSize().width,
                decoration: BoxDecoration(
                  border: Border.all(color: greyE7),
                  borderRadius: borderRadius(),
                ),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    // remained Points
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
                          child: SvgPicture.asset(AppAssets.giftSvg, colorFilter: ColorFilter.mode(green50, BlendMode.srcIn), width: 18),
                        ),

                        space(8),

                        Text(
                          data?.availablePoints?.toString() ?? '-',
                          style: style14Bold(),
                        ),

                        space(3),
                        
                        Text(
                          appText.remainedPoints,
                          style: style12Regular().copyWith(color: greyB2),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),

                    // total Points
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
                          child: SvgPicture.asset(AppAssets.totalPointSvg, colorFilter: ColorFilter.mode(blueFE, BlendMode.srcIn), width: 20),
                        ),

                        space(8),

                        Text(
                          data?.totalPoints?.toString() ?? '-',
                          style: style14Bold(),
                        ),

                        space(3),
                        
                        Text(
                          appText.totalPoints,
                          style: style12Regular().copyWith(color: greyB2),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),

                    // spent Points
                    Column(
                      children: [

                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: red49.withOpacity(.3),
                            shape: BoxShape.circle
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(AppAssets.spentPointSvg, colorFilter: ColorFilter.mode(red49, BlendMode.srcIn), width: 18),
                        ),

                        space(8),

                        Text(
                          data?.spentPoints?.toString() ?? '-',
                          style: style14Bold(),
                        ),

                        space(3),
                        
                        Text(
                          appText.spentPoints,
                          style: style12Regular().copyWith(color: greyB2),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),

                  ],
                ),
              ),

              space(24),


              Text(
                appText.pointsHistory,
                style: style16Bold(),
              ),

              space(16),

              ...List.generate(data?.rewards?.length ?? 0, (index) {
                return FinancialWidget.historyItem(
                  '', 
                  timeStampToDateHour((data?.rewards?[index].createdAt ?? 0) * 1000), 
                  data?.rewards?[index].score?.toString() ?? '0', 
                  data?.rewards?[index].status == 'addition'
                );
              })


            ],
          ),

        ),

      )
    );
  }

}