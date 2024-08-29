import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:webinar/app/models/notification_model.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/styles.dart';

import '../../../../common/common.dart';
import '../../../../common/utils/date_formater.dart';
import '../../../../config/colors.dart';

class NotificationWidget{

  static showDetailsSheet(NotificationModel notification){
    baseBottomSheet(
      child: Padding(
        padding: padding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            space(20),

            Text(
              notification.title ?? '',
              style: style14Bold(),
            ),

            space(6),
            
            Text(
              timeStampToDateHour((notification.createdAt ?? 0) * 1000),
              style: style12Regular().copyWith(color: greyA5),
            ),

            space(3),

            Divider(color: greyA5.withOpacity(.7)),

            space(6),

            HtmlWidget(
              notification.message ?? '',
              textStyle: style14Regular(),
            ),

            
            space(40),

            button(
              onTap: backRoute, 
              width: getSize().width, 
              height: 52, 
              text: appText.close, 
              bgColor: green77(), 
              textColor: Colors.white
            ),

            space(25),

          ],
        ),
      )
    );
  }
}