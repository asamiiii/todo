import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget FlotingButton ({
  required String hero,
  required Function stat,
  required Widget icon})
{
  return FloatingActionButton(
    heroTag: hero,
    onPressed: (){
      stat();
    },

    child: icon,
  );
}

Widget defultTextfeild ({
  required TextEditingController mailController,
  required String label,
  required Icon iconfeild,
  TextInputType? type,

  required VoidCallback  tapon ,
  Widget? iconsuffix ,
  bool secureText = false ,
  bool showCursor = false ,
  bool readOnly = false,




})=>TextFormField(
  obscureText: secureText,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    },
    controller: mailController,
    showCursor: showCursor,
    readOnly: readOnly,
    onTap: tapon,
    keyboardType: type,
    style: const TextStyle(fontWeight: FontWeight.bold),
    decoration:InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),

      labelText: label,
      prefixIcon: iconfeild,
      suffixIcon: iconsuffix,




    ) );



