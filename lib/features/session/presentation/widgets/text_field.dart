import 'package:flutter/material.dart';

Padding textFieldForm(
    IconData icon, String label, TextEditingController fieldContoller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  // offset: const Offset(0, 3)
                ),
              ],
            ),
            child: TextField(
              controller: fieldContoller,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: const Color(0xffE1CACD),
                ),
                hintText: label,
                hintStyle: const TextStyle(
                  color: Color(0xffE1CACD),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
