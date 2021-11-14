import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function(String)? onChange;
  final Function()? onEditingComplete;
  final Function()? onClean;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  const SearchWidget({
    Key? key,
    this.onChange,
    this.initialValue,
    this.onEditingComplete,
    this.onClean,
    this.hintText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: TextField(
        onChanged: onChange,
        onEditingComplete: onEditingComplete,
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(
              Icons.search,
              size: 18,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear,
                size: 18,
              ),
              onPressed: onClean,
            ),
            hintText: hintText ?? "",
            contentPadding: const EdgeInsets.all(15)),
      ),
    );
  }
}
