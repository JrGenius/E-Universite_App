import 'package:flutter/material.dart';
import 'package:webinar/app/models/register_config_model.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

class RegisterCheckboxWidget extends StatefulWidget {
  final Function(List<int> data) setData;
  final String title;
  final List<Options> options;
  const RegisterCheckboxWidget( this.setData, this.title, this.options, {super.key});
  
  @override
  State<RegisterCheckboxWidget> createState() => _RegisterCheckboxWidgetState();
}

class _RegisterCheckboxWidgetState extends State<RegisterCheckboxWidget> {

  List<int> ids = [];

  @override
  Widget build(BuildContext context) {
    return directionality(
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
              child: checkButton(
                widget.options[index].getTitle(), 
                ids.contains(widget.options[index].id), 
                (value) {
                  if(ids.contains(widget.options[index].id)){
                    ids.remove(widget.options[index].id);
                  }else{
                    ids.add(widget.options[index].id ?? 0);
                  }
              
                  widget.setData(ids);
                  setState(() {});
                }
              ),
            );
          })

        ],
      )
    );
  }
}