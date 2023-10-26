import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/model/user_model.dart';
import 'package:flutter_todo/theme/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool isDone = false;

  @override
  void dispose() {
    _userNameController.dispose();
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  final box = Hive.box<UserModel>('userBox');
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(width * 0.03),
            child: Column(
              children: [
                FadeInLeft(
                  child: TextFormField(
                    controller: _userNameController,
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
                          username: _userNameController.text,
                          title: _titleController.text,
                          description: _descController.text,
                          isDone: isDone,
                        );
                        box.put(const Uuid().v1(), userModel);

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
                              'با موفقیت اطلاعات ثبت شد',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'sahel',
                              ),
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      }

                      else {
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
                      'ثبت اطلاعات',
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
