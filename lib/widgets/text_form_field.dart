import 'package:flutter/material.dart';
import 'package:shoppy/my_colors.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPassWord;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const TextFormFieldWidget({
    super.key,
    this.onChanged,
    required this.icon,
    required this.label,
    required this.isPassWord,
    this.validator,
    this.keyboardType,
    required this.controller,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassWord;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: Color(0xff19183B),
        ),
        hintText: 'Enter your ${widget.label}',
        hintStyle: TextStyle(color: MyColors.primaryColor),
        prefixIcon: Icon(widget.icon, color: Theme.of(context).primaryColor),
        suffixIcon: widget.isPassWord
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: MyColors.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: MyColors.mainColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 16.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11.0),
          borderSide: BorderSide(color: MyColors.primaryColor),
        ),
        focusedBorder: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: MyColors.secondaryColor),
        ),
      ),
      style: const TextStyle(fontSize: 16.0),
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: obscureText,
      controller: widget.controller,
      onChanged: widget.onChanged,
    );
  }
}
