import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RadiusTextFormField extends StatelessWidget {
  final String? hintText;
  final Icon? icon;
  TextEditingController? textEditingController;
  final FormFieldValidator<String>? validator;
  final bool obsecureText;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final bool iconInfoisValid;
  final EdgeInsetsGeometry padding;
  RadiusTextFormField(
      {Key? key,
      required this.hintText,
      required this.icon,
      this.textEditingController,
      this.validator,
      this.obsecureText = false,
      this.onTap,
      this.keyboardType,
      required this.iconInfoisValid,
      required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.0),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            0,
          ),
        ),
      ),
      child: Padding(
        padding: padding,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          onTap: onTap,
          obscureText: obsecureText,
          validator: validator,
          controller: textEditingController,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixIcon: icon,
            hintText: hintText,
            labelText: hintText,
            border: InputBorder.none,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
