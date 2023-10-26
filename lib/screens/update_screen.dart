import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../theme/colors.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({
    super.key,
    required this.userModel,
    required this.itemKey,
  });

  final UserModel userModel;
  final String itemKey;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  bool isDone = false;
  final box = Hive.box<UserModel>('userBox');
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _usernameController.text = widget.userModel.username;
    _titleController.text = widget.userModel.title;
    _descController.text = widget.userModel.description;

    isDone = widget.userModel.isDone;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _usernameController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  FadeInLeft(
                    child: TextFormField(
                      controller: _usernameController,
                      cursorColor: primaryColor,
                      decoration: decoration('نام کاربری'),
                      validator: validatorFunc('نام کاربری'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInRight(
                    child: TextFormField(
                      controller: _titleController,
                      cursorColor: primaryColor,
                      decoration: decoration('عنوان'),
                      validator: validatorFunc('عنوان'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInLeft(
                    child: TextFormField(
                      controller: _descController,
                      cursorColor: primaryColor,
                      decoration: decoration('توضیحات'),
                      validator: validatorFunc('توضیحات'),
                      textInputAction: TextInputAction.newline,
                      maxLines: 8,
                      minLines: 4,
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInRight(
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            // subtitle:  Text('برای زمانی که این کار انجام نشده'),
                            title: const Text('انجام نشده'),
                            value: false,
                            groupValue: isDone,
                            onChanged: (value) {
                              setState(() {
                                isDone = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text('انجام شده'),
                            value: true,
                            groupValue: isDone,
                            onChanged: (value) {
                              setState(() {
                                isDone = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * 0.75, 45),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final userModel = UserModel(
                            username: _usernameController.text,
                            title: _titleController.text,
                            description: _descController.text,
                            isDone: isDone,
                          );
                          box.put(widget.itemKey, userModel);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // action: SnackBarAction(
                              //   label: 'retuen',
                              //   onPressed: () {},
                              // ),
                              content: const Text(
                                'با موفقیت اطلاعات ویرایش شد',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'sahel',
                                ),
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'خطا',
                            desc: 'در مقادیر ورودی مشکلی پیش آمده',
                            // btnOkText: 'باشد',
                            btnCancelText: 'بستن',
                            btnCancelOnPress: () {},
                            // btnOkOnPress: () {},
                          ).show();
                        }
                      },
                      child: const Text(
                        'بروزرسانی اطلاعات',
                        style: TextStyle(
                          fontFamily: 'sahel',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validatorFunc(String label) {
    return (value) {
      if (value!.isEmpty) {
        return '$label نمیتواند خالی باشد';
      }
      if (value.length < 3) {
        return '$label نمیتواند کمتر از 3 کرکتر باشد';
      }
      return null;
    };
  }

  InputDecoration decoration(String label) {
    return InputDecoration(
      prefix: const Icon(Icons.edit_outlined),
      labelText: label,
      labelStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'sahel'),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: secondaryPrimaryColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: secondaryPrimaryColor, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 2, color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 2, color: Colors.red),
      ),
    );
  }
}
