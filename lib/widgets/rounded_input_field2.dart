import 'package:a1/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedInputField2 extends StatelessWidget {
  final String hintText;

  final ValueChanged<String> onChanged;
  final TextInputType text;
  final int uzunluk;
  final String veri;

  final bool gizli;
  const RoundedInputField2({
    Key key,
    this.hintText,
    this.onChanged,
    this.gizli = false,
    this.text = TextInputType.text,
    this.uzunluk,
    this.veri,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: text,
        maxLength: uzunluk,
        obscureText: gizli,
        onChanged: onChanged,
        cursorColor: Colors.white70,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: veri,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
