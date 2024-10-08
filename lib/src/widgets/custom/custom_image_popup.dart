  import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:info91/src/widgets/custom/string_extensions.dart';

Widget imageDialog(text, path, context) {
    return Dialog(
      // backgroundColor: Colors.transparent,
      // elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  child: Center(
                    child: Text(
                      '${text.toString().toTitleCase()}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, right: 8.0, left: 8.0, bottom: 25),
            child: Container(
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.height / 3,
              child: path == ""
                  ? TextAvatar(
                      shape: Shape.Circular,
                      size: 20,
                      numberLetters: 2,
                      fontSize: MediaQuery.of(context).size.width / 5,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w500,
                      text: "${text.toString().toUpperCase()}",
                    )
                  : Image.network(
                      '$path',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ],
      ),
    );
  }
