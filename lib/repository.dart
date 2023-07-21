import 'dart:typed_data';

import 'package:ar_outdoor_furniture/global.dart';
import 'package:ar_outdoor_furniture/model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<Uint8List> removeBG(String imagepath) async {
    var requestapi = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.remove.bg/v1.0/removebg'),
    );

    requestapi.files.add(await http.MultipartFile.fromPath("image_file", imagepath));

    requestapi.headers.addAll({"X-API-Key": apikeyRemoveBG});

    var responseFromApi = await requestapi.send();

    if (responseFromApi.statusCode == 200) {
      http.Response getTransparentImage = await http.Response.fromStream(responseFromApi);
      return getTransparentImage.bodyBytes;
    } else {
      throw Exception('Error occured:: ' + responseFromApi.statusCode.toString());
    }
  }

  showsnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<String> storeFileToFirebase(
    String ref,
    String itemId, {
    Uint8List? image,
  }) async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    UploadTask uploadTask;
    String? downloadUrl;

    try {
      uploadTask = firebaseStorage.ref().child(ref).child(itemId).putData(image!, SettableMetadata(contentType: 'image/png'));

      TaskSnapshot snap = await uploadTask;

      downloadUrl = await snap.ref.getDownloadURL();
    } on FirebaseException catch (fe) {
      print(fe);
    } catch (e) {
      print(e);
    }
    return downloadUrl!;
  }

  Future<List<ItemModel>> getAndLoadItems() async {
    //INIT MODEL
    ItemModel itemsModel;
//INIT LIST
    List<ItemModel> itemsList = [];
    //GET REF
    await FirebaseFirestore.instance
        .collection('items')
        //GET DOCS
        .get()
        .then((snapshot) {
      //SAVE TO LIST
      snapshot.docs.forEach((document) {
        itemsModel = ItemModel.fromMap(document.data());
        //user2 = User.fromMap(document.data).AuthUserID;

        itemsList.add(itemsModel);
      });
    });

    //SAVE TO NOTIFIER
    return itemsList;
  }

  Future uploadItem(String itemID, String? sellerName, String? sellerPhoneNum, String? itemName, String? itemDesc, double? itemprice,
      String imageUrl) async {
    ItemModel? itemModel;
    String res = 'Error';

    ///Set model
    itemModel = ItemModel(
        itemID: itemID,
        itemDesc: itemDesc,
        itemName: itemName,
        itemprice: itemprice,
        itemUrl: imageUrl,
        publisheddate: Timestamp.fromDate(DateTime.now()),
        sellerName: sellerName,
        sellerPhoneNum: sellerPhoneNum,
        status: 'Available');

    CollectionReference Ref = FirebaseFirestore.instance.collection('items');

    await Ref.doc(itemID).set(itemModel.toMap()).then((value) => res = '200');

    return res;
  }
}
