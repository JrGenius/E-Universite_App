import 'package:flutter/material.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';

class RegisterDatePickerWidget extends StatefulWidget {
  final Function(String data) setData;
  final String title;
  const RegisterDatePickerWidget( this.setData, this.title, {super.key});

  @override
  State<RegisterDatePickerWidget> createState() => _RegisterDatePickerWidgetState();
}

class _RegisterDatePickerWidgetState extends State<RegisterDatePickerWidget> {

  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: input(
          controller, 
          node, 
          widget.title, 
          isReadOnly: true,
          iconPathLeft: AppAssets.calendarSvg,
          leftIconColor: greyB2,
          leftIconSize: 14,
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context, 
              firstDate: DateTime(2000), 
              lastDate: DateTime(2030),
            );
      
            if(date!= null){
              controller.text = date.toString().split(' ').first;
              widget.setData(date.toString().split(' ').first);
            }
          }
        ),
      ),
    );
  }
}