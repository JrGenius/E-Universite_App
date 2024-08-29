import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/favorite_model.dart';
import 'package:webinar/app/services/user_service/user_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';

import '../../../../../config/assets.dart';
import '../../../../../config/colors.dart';
import '../../../../../config/styles.dart';

class FavoritesPage extends StatefulWidget {
  static const String pageName = '/favorites';
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  List<FavoriteModel> favorites = [];
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
    
    favorites = await UserService.getFavorites();
    
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.favorites),

        body: isLoading
      ? loading()
      : favorites.isEmpty
      ? Center(child: emptyState(AppAssets.favoriteEmptyStateSvg, appText.noFavorites, appText.noFavoritesDesc))
      : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: padding(vertical: 20, horizontal: 0),

          child: Column(
            children: [
              
              ...List.generate(favorites.length, (index) {
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
                
                        key: UniqueKey(),
                
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: .3,
                                                
                          children:  [

                            GestureDetector(
                              onTap: (){
                                UserService.deleteFavorite(favorites[index].id!);
                                favorites.removeAt(index);

                                setState(() {});
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
                            favorites[index].webinar!,
                            bottomMargin: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                );  
              }),

            ],
          ),
        ),

      )
    );
  }
}