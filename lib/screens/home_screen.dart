import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wish/controllers/home_controller.dart';
import 'package:my_wish/utils.dart';
import 'package:my_wish/widgets/wish_item.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();

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

  openAddWishSheet(context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        )),
        builder: (context) {
          return Obx(
            () => Padding(
              //paddinig is neccesary for uplifting the popup when keyboard comes out
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                //scroll view to make it scrolable when bottom keyboard pops up
                physics: const ScrollPhysics(),
                child: Container(
                  height: 250,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            homeController.selectedPicture.value == ""
                                ? InkWell(
                                    onTap: () => homeController.selectPicture(),
                                    child: const Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey,
                                      size: 45,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () => homeController.selectPicture(),
                                    child: Image(
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      image: FileImage(File(homeController
                                          .selectedPicture.value)),
                                    ),
                                  ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              margin:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: TextFormField(
                                controller: priceController,
                                style:
                                    textStyle(16, Colors.grey, FontWeight.w500),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[250],
                                  hintText: "Price",
                                  hintStyle: textStyle(
                                      16, Colors.grey, FontWeight.w500),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: titleController,
                            style: textStyle(16, Colors.grey, FontWeight.w500),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[250],
                              hintText: "Your Wish",
                              hintStyle:
                                  textStyle(16, Colors.grey, FontWeight.w500),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.lightBlue),
                            child: Text(
                              "Add to My List",
                              style:
                                  textStyle(20, Colors.white, FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddWishSheet(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Obx(
        () => SingleChildScrollView(
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
                      "Wish List",
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
              //for responsive wishes/fulfilled tab
              Row(
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

              //List view builder for list of wishes

              //build lists according to selected tab
              homeController.tab.value == "Wishes"
                  //for wishes tab
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return WishItem();
                      },
                    )
                  //for fulfilled tab
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return WishItem();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
