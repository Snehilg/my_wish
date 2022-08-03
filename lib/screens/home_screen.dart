import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wish/controllers/home_controller.dart';
import 'package:my_wish/utils.dart';

class HomeScreen extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());

  buildTab(text, selected, context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 45,
      child: Center(
        child: Text(
          text,
          style: selected
              ? textStyle(22, Colors.blue, FontWeight.bold)
              : textStyle(22, Colors.black, FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            //top row for heading and count of wishes
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 60, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "WishList",
                    style: textStyle(25, Colors.black, FontWeight.w600),
                  ),
                  Container(
                    width: 40,
                    height: 45,
                    decoration: const BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        "10",
                        style: textStyle(25, Colors.white, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Row(
                children: [
                  InkWell(
                    onTap: () => homeController.changeTab("Wishes"),
                    child: buildTab("Wishes",
                        homeController.tab.value == "Wishes", context),
                  ),
                  InkWell(
                    onTap: () => homeController.changeTab("Fulfilled"),
                    child: buildTab("Fulfilled",
                        homeController.tab.value == "Fulfilled", context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
