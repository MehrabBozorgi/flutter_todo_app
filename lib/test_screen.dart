// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});
//
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final box = Hive.box('testBox');
//
//   ///CRUD
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               _controller.text,
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 30),
//             TextField(
//               controller: _controller,
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   box.put(2, _controller.text);
//                 });
//               },
//               child: const Text('create'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _controller.text = box.get(2);
//                 });
//               },
//               child: const Text('read'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   box.put(2, _controller.text);
//                 });
//               },
//               child: const Text('update'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   box.delete(2);
//                 });
//               },
//               child: const Text('delete'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
