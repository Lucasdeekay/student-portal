import 'package:flutter/material.dart';

Widget buildInputField({
  required String labelText,
  required IconData icon,
  required bool isDateField,
  BuildContext? context,
  TextEditingController? controller,
  bool isObscure = false,
  FormFieldValidator<String>? validator,
  Color? color,
  DropdownButtonFormField<String>? inputField, // Add an optional color parameter
}) {
  const defaultColor = Colors.white; // Default text color

  if (inputField != null) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: inputField,
    );
  } else {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          icon: Icon(icon, color: color ?? defaultColor), // Use the color parameter or the default color
          labelStyle: TextStyle(
            color: color ?? defaultColor, // Use the color parameter or the default color
            fontSize: 12.0,
          ),
        ),
        style: TextStyle(color: color ?? defaultColor), // Use the color parameter or the default color
        obscureText: isObscure,
      ),
    );
  }
}
