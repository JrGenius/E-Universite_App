import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:webinar/app/pages/main_page/home_page/dashboard_page/reward_point_page.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/user_service/user_service.dart';
import 'package:webinar/app/widgets/main_widget/financial_widget.dart/financial_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/currency_utils.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/locator.dart';
import 'package:html/parser.dart';
import '../../../../../common/utils/app_text.dart';
import '../../../../../config/assets.dart';
import '../../../../../config/styles.dart';
import '../../../../models/dashboard_model.dart';
import '../../../../widgets/main_widget/main_widget.dart';
import '../cart_page/cart_page.dart';
import '../notification_page.dart';

class DashboardPage extends StatefulWidget {
  static const String pageName = '/dashboard';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  DashboardModel? data;
  bool isLoading=false;

  int currentNotice = 0;
  // int currentSlide = 0;

  List<Color> gradientColors = [
    green77().withOpacity(.9),
    green77().withOpacity(.7),
    green77().withOpacity(.3),
    Colors.white.withOpacity(.1),
  ];

  List<int> dataSorted = [];


  @override
  void initState() {
    super.initState();
    
    getData();
  }

  getData() async {

    setState(() {
      isLoading = true;
    });

    data = await UserService.getDashboardData();
    
    dataSorted = data?.monthlyChart?.data ?? [];
    // print(dataSorted);
    
    setState(() {
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {

          return Scaffold(

            appBar: AppBar(
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              backgroundColor: green77(),
              elevation: 0,
              toolbarHeight: 65,

              title: Container(
                
                width: getSize().width,
                padding: padding(),
                child: Row(
                  children: [
    
                    // back 
                    MainWidget.menuButton(
                      AppAssets.backSvg, 
                      false, 
                      Colors.white, 
                      Colors.black.withOpacity(.2), 
                      (){ 
                        backRoute();
                      }
                    ),

                    space(0,width: 40),

    
                    const Spacer(),
    
                    // title
                    Center(
                      child: Text(
                        appText.dashboard,
                        style: style16Regular().copyWith(color: Colors.white),
                      ),
                    ),

                    const Spacer(),


    
                    // basket and notification
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                        // basket
                        MainWidget.menuButton(
                          AppAssets.basketSvg, 
                          userProvider.cartData?.items?.isNotEmpty ?? false, 
                          Colors.white, 
                          Colors.black.withOpacity(.2), 
                          (){ 
                            nextRoute(CartPage.pageName);
                          }
                        ),
    
                        space(0,width: 12),
    
                        // notification
                        MainWidget.menuButton(
                          AppAssets.notificationSvg, 
                          userProvider.notification.where((element) => element.status == 'unread').isNotEmpty,
                          Colors.white, 
                          Colors.black.withOpacity(.2), 
                          (){
                            nextRoute(NotificationPage.pageName);
                          }
                        )
                      ],
                    )
    
    
                  ],
                ),
              ),
            ),

            body: isLoading
          ? loading()
          : NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [

                  // app bar
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shadowColor: Colors.transparent,

                    toolbarHeight: 250,

                    titleSpacing: 0,
                    title: SizedBox(
                      height: 250,
                      child: Stack(
                        // alignment: Alignment.topCenter,
                        children: [
                          
                          // bg
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: getSize().width,
                              height: 155,
                              decoration: BoxDecoration(
                                color: green77(),
                                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28))
                              ),

                              child: SvgPicture.asset(
                                AppAssets.appbarLineSvg,
                                width: getSize().width * .9,
                              ),
                            )
                          ),


                          Positioned.fill(
                            child: Column(
                              children: [

                                const Spacer(flex: 1),


                                // name
                                Padding(
                                  padding: padding(),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                      Row(
                                        children: [

                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: getSize().width * .8,
                                              minWidth: getSize().width * .1
                                            ),
                                            child: Text(
                                              '${appText.hi} ${userProvider.profile?.fullName ?? ''} ',
                                              style: style20Bold().copyWith(color: Colors.white),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                                                  

                                          SvgPicture.asset(AppAssets.hiSvg),
                                          
                                        ],
                                      ),

                                      space(4),

                                      Text(
                                        '${appText.youHave} ${data?.unreadNotifications?.count ?? '-'} ${appText.newEvents}...',
                                        style: style14Regular().copyWith(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),

                                const Spacer(flex: 6),

                                SizedBox(
                                  width: getSize().width,
                                  height: 170,
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    padding: padding(),
                                    scrollDirection: Axis.horizontal,

                                    child: Row(
                                      children: [

                                        if(locator<UserProvider>().profile?.roleName != 'user')...{
                                          
                                          dashboardInfoBox(
                                            green50, 
                                            AppAssets.videoSvg, 
                                            data?.pendingAppointments?.toString() ?? '-', 
                                            appText.pendingMeetings, 
                                            (){

                                            }
                                          ),

                                        }else...{

                                          dashboardInfoBox(
                                            green50, 
                                            AppAssets.videoSvg, 
                                            data?.webinarsCount?.toString() ?? '-', 
                                            appText.purchasedCourses, 
                                            (){

                                            }
                                          ),
                                        },

                                        space(0,width: 16),

                                        dashboardInfoBox(
                                          orange50, 
                                          AppAssets.mailSvg, 
                                          data?.supportsCount?.toString() ?? '-', 
                                          appText.supportMessages, 
                                          (){

                                          },
                                          icWidth: 20
                                        ),
                                        
                                        space(0,width: 16),

                                        if(locator<UserProvider>().profile?.roleName != 'user')...{
                                          
                                          dashboardInfoBox(
                                            blueFE, 
                                            AppAssets.walletSvg, 
                                            CurrencyUtils.calculator(
                                              data?.monthlySalesCount ?? 0.0
                                            ), 
                                            appText.monthlySales, 
                                            (){

                                            }
                                          ),

                                        }else...{

                                          dashboardInfoBox(
                                            blueFE, 
                                            AppAssets.calendarEmptySvg, 
                                            data?.reserveMeetingsCount?.toString() ?? '-', 
                                            appText.meetings, 
                                            (){

                                            }
                                          ),
                                        },

                                        space(0,width: 16),

                                        dashboardInfoBox(
                                          cyan50, 
                                          AppAssets.commentsSvg, 
                                          data?.commentsCount?.toString() ?? '-', 
                                          appText.comments, 
                                          (){

                                          },
                                          icWidth: 22
                                        ),

                                        
                                      ],
                                    ),
                                  ),
                                )

                              ],
                            )
                          )


                        ],
                      ),
                    ),
                  )
                
                ];
              }, 

              body: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    space(30),
              
                    

                    Column(
                      children: [
                        // details
                        SizedBox(
                          width: getSize().width,
                          height: 190,

                          child: PageView(
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (value) {
                              setState(() {
                                currentNotice = value;
                              });
                            },
                            
                            children: [

                              FinancialWidget.financialCard(
                                CurrencyUtils.calculator(data?.balance), 
                                appText.accountBalance, 
                                '', 
                                (){}, 
                                AppAssets.walletSvg, 
                                green77(),
                                isBg: true
                              ),


                              slideUi(
                                data?.badges?.earned ?? '', '${appText.nextBadges}: ${data?.badges?.nextBadge ?? ''}', 
                                (){

                                },
                                isProgressBar: true, progressBarValue: data?.badges?.percent?.toString() ?? '0.0'
                              ),

                              FinancialWidget.financialCard(
                                data?.totalPoints?.toString() ?? '0', 
                                appText.rewardPoints, 
                                '', 
                                (){}, 
                                AppAssets.giftSvg, 
                                yellow29,
                                isBg: true,
                                onTapBox: (){
                                  nextRoute(RewardPointPage.pageName);
                                }
                              ),

                            ],

                          ),
                        ),

                        space(16),

                        // indecator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            ...List.generate(3, (index) {
                              return AnimatedContainer(
                                margin: padding(horizontal: 1.5),
                                duration: const Duration(milliseconds: 300),
                                width: currentNotice == index ? 16 : 7,
                                height: 7,
                                
                                decoration: BoxDecoration(
                                  color: green77(),
                                  borderRadius: borderRadius()
                                ),

                              );
                            }),
                            
                          ],
                        ),  

                      ],
                    ),
              
                    space(30),

                    // chart
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: padding(),
                          child: Text(
                            locator<UserProvider>().profile?.roleName != 'user' 
                              ? appText.monthSales
                              : appText.learningStatistics,
                            style: style16Bold(),
                          ),
                        ),
                  
                        // chart
                        AspectRatio(
                          aspectRatio: 8 / 7,
                          child: Container(
                            padding: padding(vertical: 20),
                            child: LineChart(
                              mainData(),
                            ),
                          ),
                        ),

                      ],
                    ),

                    space(30),

                    // notices
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: padding(),
                          child: Text(
                            appText.notices,
                            style: style16Bold(),
                          ),
                        ),

                        space(16),

                        // details
                        SizedBox(
                          width: getSize().width,
                          height: 190,

                          child: PageView.builder(
                            itemCount: data?.unreadNoticeboards?.length ?? 0,
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (value) {
                              setState(() {
                                currentNotice = value;
                              });
                            },
                            itemBuilder: (context, index) {
                              
                              return Container(
                                width: getSize().width,
                                height: 180,
                                margin: padding(),
                                
                                child: Stack(
                                  children: [

                                    // bg
                                    Positioned(
                                      bottom: 0,
                                      right: 12,
                                      left: 12,
                                      child: Container(
                                        width: getSize().width,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: borderRadius()
                                        ),
                                      )
                                    ),

                                    // details
                                    Positioned(
                                      child: Container(
                                        width: getSize().width,
                                        height: 180,

                                        padding: padding(horizontal: 16,vertical: 16),

                                        decoration: BoxDecoration(
                                          borderRadius: borderRadius(),
                                          color: Colors.white,
                                          boxShadow: [boxShadow(Colors.black.withOpacity(.03), blur: 15, y: 3)],
                                        ),

                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text(
                                              data?.unreadNoticeboards?[index].title ?? ''  ,
                                              style: style14Bold(),
                                            ),

                                            space(8),

                                            // name and date
                                            Row(
                                              children: [
                                                
                                                SvgPicture.asset(AppAssets.profileSvg),

                                                space(0,width: 4),

                                                Text(
                                                  data?.unreadNoticeboards?[index].sender ?? '',
                                                  style: style10Regular().copyWith(color: greyA5),
                                                ),

                                                
                                                space(0,width: 20),

                                                
                                                SvgPicture.asset(AppAssets.calendarSvg),

                                                space(0,width: 4),

                                                Text(
                                                  timeStampToDate( (data?.unreadNoticeboards?[index].createdAt ?? 0) * 1000 ),
                                                  style: style10Regular().copyWith(color: greyA5),
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                ),

                                              ],
                                            ),

                                            // line
                                            Container(
                                              margin: const EdgeInsets.symmetric(vertical: 12),
                                              width: getSize().width,
                                              height: 1,
                                              color: greyF8,
                                            ),

                                            Text(
                                              parse(data?.unreadNoticeboards?[index].message ?? '').body?.text ?? '',
                                              style: style14Regular().copyWith(color: greyA5),
                                            )


                                          ],
                                        ),
                                      )
                                    ),

                                  ],
                                ),
                              );

                            },
                          ),
                        ),

                        space(16),

                        // indecator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            ...List.generate(data?.unreadNoticeboards?.length ?? 0, (index) {
                              return AnimatedContainer(
                                margin: padding(horizontal: 1.5),
                                duration: const Duration(milliseconds: 300),
                                width: currentNotice == index ? 16 : 7,
                                height: 7,
                                
                                decoration: BoxDecoration(
                                  color: green77(),
                                  borderRadius: borderRadius()
                                ),

                              );
                            }),
                            
                          ],
                        ),  

                      ],
                    ),
              
              
                    space(50),
              

                  ],
                ),
              )

            ),
          );
        }
      )
    );
  }






  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    
    String? text;

    switch (value.toInt()) {
      case 1:
        text = 'Jan';
        break;
      
      case 2:
        text = 'Feb';
        break;
      
      case 3:
        text = 'Mar';
        break;
      
      case 4:
        text = 'Apr';
        break;
      
      case 5:
        text = 'May';
        break;
      
      case 6:
        text = 'Jun';
        break;
      
      case 7:
        text = 'Jul';
        break;
      
      case 8:
        text = 'Aug';
        break;
      
      case 9:
        text = 'Sep';
        break;
      
      case 10:
        text = 'Oct';
        break;
      
      case 11:
        text = 'Nov';
        break;
      
      case 12:
        text = 'Dec';
        break;

      default:
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text ?? '-',
        style: style10Regular().copyWith(),
      ),
    );
  }

  LineChartData mainData() {

    return LineChartData(

      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        

        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: greyA5,
            strokeWidth: .07,
          );
        },

        getDrawingVerticalLine: (value) {
          return FlLine(
            color: greyA5,
            strokeWidth: .07,
          );
        },
      ),

      titlesData:  FlTitlesData(
        show: true,
        
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),

        ),

        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),

      ),

      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.transparent),
      ),


      minX: 1.0,
      maxX: 12.0,
      minY: 0.0,
      maxY: data?.monthlyChart?.data?.reduce((curr, next) => curr.toInt() > next.toInt() ? curr.toInt() : next.toInt()).toDouble() ?? 1.0,
      
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return TouchedSpotIndicatorData(
              
              const FlLine(
                color: Colors.transparent,
                strokeWidth: 4,
              ),

              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  
                  return FlDotCirclePainter(
                    radius: 7,
                    color: Colors.white,
                    strokeWidth: 5,
                    strokeColor: const Color(0xff7DE9A4),
                  );
                  
                },
              ),

            );
          }).toList();
        },

        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (value) {
            return value.map((e) {
              return LineTooltipItem(
                e.y.toString(),
                style12Bold().copyWith(fontSize: 10,color: Colors.white)
              );
            }).toList();
          },
          getTooltipColor: (touchedSpot) {
            return green77();
          },
          // tooltipBgColor: green77(),
          tooltipPadding: padding(vertical: 8, horizontal: 16),
          tooltipRoundedRadius: 22
        ),
        
      ),

      lineBarsData: [
        LineChartBarData(
          
          spots: [
            ...List.generate(data?.monthlyChart?.data?.length ?? 0, (index) {
             
              return FlSpot(
                index + 1, 
                data?.monthlyChart?.data?[index].toDouble() ?? 0.0
              );
            }),
          ],
           
          isCurved: true,

          preventCurveOverShooting: true,
          
          gradient: LinearGradient(
            colors: [
              green77(),
              green77(),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter
          ),
          
          barWidth: 1,
          isStrokeCapRound: true,
          
          dotData: const FlDotData(
            show: false,
          ),
          
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter
            ),
          ),



        ),
      ],

    );
  }


  Widget slideUi(String title, String subTitle, Function onTap, {bool isProgressBar=false, String? progressBarValue}){
    
    return Container(
      padding: padding(),
      
      width: getSize().width,
      height: 180,
      decoration: const BoxDecoration(),
      child: Stack(
      clipBehavior: Clip.none,
        
        children: [

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
          
          
          Positioned(
            right: 0,
            left: 0,
            bottom: 10,
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
                        title,
                        style: style24Bold(),
                      ),
              
                      space(2),
              
                      Text(
                        subTitle,
                        style: style16Regular().copyWith(color: greyB2),
                      ),


                    ],
                  ),
              
                  
              
                ],
              ),
              
            ),
          ),

          PositionedDirectional(
            end: 16,
            bottom: 0,
            top: 0,
            child: Center(
              child: Container(
                
                width: 80,
                height: 80,
                      
                decoration: BoxDecoration(
                  color: yellow4C,
                  borderRadius: borderRadius(radius: 20)
                ),
                alignment: Alignment.center,

                child: isProgressBar
              ? Stack(
                  children: [

                    Positioned(
                      top: 14,
                      left: 14,
                      bottom: 14,
                      right: 14,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        value: double.parse(progressBarValue ?? '0.0') / 100,
                        backgroundColor: Colors.white.withOpacity(.3),
                        strokeWidth: 5,     
                      ),
                    ),

                    Center(
                      child: Text(
                        '${double.parse(progressBarValue ?? '0').toStringAsFixed(0)}%',
                        style: style16Bold().copyWith(color: Colors.white),
                      ),
                    )
                  ],
                )
              : Text(
                  ''
                ),
              ),
            )
          ),

          
        ],
      ),
    );
  }
}