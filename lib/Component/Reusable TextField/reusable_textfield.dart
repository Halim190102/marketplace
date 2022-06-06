import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textField({
  required TextEditingController controller,
  required String lable,
  required String? Function(String?)? valid,
  required String? Function(String?)? onChange,
  required bool boolean,
  required AutovalidateMode submit,
  TextInputType? type,
  List<TextInputFormatter>? format,
  Widget? icon,
}) {
  return TextFormField(
    inputFormatters: format,
    keyboardType: type,
    autovalidateMode: submit,
    onChanged: onChange,
    obscureText: boolean,
    validator: valid,
    controller: controller,
    decoration: InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(),
      ),
      errorStyle: const TextStyle(),
      contentPadding: const EdgeInsets.symmetric(vertical: 18.5),
      hintText: lable,
      hintStyle: const TextStyle(
        fontSize: 15,
      ),
      border: const UnderlineInputBorder(),
      isDense: true,
      suffixIcon: icon,
    ),
  );
}

// class TextField extends StatefulWidget {
//   const TextField({
//     Key? key,
//     required this.controller,
//     required this.label,
//     required this.valid,
//     required this.boolean,
//     this.icon,
//     // this.format,
//     // this.type,
//   }) : super(key: key);
//   final TextEditingController controller;
//   final String? Function(String?) valid;
//   final bool? boolean, icon;
//   final String label;

//   // final List<TextInputFormatter>? format;
//   // final TextInputType? type;

//   @override
//   State<TextField> createState() => _TextFieldState();
// }

// class _TextFieldState extends State<TextField> {
//   bool _passwordVisible = true;
//   bool submit = true;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.controller,
//       decoration: InputDecoration(
//         focusedBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(),
//         ),
//         enabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(),
//         ),
//         focusedErrorBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(),
//         ),
//         errorStyle: const TextStyle(),
//         contentPadding: const EdgeInsets.symmetric(vertical: 18.5),
//         hintText: widget.label,
//         hintStyle: const TextStyle(
//           fontSize: 15,
//         ),
//         border: const UnderlineInputBorder(),
//         isDense: true,
//         suffixIcon: widget.icon!
//             ? IconButton(
//                 onPressed: () {
//                   setState(() {
//                     _passwordVisible = !_passwordVisible;
//                   });
//                 },
//                 icon: Icon(
//                   _passwordVisible ? Icons.visibility_off : Icons.visibility,
//                   color: Colors.grey,
//                 ),
//               )
//             : null,
//       ),
//       autovalidateMode: submit
//           ? AutovalidateMode.onUserInteraction
//           : AutovalidateMode.disabled,
//       // inputFormatters: widget.format,
//       // keyboardType: widget.type,
//       obscureText: widget.boolean!,
//       onChanged: (e) {
//         !submit;
//       },
//       validator: widget.valid,
//     );
//   }
// }

// Widget textField1({
//   required String? Function(String?)? onChange,
//   required String lable,
//   required TextInputType type,
//   required TextInputFormatter format,
//   Widget? icon,
// }) {
//   return SizedBox(
//     width: 120,
//     child: TextFormField(
//       inputFormatters: [format],
//       keyboardType: type,
//       onChanged: onChange,
//       cursorColor: Colors.black,
//       style: const TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         hintText: lable,
//         focusedBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.black,
//           ),
//         ),
//         enabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.black,
//           ),
//         ),
//         focusedErrorBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.black,
//           ),
//         ),
//         errorStyle: const TextStyle(
//           color: Colors.black,
//         ),
//         contentPadding: const EdgeInsets.symmetric(vertical: 18.5),
//         hintStyle: const TextStyle(
//           fontSize: 15,
//           color: Colors.black,
//         ),
//         border: const UnderlineInputBorder(),
//         isDense: true,
//         suffixIcon: icon,
//       ),
//     ),
//   );
// }
