import 'package:flutter/material.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';

class RegisterTextareaWidget extends StatefulWidget {
  final Function(String data) setData;
  final String title;
  const RegisterTextareaWidget( this.setData, this.title, {super.key});


  @override
  State<RegisterTextareaWidget> createState() => _RegisterTextareaWidgetState();
}

class _RegisterTextareaWidgetState extends State<RegisterTextareaWidget> {
  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: descriptionInput(
          controller, 
          node, 
          widget.title, 
          onChange: (d){
            widget.setData(controller.text.trim());
          },
        ),
      ),
    );
  }
}