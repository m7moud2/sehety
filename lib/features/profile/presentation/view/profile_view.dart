import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sehety/core/util/colors.dart';
import 'package:sehety/core/util/text_style.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? _imagePath;
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'الحساب الشخصي',
          style: getTextStyle(context, color: AppColors.whiteColor),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: AppColors.whiteColor,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: (_imagePath == null)
                          ? const AssetImage('assets/images/doc.png')
                          : FileImage(File(_imagePath!)) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _pickImage();
                          });
                        },
                        child: CircleAvatar(
                          radius: 11,
                          backgroundColor: AppColors.whiteColor,
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.primaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(30),
                Column(
                  children: [
                    Text(
                      'حمدي فتحي',
                      style:
                          getTextStyle(context, color: AppColors.primaryColor),
                    ),
                    const Gap(10),
                    Text(
                      'الفيوم',
                      style: getBodyStyle(
                        context,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Gap(20),
            Text(
              'نبذه تعريفيه',
              style: getTextStyle(context, fontSize: 13),
            ),
            const Gap(10),
            Text(
              'لم تضاف',
              style: getBodyStyle(context, fontSize: 11),
            ),
            const Gap(10),
            const Divider(
              endIndent: 10,
              indent: 10,
            ),
            const Gap(20),
            Text(
              'معلومات التواصل',
              style: getTextStyle(context),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker pickerImage = ImagePicker();
    XFile? path = await pickerImage.pickImage(source: ImageSource.gallery);
    if (path != null) {
      setState(() {
        _imagePath = path.path;
        file = File(path.path);
      });
    }
    // profileUrl = await uplodImageToFireStore(file!);
  }
}
