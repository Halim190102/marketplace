// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:marketplace/Views/Login%20Pages/login.dart';

// class BottomSheets extends StatefulWidget {
//   const BottomSheets({Key? key}) : super(key: key);

//   @override
//   State<BottomSheets> createState() => _BottomSheetsState();
// }

// class _BottomSheetsState extends State<BottomSheets> {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final user = FirebaseAuth.instance.currentUser!.displayName;
//   final email = FirebaseAuth.instance.currentUser!.email;

//   _signOut() async {
//     await _firebaseAuth.signOut();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: Column(
//         children: [
//           const CircleAvatar(
//             radius: 70,
//             backgroundImage: AssetImage('assets/images/user.png'),
//           ),
//           const SizedBox(height: 25),
//           Text(
//             user.toString(),
//             style: const TextStyle(
//               fontSize: 23,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 15),
//           ListTile(
//             title: const Text('Pengaturan'),
//             trailing: const Icon(Icons.chevron_right),
//             onTap: () {},
//           ),
//           ListTile(
//             title: const Text('FAQ'),
//             trailing: const Icon(Icons.chevron_right),
//             onTap: () {},
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   await _signOut();
//                   if (!mounted) return;
//                   if (_firebaseAuth.currentUser == null) {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LoginPage(),
//                       ),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.brown,
//                 ),
//                 child: const Text('Keluar'),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
