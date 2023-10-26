import 'package:flutter/material.dart';
import 'package:flutter_todo/model/user_model.dart';
import 'package:flutter_todo/screens/add_screen.dart';
import 'package:flutter_todo/screens/update_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShowScreen extends StatefulWidget {
  const ShowScreen({super.key});

  @override
  State<ShowScreen> createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: const Text(
            'افزودن',
            style: TextStyle(fontFamily: 'sahel'),
          ),
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddScreen(),
              ),
            );
          },
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<UserModel>('userBox').listenable(),
          builder: (BuildContext context, Box box, Widget? child) {
            return box.isEmpty
                ? EmptyWidget(width: width)
                : ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final helper = box.getAt(index) as UserModel;
                      return Dismissible(
                        key: ValueKey(helper.key),
                        confirmDismiss: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            return Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UpdateScreen(
                                  userModel: helper,
                                  itemKey: helper.key,
                                ),
                              ),
                            );
                          }
                          return showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 200,
                                padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'حذف ایتم؟!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'sahel'),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'ایا اطمینان دارید؟',
                                      style: TextStyle(fontSize: 16, fontFamily: 'sahel'),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                            fixedSize: Size(width*0.4,45),
                                          ),
                                          onPressed: () {},
                                          child: const Text('انصراف'),
                                        ),
                                        const SizedBox(width: 20),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: Size(width*0.4,45),
                                          ),
                                          onPressed: () {
                                            box.delete(helper.key);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('تایید'),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        background: Container(
                          margin: EdgeInsets.all(width * 0.02),
                          padding: EdgeInsets.all(width * 0.02),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.edit),
                        ),
                        secondaryBackground: Container(
                          margin: EdgeInsets.all(width * 0.02),
                          padding: EdgeInsets.all(width * 0.02),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.delete),
                        ),
                        child: Card(
                          margin: EdgeInsets.all(width * 0.02),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              // onTap: () {
                              //
                              // },
                              title: Text(helper.username),
                              subtitle: Text(helper.description),
                              trailing:helper.isDone? const Icon(
                                Icons.check_circle,
                                color: Colors.green,

                              ):  const Icon(
                                  Icons.circle_outlined,
                                  color: Colors.red,

                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/dontknow.png',
            width: width * 0.6,
          ),
          const SizedBox(height: 20),
          const Text(
            'اطلاعاتی درج نشده',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'sahel',
            ),
          )
        ],
      ),
    );
  }
}
