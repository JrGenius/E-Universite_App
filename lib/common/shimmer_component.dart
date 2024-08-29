
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/data/app_language.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/locator.dart';

Widget courseItemVerticallyShimmer(){
  
  return Shimmer.fromColors(
    baseColor: greyE7,
    highlightColor: greyF8,
    child: Container(
      margin: const EdgeInsetsDirectional.only(bottom: 16),
    
      decoration: BoxDecoration(
        borderRadius: borderRadius()
      ),
    
      padding: padding(horizontal: 8,vertical: 8),
      width: getSize().width,
    
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        
          // image
          shimmerUi(height: 85, width: 135),
        
          // details
          Expanded(
            child: SizedBox(
              height: 85,
              child: Padding(
                padding: padding(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                                    
                    // title
                    shimmerUi(height: 8, width: getSize().width * .5),
                    
                    // name and date and time
                    shimmerUi(height: 8, width: getSize().width * .3),
                
                    // price and date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
      
                        shimmerUi(height: 8, width: getSize().width * .35),
        
                        shimmerUi(height: 8, width: 20),
                        
                      ],
                    ),
                
                
                  ],
                ),
              ),
            ),
          ),
        
        
          
        
        ],
      ),
    ),
  );

}


Widget courseItemShimmer({bool isSmallSize=true,double width = 158.0,height = 200.0,double endCardPadding=16.0, bool isShowReward=false}){
  

  return Shimmer.fromColors(
    baseColor: greyE7,
    highlightColor: greyF8,
    child: Container(
      margin: EdgeInsetsDirectional.only(end: endCardPadding),
      width: width,
      height: height,
    
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      
          // image
          ClipRRect(
            borderRadius: borderRadius(radius: 15),
            child: Container(
              width: width,
              height: 100,
              color: grey33,
            ),
          ),
      
          // details
          Expanded(
            child: Padding(
              padding: padding(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  
                  space(12),
              
                  // title
                  Container(
                    width: width,
                    height: 10,
                    decoration: BoxDecoration(color: grey33, borderRadius: borderRadius()),
                  ),

                  space(10),
                  
                  Container(
                    width: width / 4,
                    height: 10,
                    decoration: BoxDecoration(color: grey33, borderRadius: borderRadius()),
                  ),
                  
                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
      
                      Container(
                        width: (width / 2.3),
                        height: 8,
                        decoration: BoxDecoration(color: grey33, borderRadius: borderRadius()),
                      ),
      
                      Container(
                        width: (width / 2.3),
                        height: 8,
                        decoration: BoxDecoration(color: grey33, borderRadius: borderRadius()),
                      ),
                      
              
                      
                    ],
                  ),

                  space(10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
      
                      Container(
                        width: (width / 4),
                        height: 8,
                        decoration: BoxDecoration(color: grey33, borderRadius: borderRadius()),
                      ),
      
                      Container(
                        width: (width / 4),
                        height: 8,
                        decoration: BoxDecoration(color: grey33, borderRadius: borderRadius()),
                      ),
                      
              
                      
                    ],
                  ),
              
                  // const Spacer(),
              
                ],
              ),
            ),
          ),
      
      
          
      
        ],
      ),
    ),
  );

}

Widget classesCourseItemShimmer(){
  return Shimmer.fromColors(
    baseColor: greyE7,
    highlightColor: greyF8,
    child: Container(
      margin: const EdgeInsetsDirectional.only(bottom: 16),
    
      decoration: BoxDecoration(
        borderRadius: borderRadius()
      ),
    
      padding: padding(horizontal: 10,vertical: 9),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // course details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
  
              shimmerUi(height: 85, width: 130),
  
              // details
              Expanded(
                child: SizedBox(
                  height: 85,
                  child: Padding(
                    padding: padding(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                                        
                        // title
                        shimmerUi(height: 8, width: getSize().width * .4),
                        
                        
                        // name and date and time
                        shimmerUi(height: 8, width: 60),
                    
                        // price and date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            // date
                            shimmerUi(height: 8, width: 70),

                            // price
                            Row(
                              children: [
                    
                                shimmerUi(height: 8, width: 20),            
                              ],
                            ),
  
  
  
                            
                          ],
                        ),

                    
                      ],
                    ),
                  ),
                ),
              ),
  
  
              
  
            ],
          ),

          space(24),

          // category and publish date
          Row(
            children: [

              // category
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    shimmerUi(height: 8, width: 70),

                    space(6),

                    shimmerUi(height: 8, width: 70),

                  ],
                )
              ),
              
              // Publish Date
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    shimmerUi(height: 8, width: 70),
                    
                    space(6),
                                                    
                    shimmerUi(height: 8, width: 70),

                  ],
                )
              ),


            ],
          ),

          space(24),

          // progress
          shimmerUi(height: 8, width: getSize().width),
          

          

          space(12),
        ],
      ),
    )
  );
}

Widget blogItemShimmer(){
  
  return Shimmer.fromColors(
    baseColor: greyE7,
    highlightColor: greyF8,
    child: Container(
      width: getSize().width,
      padding: padding(horizontal: 10,vertical: 10),
      margin: const EdgeInsets.only(bottom: 16),
    
      decoration: BoxDecoration(
        borderRadius: borderRadius(radius: 15),
      ),
    
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // image
          shimmerUi(height: 200, width: getSize().width,radius: 10),
    
          space(16),
    
          // title
          shimmerUi(height: 8, width: getSize().width * .6),
    
          space(20),
    
          // desc
          shimmerUi(height: 8, width: getSize().width),
          
          space(8),
          
          // desc
          shimmerUi(height: 8, width: getSize().width),
          
          space(8),

          // desc
          shimmerUi(height: 8, width: getSize().width * .3),
          
          
    
          space(24),
    
          Row(
            children: [
              
              shimmerUi(height: 8, width: 50),
    
              space(0,width: 20),
              
              shimmerUi(height: 8, width: 50),
    
            ],
          )
    
    
        ],
      ),
    ),
  );

}

Widget userProfileCardShimmer(){  
  return Shimmer.fromColors(
    baseColor: greyE7,
    highlightColor: greyF8,
    child: Container(
      width: 155,
      height: 195,
      padding: padding(horizontal: 14,vertical: 14),
      
      decoration: BoxDecoration(
        borderRadius: borderRadius()
      ),
    
      child: Column(
        children: [
          // meet status
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: shimmerUi(height: 22, width: 22,radius: 50)
          ),
    
    
          Expanded(
            child: Column(
              children: [

                shimmerUi(height: 70, width: 70, radius: 100),
          
                const Spacer(flex: 1),
          
                shimmerUi(height: 8, width: getSize().width * .2),
    
                space(6),
                
                shimmerUi(height: 8, width: getSize().width * .3),
                
                space(12),
    
                shimmerUi(height: 8, width: getSize().width * .2),
          
                const Spacer(flex: 2),
          
              ],
            ),
          )
        ],
      ),
    
    ),
  );
}

Widget horizontalCategoryItemShimmer(){
  return Shimmer.fromColors(
    baseColor: greyE7,
    highlightColor: greyF8,
    child: Container(
      width: getSize().width * .7,
      margin: const EdgeInsetsDirectional.only(end: 16),
      padding: padding(horizontal: 16,vertical: 16),
      
      decoration: BoxDecoration(
        borderRadius: borderRadius(radius: 15),
      ),
      
      child: Row(
        children: [
      
          shimmerUi(height: 65, width: 65, radius: 6),
      
          space(0,width: 16),
      
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
      
              shimmerUi(height: 8, width: 100,),
              
              space(10),
              
              shimmerUi(height: 8, width: 50,),
      
            ],
          )
      
          
        ],
      ),
    
    ),
  );
}

Widget categoryItemShimmer(){
  return Shimmer.fromColors(
    baseColor: greyE7,
    highlightColor: greyF8,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 20),
      child: Row(
        children: [
          
          
          shimmerUi(height: 34, width: 34, radius: 30),
      
          space(0,width: 10),
      
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
      
              shimmerUi(height: 8, width: getSize().width * .3),
              
              space(8),
              
              shimmerUi(height: 8, width: getSize().width * .2),
              
            ],
          ),
      
      
          const Spacer(),
      
          AnimatedRotation(
            turns: locator<AppLanguage>().isRtl()
                ? 180 / 360 
                : 0, 
            duration: const Duration(milliseconds: 200),
            child: SvgPicture.asset(
              AppAssets.arrowRightSvg
              
            ),
          )
          
      
      
      
        ],
      ),
    ),
  );
}



Widget shimmerUi({required double height, required double width, double radius=15}){
  return Container(
    width: width,
    height: height,

    decoration: BoxDecoration(
      color: grey33,
      borderRadius: borderRadius(radius: radius),
    ),
  );
}
