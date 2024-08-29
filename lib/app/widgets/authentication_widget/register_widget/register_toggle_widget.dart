import 'package:flutter/material.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';

class RegisterToggleWidget extends StatefulWidget {
  final Function(bool data) setData;
  final String title;
  const RegisterToggleWidget( this.setData, this.title, {super.key});

  @override
  State<RegisterToggleWidget> createState() => _RegisterToggleWidgetState();
}

class _RegisterToggleWidgetState extends State<RegisterToggleWidget> {
  
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: switchButton(widget.title, state, (value) {
          setState(() {
            state = value;
            widget.setData(state);
          });
        }),
      ),
    );
  }
}