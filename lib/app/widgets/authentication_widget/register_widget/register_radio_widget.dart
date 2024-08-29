import 'package:flutter/material.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../models/register_config_model.dart';

class RegisterRadioWidget extends StatefulWidget {
  final Function(int data) setData;
  final String title;
  final List<Options> options;
  const RegisterRadioWidget( this.setData, this.title, this.options, {super.key});

  @override
  State<RegisterRadioWidget> createState() => _RegisterRadioWidgetState();
}

class _RegisterRadioWidgetState extends State<RegisterRadioWidget> {
  int selectedId = -1;

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: SizedBox(
        width: getSize().width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            space(16),
        
            Text(
              widget.title,
              style: style14Regular().copyWith(color: greyB2),  
            ),
        
            space(6),
        
            ...List.generate(widget.options.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: radioButton(
                  widget.options[index].getTitle(), 
                  selectedId == widget.options[index].id, 
                  (value) {
                    selectedId = widget.options[index].id!;
                    widget.setData(selectedId);
                    
                    setState(() {});
                  }
                ),
              );
            })
        
          ],
        ),
      )
    );
  }
}