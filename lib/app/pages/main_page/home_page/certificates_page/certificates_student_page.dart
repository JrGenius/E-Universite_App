import 'package:flutter/material.dart';
import 'package:webinar/app/models/user_model.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';

class CertificatesStudentPage extends StatefulWidget {
  static const String pageName = '/certificate-students';
  const CertificatesStudentPage({super.key});

  @override
  State<CertificatesStudentPage> createState() => _CertificatesStudentPageState();
}

class _CertificatesStudentPageState extends State<CertificatesStudentPage> {

  List<UserModel> data = [];


  @override
  void initState() {    
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      data = ModalRoute.of(context)!.settings.arguments as List<UserModel>;

      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        
        appBar: appbar(title: appText.certificateStudents),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: padding(vertical: 20),
          child: Column(
            children: List.generate(data.length, (index){
              return userCard(
                data[index].avatar ?? '', 
                data[index].fullName ?? '', 
                data[index].bio ?? '', 
                '-', 
                '', 
                '', 
                (){}
              );
            }),
          ),
        ),

      )
    );
  }
}