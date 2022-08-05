import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wish/models/wish_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_wish/utils.dart';

class HomeController extends GetxController {
  RxString tab = "Wishes".obs;
  RxString selectedPicture = "".obs;
  ImagePicker imagePicker = ImagePicker();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxList<Wish> wishes = <Wish>[].obs;
  RxList<Wish> fulfilledWishes = <Wish>[].obs;

  @override
  onInit() {
    super.onInit();
    getWishes();
  }

  //for wishes list
  getWishes() {
    //we use binding to bind the local things to something,notice changes to something and act accordingly
    wishes.bindStream(userCollection
        .doc(uid)
        .collection('wishes')
        .where('fulfilled', isEqualTo: false)
        .snapshots() //taking the snapshot according to rules
        .map((query) {
      List<Wish> wishes = [];
      List<QueryDocumentSnapshot<Object?>> docslist = query.docs;
      print("ye length wishes wale ke hai${docslist.length}");
      for (var element in docslist) {
        wishes.add(Wish.fromDocumentSnapshot(element));
      }
      return wishes;
    }));
  }

  //for fulfilled list
  getFulfilledWishes() {
    //we use binding to bind the local things to something,notice changes to something and act accordingly
    fulfilledWishes.bindStream(userCollection
        .doc(uid)
        .collection('wishes')
        .where('fulfilled', isEqualTo: true)
        .snapshots() //taking the snapshot according to rules
        .map((query) {
      List<Wish> wishes = [];
      List<QueryDocumentSnapshot<Object?>> docslist = query.docs;
      print("ye length fulfilled wale ke hai${docslist.length}");
      for (var element in docslist) {
        wishes.add(Wish.fromDocumentSnapshot(element));
      }
      return wishes;
    }));
  }

  changeTab(value) {
    tab.value = value;
    //we only wanna call it when
    if (value == "Fulfilled" && fulfilledWishes.firstRebuild) {
      getFulfilledWishes();
    }
  }

  //for changing status of wish
  fulfilledWish(wishStatus, wishId) async {
    await userCollection
        .doc(uid)
        .collection('wishes')
        .doc(wishId)
        .update({'fulfilled': wishStatus});
  }

  //image picking and path saving functionality
  selectPicture() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedPicture.value = pickedFile.path;
    }
  }

  Future addWish(wish, price) async {
    //getting length of user wishes table
    //we use await coz that function may/may not take time
    //using a table inside unique user..kyuki har user ke wish alag hogi
    //collection name is wishes
    // db->user(email,username)->wishes(wish related details)

    int length =
        await userCollection //location tak pahuchne ka code,dhyan se dekhe
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('wishes')
            .get()
            .then((value) => value.docs.length);

    //uploading the image in storage and getting its link to save in DB Collection
    //firebaseStorage->images->fileName->actual image
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('File $length')
        .putFile(File(selectedPicture.value));

    //getting snapshot then using that to get the link of that doc just uploaded in firebase DB
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    //now saving all data regarding wish in firebase collection
    await userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishes')
        .add({
      "wish": wish,
      "price": price,
      "image": imageUrl,
      "fulfilled": false,
      "wishedOn": DateTime.now()
    });
  }
}
