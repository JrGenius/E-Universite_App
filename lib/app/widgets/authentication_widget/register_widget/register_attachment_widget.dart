import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';

class RegisterAttachmentWidget extends StatefulWidget {
  final Function(File data) setData;
  final String title;
  const RegisterAttachmentWidget( this.setData, this.title, {super.key});

  @override
  State<RegisterAttachmentWidget> createState() => _RegisterAttachmentWidgetState();
}

class _RegisterAttachmentWidgetState extends State<RegisterAttachmentWidget> {
  
  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();


  File? file;


  Future<File> compressImage(XFile file) async {
    
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String address = '${appDocDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      address,
      quality: 55,
      minWidth: 550,
    );   

    
    return File(result!.path);
  }


  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: input(
          controller, 
          node, 
          file != null ? file?.path.split('/').last ?? '' : widget.title, 
          isReadOnly: true,
          iconPathLeft: AppAssets.uploadGreySvg,
          leftIconColor: greyB2,
          leftIconSize: 14,
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
            if(image != null){
              file = await compressImage(image);
              setState(() {});
      
              widget.setData(file!);
            }
          }
        ),
      ),
    );
  }


}