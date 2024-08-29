import 'package:flutter/material.dart';
import 'package:webinar/app/providers/filter_course_provider.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';
import 'package:webinar/locator.dart';

import '../../../../../common/components.dart';

class OptionsFilter extends StatefulWidget {
  const OptionsFilter({super.key});

  @override
  State<OptionsFilter> createState() => _OptionsFilterState();
}

class _OptionsFilterState extends State<OptionsFilter> {

  bool upcomingClasses = false;
  bool freeClasses = false;
  bool discountClasses = false;
  bool downloadabeClasses = false;
  bool bundleCourse = false;
  
  bool allSort = false;
  bool newestSort = false;
  bool highSort = false;
  bool lowSort = false;
  bool bestSellerSort = false;
  bool bestRatedSort = false;


  @override
  void initState() {
    super.initState();
    
    upcomingClasses = locator<FilterCourseProvider>().upcoming;
    freeClasses = locator<FilterCourseProvider>().free;
    discountClasses = locator<FilterCourseProvider>().discount;
    downloadabeClasses = locator<FilterCourseProvider>().downloadable;
    bundleCourse = locator<FilterCourseProvider>().bundleCourse;


    switch (locator<FilterCourseProvider>().sort) {
      case '':
        allSort = true;
        break;
      
      case 'newest':
        newestSort = true;
        break;
      
      case 'expensive':
        highSort = true;
        break;
      
      case 'inexpensive':
        lowSort = true;
        break;
      
      case 'bestsellers':
        bestSellerSort = true;
        break;
      
      case 'best_rates':
        bestRatedSort = true;
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      width: getSize().width,
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: getSize().height * .8
      ),
      child: directionality(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: padding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
            
              space(20),
              
              Text(
                appText.options,
                style: style20Bold(),
              ),
            
              space(12),
            
              switchButton(appText.upcomingClasses, upcomingClasses, (value) {
                setState(() {
                  upcomingClasses = value;
                });
              }),
              
              space(12),
            
              switchButton(appText.freeClasses, freeClasses, (value) {
                setState(() {
                  freeClasses = value;
                });
              }),
              
              space(12),
            
              switchButton(appText.discountedClasses, discountClasses, (value) {
                setState(() {
                  discountClasses = value;
                });
              }),
              
              space(12),
            
              switchButton(appText.downloadableContent, downloadabeClasses, (value) {
                setState(() {
                  downloadabeClasses = value;
                });
              }),
              
              space(12),
            
              switchButton(appText.bundleCourse, bundleCourse, (value) {
                setState(() {
                  bundleCourse = value;
                });
              }),
            
              space(25),
            
              Text(
                appText.sortBy,
                style: style20Bold(),
              ),
            
              space(16),
            
              radioButton(appText.all, allSort, (value) {
                sortOff();
                allSort = value;
                setState(() {});
              }),
              
              space(16),
            
              radioButton(appText.newest, newestSort, (value) {
                sortOff();
                newestSort = value;
                setState(() {});
              }),
              
              space(16),
            
              radioButton(appText.highestPrice, highSort, (value) {
                sortOff();
                highSort = value;
                setState(() {});
              }),
              
              space(16),
            
            
              radioButton(appText.lowestPrice,lowSort, (value) {
                sortOff();
                lowSort = value;
                setState(() {});
              }),
            
              space(16),
            
              radioButton(appText.bestSellers, bestSellerSort, (value) {
                sortOff();
                bestSellerSort = value;
                setState(() {});
              }),
            
              space(16),
            
              radioButton(appText.bestRated, bestRatedSort, (value) {
                sortOff();
                bestRatedSort = value;
                setState(() {});
              }),
              
            
              space(25),
              
              button(
                onTap: (){
                
                  locator<FilterCourseProvider>().upcoming = upcomingClasses;
                  locator<FilterCourseProvider>().free = freeClasses;
                  locator<FilterCourseProvider>().discount = discountClasses;
                  locator<FilterCourseProvider>().downloadable = downloadabeClasses;
                  locator<FilterCourseProvider>().bundleCourse = bundleCourse;
        
        
        
                  locator<FilterCourseProvider>().sort = allSort
                    ? ''
                    : newestSort
                      ? 'newest'
                      : highSort
                        ? 'expensive'
                        : lowSort
                          ? 'inexpensive'
                          : bestSellerSort
                            ? 'bestsellers'
                            : bestRatedSort
                              ? 'best_rates'
                              : '';
        
                  backRoute(arguments: true);
        
        
                }, 
                width: getSize().width, 
                height: 52, 
                text: appText.applyOptions, 
                bgColor: green77(), 
                textColor: Colors.white
              ),
              
              space(30),
            
            ],
          ),
        )
      ),
    );
  }


  sortOff(){
    allSort = false;
    newestSort = false; 
    highSort = false;
    lowSort = false;
    bestSellerSort = false;
    bestRatedSort = false;
  }
}