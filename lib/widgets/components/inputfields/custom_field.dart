import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Color labelColor;
  final String placeholder;
  final bool isPassword;
  final bool isError;
  final bool isNumeric;
  final Function onTextChanged;
  final IconData leadingIcon;
  final bool needLeadingIcon;
  final bool boarderNeeded;
  final List<TextInputFormatter>? inputFormatters;
  final dynamic dropdownButton;
  final Function? onTap;
  final FocusNode? inputFocus;
  final ValueChanged<String>? onSubmit;
  final IconButton? suffixIcon;
  final bool isSuffixIconNeeded;
  final double height;
  final Color textColor; // Added textColor property

  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.labelColor,
    required this.placeholder,
    required this.height,
    this.isPassword = false,
    this.isError = false,
    this.isNumeric = false,
    required this.onTextChanged,
    this.leadingIcon = Icons.search,
    this.boarderNeeded = true,
    this.needLeadingIcon = false,
    this.inputFormatters,
    this.dropdownButton,
    this.onTap,
    this.inputFocus,
    this.onSubmit,
    this.suffixIcon,
    this.isSuffixIconNeeded = false,
    required this.textColor,
    required bool obscureText,
    required bool readOnly, // Initialize textColor property
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;
  dynamic dropDownButton;
  FocusNode customeCreated = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Text(
            widget.label,
            style: tTextStyle600.copyWith(
              color: widget.labelColor,
              fontSize: size.width*0.04,
            ),
          ),
        const SizedBox(height: 3),
        SizedBox(
          height: widget.height,
          width: double.infinity,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            focusNode: widget.inputFocus ?? customeCreated,
            onChanged: (str) {
              widget.onTextChanged(str);
            },
            onSubmitted:
                widget.onSubmit ??
                (String value) {
                  print('Submitted: $value');
                },
            obscuringCharacter: '*',
            cursorColor: Colors.black,
            style: tTextStyleRegular.copyWith(
              fontSize: size.width*0.04,
              color: widget.textColor,
            ), // Apply textColor here
            controller: widget.controller,
            obscureText: widget.isPassword && _obscureText,
            keyboardType:
                widget.isNumeric ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              prefixIcon:
                  widget.needLeadingIcon ? Icon(widget.leadingIcon) : null,
              prefixIconColor:
                  widget.needLeadingIcon
                      ? ColorPack.iconGrey
                      : ColorPack.grayBorder,
              filled:
                  false, // Set filled to false to make the inside transparent
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: ColorPack.darkGray, // Set border color
                  width: 1.5,
                ),
              ),
              focusColor: ColorPack.black,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: ColorPack.darkGray,
                ), // Set border color
              ),
              hintText: widget.placeholder,
              hintStyle: hintTextStyle.copyWith(
                color: widget.isError ? Colors.red : ColorPack.black, fontSize: size.width*0.03
              ),
              suffixIcon:
                  widget.isPassword || widget.suffixIcon != null
                      ? (widget.suffixIcon ??
                          IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color:
                                  Colors
                                      .grey, // Changed the color to gray for better visibility
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ))
                      : null,
              border: InputBorder.none,
            ),
            inputFormatters: widget.inputFormatters,
          ),
        ),
      ],
    );
  }
}
