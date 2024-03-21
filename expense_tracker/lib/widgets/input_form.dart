import 'package:flutter/material.dart';

Widget customSizedBoxFormField({
  TextEditingController? controller,
  String? hintText,
  IconData? icon,
  double? height,
}) {
  return SizedBox(
    height: height,
    width: double.infinity,
    child: TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon:
            icon != null ? Icon(icon, size: 20, color: Colors.grey) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
