import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool obscureText;
  final hintText;
  const TextFieldWidget(
      {Key? key,
      required this.title,
      required this.controller,
      required this.obscureText,
      required this.hintText})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late FocusNode focusNode;
  bool isinFocus = false;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isinFocus = true;
        });
      } else {
        isinFocus = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            isinFocus
                ? BoxShadow(
                    color: Colors.orange.withOpacity(0.6),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                : BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
          ]),
          child: TextField(
            maxLines: 1,
            obscureText: widget.obscureText,
            controller: widget.controller,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: widget.hintText,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 1))),
          ),
        )
      ],
    );
  }
}
