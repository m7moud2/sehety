import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sehety/core/util/colors.dart';
import 'package:sehety/core/util/text_style.dart';
import 'package:sehety/core/widget/custom_button.dart';
import 'package:sehety/features/auth/data/specialization.dart';
import 'package:sehety/features/auth/presentation/widget/custom_text_form_field_doctor.dart';

class DoctorRegistrView extends StatefulWidget {
  const DoctorRegistrView({super.key});

  @override
  State<DoctorRegistrView> createState() => _DoctorRegistrViewState();
}

class _DoctorRegistrViewState extends State<DoctorRegistrView> {
  var key = GlobalKey<FormState>();
  String _specialization = specialization[0];
  String? _imagePath;
  File? file;
  String? profileUrl;
  String? userID;

  Future<void> _pickImage() async {
    final ImagePicker pickerImage = ImagePicker();
    XFile? path = await pickerImage.pickImage(source: ImageSource.gallery);
    if (path != null) {
      setState(() {
        _imagePath = path.path;
        file = File(path.path);
      });
    }

    profileUrl = await uplodImageToFireStore(file!);
  }

  Future<String> uplodImageToFireStore(File image) async {
    Reference ref =
        FirebaseStorage.instanceFor(bucket: 'gs://sehety-1.appspot.com')
            .ref()
            .child('doctors/${_auth.currentUser!.uid}');
    print('=========1============');
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    print('=========2============');
    await ref.putFile(image, metadata);
    print('=========3============');
    String url = await ref.getDownloadURL();
    return url;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _getUser() async {
    userID = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'إكمال عملية التسجيل',
          style: getTextStyle(context, color: AppColors.whiteColor),
        ),
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
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
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: DropdownButton(
                    isExpanded: true,
                    iconEnabledColor: AppColors.primaryColor,
                    icon: const Icon(Icons.expand_circle_down_outlined),
                    value: _specialization,
                    onChanged: (String? newValue) {
                      setState(() {
                        _specialization = newValue ?? specialization[1];
                      });
                    },
                    items: specialization.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const CustomTextFormFieldDoctor(
                  titleText: 'نبذة تعريفية',
                  maxLines: 5,
                  hintText:
                      'سجل المعلومات الطبية العامة مثل تعليمك الأكادمي وخبرتك السابقة...',
                ),
                const Gap(5),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                const Gap(10),
                const CustomTextFormFieldDoctor(
                  titleText: 'عنوان العيادة',
                  hintText: '5 شارع مصدق - الدقي - الجيزة',
                ),
                const Gap(10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextFormFieldDoctor(
                        titleText: 'ساعات العمل من',
                        hintText: 'AM 10:00',
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: CustomTextFormFieldDoctor(
                        titleText: 'الى',
                        hintText: '؛’ 10:00',
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                const CustomTextFormFieldDoctor(
                  titleText: 'رقم الهاتف 1',
                  hintText: '+20xxxxxxxxxxxxxx',
                ),
                const Gap(10),
                const CustomTextFormFieldDoctor(
                  titleText: 'رقم الهاتف 2',
                  hintText: '+20xxxxxxxxxxxxxx',
                ),
                const Gap(50),
                CustomButton(
                  onPressed: () {},
                  text: 'تسجيل',
                  color: AppColors.primaryColor,
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
