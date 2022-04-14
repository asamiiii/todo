import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';

Widget FlotingButton(
    {required String hero, required Function stat, required Widget icon}) {
  return FloatingActionButton(
    heroTag: hero,
    onPressed: () {
      stat();
    },
    child: icon,
  );
}

Widget defultTextfeild({
  required TextEditingController tfController,
  required String label,
  required Icon iconfeild,
  TextInputType? type,
  required VoidCallback tapon,
  Widget? iconsuffix,
  bool secureText = false,
  bool showCursor = true,
  bool readOnly = false,
}) =>
    TextFormField(
        obscureText: secureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        controller: tfController,
        showCursor: showCursor,
        readOnly: readOnly,
        onTap: tapon,
        keyboardType: type,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: label,
          prefixIcon: iconfeild,
          suffixIcon: iconsuffix,
        ));

Widget Deviders() {
  return Container(
    height: 1,
    width: double.infinity,
    color: Colors.blueGrey,
  );
}

Widget ListsOfTAsks(var model, BuildContext context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteFromDatabase(model['id']);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 130,
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 40,
              child: (Text(
                model['time'],
                style: const TextStyle(
                    fontSize: 15, overflow: TextOverflow.ellipsis),
              )),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model['title'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  model['date'],
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  AppCubit.get(context).updateDatabase("done", model['id']);
                },
                icon: const Icon(
                  Icons.domain_verification,
                  size: 30,
                  color: Colors.green,
                )),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  AppCubit.get(context).updateDatabase("archive", model['id']);
                },
                icon: const Icon(
                  Icons.archive_outlined,
                  size: 30,
                  color: Colors.grey,
                )),
          ),
        ],
      ),
    );
