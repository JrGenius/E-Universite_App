import 'package:flutter/material.dart';
import 'package:webinar/app/models/register_config_model.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/config/assets.dart';

class RegisterDropDownWidget extends StatefulWidget {
  final Function(int data) setData;
  final String title;
  final List<Options> options;
  const RegisterDropDownWidget( this.setData, this.title, this.options, {super.key});

  @override
  State<RegisterDropDownWidget> createState() => _RegisterDropDownWidgetState();
}

class _RegisterDropDownWidgetState extends State<RegisterDropDownWidget> {

  bool isOpen=false;
  String itemSelected = '';

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: dropDown(
          widget.title, 
          itemSelected, 
          List.generate(widget.options.length, (index) => widget.options[index].getTitle()), 
          (){ // onTapOpenBox
            setState(() {
              isOpen = !isOpen;
            });
          }, 
          (newValue, index) {
            widget.setData(widget.options[index].id!);
            itemSelected = newValue;
          }, 
          isOpen,
          icon: AppAssets.infoCircleSvg,
          isBorder: false
        ),
      )
    );
  }
}