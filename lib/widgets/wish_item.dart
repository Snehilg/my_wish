import 'package:my_wish/models/wish_model.dart';
import 'package:my_wish/utils.dart';
import 'package:flutter/material.dart';
import 'package:my_wish/controllers/home_controller.dart';
import 'package:get/get.dart';

class WishItem extends StatelessWidget {
  HomeController homeController = Get.find<HomeController>();

  final Wish wish;
  //constructor initialize the wish
  WishItem(this.wish);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Image(
          width: 64,
          fit: BoxFit.scaleDown,
          image: NetworkImage(wish.image),
        ),
        title: Text(
          wish.wish,
          style: textStyle(18, Colors.black, FontWeight.w700),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            //string interpolation
            "\₹ ${wish.price}",
            style: textStyle(16, Colors.grey, FontWeight.w600),
          ),
        ),
        trailing: Checkbox(
          value: wish.fulfilled,
          onChanged: (value) => homeController.fulfilledWish(value, wish.id),
        ),
      ),
    );
  }
}
