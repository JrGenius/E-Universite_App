import 'package:flutter/material.dart';
import 'package:webinar/app/models/category_model.dart';
import 'package:webinar/app/providers/providers_provider.dart';
import 'package:webinar/app/services/guest_service/categories_service.dart';
import 'package:webinar/common/common.dart';

import '../../../../common/utils/app_text.dart';
import '../../../../config/colors.dart';
import '../../../../config/styles.dart';
import '../../../../locator.dart';
import '../../../../common/components.dart';

class ProvidersFilter extends StatefulWidget {
  const ProvidersFilter({super.key});

  @override
  State<ProvidersFilter> createState() => _ProvidersFilterState();
}

class _ProvidersFilterState extends State<ProvidersFilter> {

  bool availableForMeetings = false;
  bool freeClasses = false;
  bool discountClasses = false;
  bool downloadabeClasses = false;

  bool allSort = false;
  bool bestSellerSort = false;
  bool bestRatedSort = false;

  List<CategoryModel> allCategories = [];
  List<CategoryModel> categoriesSelected = [];


  @override
  void initState() {
    super.initState();

    availableForMeetings = locator<ProvidersProvider>().availableForMeeting;
    freeClasses = locator<ProvidersProvider>().free;
    discountClasses = locator<ProvidersProvider>().discount;
    downloadabeClasses = locator<ProvidersProvider>().downloadable;

    categoriesSelected = locator<ProvidersProvider>().categorySelected;


    switch (locator<ProvidersProvider>().sort) {
      case '':
        allSort = true;
        break;
      
      case 'top_sale':
        bestSellerSort = true;
        break;
      
      case 'top_rate':
        bestRatedSort = true;
        break;

      default:
    }

    CategoriesService.categories().then((value) {
      value.forEach((element) {
        allCategories.add(element);

        element.subCategories?.forEach((subElement) {  
          allCategories.add(subElement);
        });

      });

      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(

      constraints: BoxConstraints(
        minHeight: getSize().height * .3,
        maxHeight: getSize().height * .8,
      ),

      child: directionality(
        child: SingleChildScrollView(
          padding: padding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              space(20),
                
                Text(
                  appText.filters,
                  style: style20Bold(),
                ),
              
                space(12),
              
                switchButton(appText.availableForMeetings, availableForMeetings, (value) {
                  setState(() {
                    availableForMeetings = value;
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


                space(28),

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

                space(28),

                Text(
                  appText.categories,
                  style: style20Bold(),
                ),

                space(16),

                // category items
                SizedBox(
                  width: getSize().width,
                  child: AnimatedCrossFade(
                    firstChild: SizedBox(
                      width: getSize().width,
                    ), 
                    secondChild: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(allCategories.length, (index) {

                        return GestureDetector(
                          onTap: (){

                            checkCategory(index) ? categoriesSelected.removeWhere((element) => element.id == allCategories[index].id) : categoriesSelected.add(allCategories[index]);

                            setState(() {});
                          },
                          behavior: HitTestBehavior.opaque,
                          child: AnimatedContainer(
                            padding: padding(horizontal: 17,vertical: 15),
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: checkCategory(index) ? green77() : Colors.white,
                              border: Border.all(
                                color: green77(),
                              ),
                              borderRadius: borderRadius(radius: 10)
                            ),

                            child: Text(
                              allCategories[index].title ?? '',
                              style: style12Regular().copyWith(
                                color: checkCategory(index) ? Colors.white : green77()
                              ),
                            ),

                          ),
                        );
                      }),
                    ), 
                    crossFadeState: allCategories.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
                    duration: const Duration(milliseconds: 800),
                  )
                ),
                
              
                space(25),
                
                button(
                  onTap: (){
                  
                    locator<ProvidersProvider>().availableForMeeting = availableForMeetings;
                    locator<ProvidersProvider>().free = freeClasses;
                    locator<ProvidersProvider>().discount = discountClasses;
                    locator<ProvidersProvider>().downloadable = downloadabeClasses;



                    locator<ProvidersProvider>().sort = allSort
                      ? ''
                      : bestSellerSort
                        ? 'top_sale'
                        : bestRatedSort
                          ? 'top_rate'
                          : '';

                    locator<ProvidersProvider>().categorySelected = [];
                    locator<ProvidersProvider>().categorySelected = categoriesSelected;

                    backRoute(arguments: true);

                  }, 
                  width: getSize().width, 
                  height: 52, 
                  text: appText.filterItems, 
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


  bool checkCategory(int index){

    for (var element in categoriesSelected) {
      if(allCategories[index].id! == element.id){
        return true;
      }
    }
    return false;
  }

  sortOff(){
    allSort = false;
    bestSellerSort = false;
    bestRatedSort = false;
  }
}