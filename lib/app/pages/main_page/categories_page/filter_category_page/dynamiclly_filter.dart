import 'package:flutter/material.dart';
import 'package:webinar/app/models/filter_model.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/config/styles.dart';

import '../../../../../common/utils/app_text.dart';
import '../../../../../config/colors.dart';
import '../../../../../locator.dart';
import '../../../../providers/filter_course_provider.dart';
import '../../../../../common/components.dart';

class DynamicllyFilter extends StatefulWidget {
  const DynamicllyFilter({super.key});

  @override
  State<DynamicllyFilter> createState() => _DynamicllyFilterState();
}

class _DynamicllyFilterState extends State<DynamicllyFilter> {

  List<FilterModel> filters = [];

  List<int> filterSelected = [];

  @override
  void initState() {
    super.initState();

    filters = locator<FilterCourseProvider>().filters;

    filterSelected = locator<FilterCourseProvider>().filterSelected;
  }

  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getSize().height * .8,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: directionality(
          child: Padding(
            padding: padding(vertical: 24),
            child: Column(
              children: 
              [
                ...List.generate(filters.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // title
                      Text(
                        filters[index].title ?? '',
                        style: style20Bold(),
                      ),
            
                      space(16),
            
                      // options
                      ...List.generate(filters[index].options?.length ?? 0, (i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: checkButton(filters[index].options?[i].title ?? '', filterSelected.contains(filters[index].options?[i].id), (value) {
                            
                            if(filterSelected.contains(filters[index].options?[i].id)){
                              filterSelected.remove(filters[index].options?[i].id);
                            }else{
                              filterSelected.add(filters[index].options?[i].id ?? -1);
                            }
                        
                            setState(() {});
                          }),
                        );
                      }),
            
                    ],
                  );
                    
                }),

                space(25),
                
                button(
                  onTap: (){
                    locator<FilterCourseProvider>().filterSelected = filterSelected;
                    backRoute(arguments: true);
                  }, 
                  width: getSize().width, 
                  height: 52, 
                  text: appText.filterItems, 
                  bgColor: green77(), 
                  textColor: Colors.white
                ),
                
                space(30),
              ]
            ),
          )
        ),
      ),
    );

  }

}