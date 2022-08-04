import 'dart:ffi';

import 'package:my_wish/utils.dart';
import 'package:flutter/material.dart';

class WishItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Image(
        width: 64,
        fit: BoxFit.fill,
        image: NetworkImage(
            "https://www.royalenfield.com/content/dam/royal-enfield/india/motorcycles/himalayan/colours/new-colors/studio-shots/mirage-silver/front-view.png"),
      ),
      title: Text(
        "Himalayan Bike",
        style: textStyle(18, Colors.black, FontWeight.w700),
      ),
      subtitle: Text(
        "3 Lakh ke hai",
        style: textStyle(16, Colors.grey, FontWeight.w600),
      ),
      trailing: Checkbox(
        value: false,
        onChanged: (value) {},
      ),
    );
  }
}
