import 'dart:typed_data';

import 'package:ar_outdoor_furniture/presentation/home_page.dart';
import 'package:ar_outdoor_furniture/repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  //upload form screen
  final _formkey = GlobalKey<FormState>();
  Uint8List? imagefileUint8List;
  bool isUploading = false;

  TextEditingController sellernameController = TextEditingController();
  TextEditingController sellerPhoneController = TextEditingController();
  TextEditingController itemnameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();

  String? sellerName;
  String? sellerPhoneNum;
  String? itemName;
  String? itemDesc;
  double? itemprice;

  @override
  initState() {
    super.initState();
  }

  captureImageandRemoveBG(ImageSource imageSource) async {
    Navigator.pop(context);
    try {
      final pickedImage = await ImagePicker().pickImage(source: imageSource);

      if (pickedImage != null) {
        String imagepath = pickedImage.path;
        //imagefileUint8List = await pickedImage.readAsBytes();

        imagefileUint8List = await Repository().removeBG(imagepath);

        setState(() {
          imagefileUint8List;
        });
      }
    } catch (e) {
      setState(() {
        imagefileUint8List = null;
      });
      print(e);
    }
  }

  void ValidateAndUpload(BuildContext context) async {
    ///CHECK IF FIELDS ARE VALID
    String imageUrl;
    final isValid = _formkey.currentState?.validate() ?? false;
    print(isValid);

    ///AND IF THEY ARE
    if (isValid) {
      ///RUN THE ONSAVED FUNCTIONS IN THE TEXTFORMFIELD
      _formkey.currentState!.save();

      if (imagefileUint8List != null) {
        setState(() {
          isUploading = true;
        });

        ///Upload and get url
        String itemID = DateTime.now().millisecondsSinceEpoch.toString();
        imageUrl = await Repository().storeFileToFirebase('item images', itemID, image: imagefileUint8List);

        /// AND NOW UPLOAD
        String res = await Repository().uploadItem(itemID, sellerName!, sellerPhoneNum!, itemName, itemDesc, itemprice, imageUrl);

        if (res == '200') {
          Repository().showsnackbar(context, 'Item uploaded successfully');
        } else {
          Repository().showsnackbar(context, 'There seems to be a problem uploading that item');
        }
      }
    } else {
      Repository().showsnackbar(context, 'Fields cannot be empty');
    }
    setState(() {
      isUploading = false;
      imagefileUint8List = null;
    });

    Navigator.push(context, MaterialPageRoute(builder: (_) => Home_page()));
  }

  // chooseImageFromGallery() async {
  //   try {
  //     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //     if (pickedImage != null) {
  //       String imagepath = pickedImage.path;
  //       //imagefileUint8List = await pickedImage.readAsBytes();
  //
  //       imagefileUint8List = await ApiConsumer().removeBG(imagepath);
  //
  //       setState(() {
  //         imagefileUint8List;
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       imagefileUint8List = null;
  //     });
  //     print(e);
  //   }
  // }

  showDialogbox() {
    return showDialog(
        context: context,
        builder: (c) {
          return SimpleDialog(
            backgroundColor: Colors.grey,
            title: const Text(
              'Choose an option',
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(10),
                onPressed: () async {
                  await captureImageandRemoveBG(ImageSource.camera);
                },
                child: const Text(
                  'Take photo',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(10),
                onPressed: () async {
                  await captureImageandRemoveBG(ImageSource.gallery);
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(10),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return imagefileUint8List == null ? defaultScreen() : uploadFormScreen(context);
  }

  Widget uploadFormScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload new item'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
                onPressed: () {
                  if (isUploading != true) {
                    ValidateAndUpload(context);
                  }
                },
                icon: const Icon(Icons.cloud_upload)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  isUploading == true
                      ? const LinearProgressIndicator(
                          color: Colors.tealAccent,
                        )
                      : Container(),
                  SizedBox(
                    height: 230,
                    width: MediaQuery.of(context).size.width * .8,
                    child: Center(
                      child: imagefileUint8List != null
                          ? Image.memory(imagefileUint8List!)
                          : const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 40,
                            ),
                    ),
                  ),
                  const Divider(
                    color: Colors.teal,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person_pin_rounded,
                      color: Colors.grey,
                    ),
                    title: SizedBox(
                        width: 250,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.grey),
                          controller: sellernameController,
                          validator: (value) {
                            if (value!.isEmpty) return "Empty";
                          },
                          decoration: const InputDecoration(
                              hintText: 'Seller Name', hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
                          onSaved: (value) {
                            ///PASS VALUES TO ABOVE CREATED VARIABLES
                            sellerName = value!;
                          },
                        )),
                  ),
                  const Divider(
                    color: Colors.teal,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.phone_iphone_rounded,
                      color: Colors.grey,
                    ),
                    title: SizedBox(
                        width: 250,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) return "Empty";
                          },
                          style: const TextStyle(color: Colors.grey),
                          controller: sellerPhoneController,
                          decoration: const InputDecoration(
                              hintText: 'Seller Phone', hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
                          onSaved: (value) {
                            ///PASS VALUES TO ABOVE CREATED VARIABLES
                            sellerPhoneNum = value;
                          },
                        )),
                  ),
                  const Divider(
                    color: Colors.teal,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.title,
                      color: Colors.grey,
                    ),
                    title: SizedBox(
                        width: 250,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) return "Empty";
                          },
                          style: const TextStyle(color: Colors.grey),
                          controller: itemnameController,
                          decoration: const InputDecoration(
                              hintText: 'Item name', hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
                          onSaved: (value) {
                            ///PASS VALUES TO ABOVE CREATED VARIABLES
                            itemName = value;
                          },
                        )),
                  ),
                  const Divider(
                    color: Colors.teal,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.description,
                      color: Colors.grey,
                    ),
                    title: SizedBox(
                        width: 250,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) return "Empty";
                          },
                          style: const TextStyle(color: Colors.grey),
                          controller: itemDescriptionController,
                          decoration: const InputDecoration(
                              hintText: 'Item description', hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
                          onSaved: (value) {
                            ///PASS VALUES TO ABOVE CREATED VARIABLES
                            //if(value!.isNotEmpty){
                            itemDesc = value;
                            // }
                          },
                        )),
                  ),
                  const Divider(
                    color: Colors.teal,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.price_change,
                      color: Colors.grey,
                    ),
                    title: SizedBox(
                        width: 250,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) return "Empty";
                          },
                          style: const TextStyle(color: Colors.grey),
                          controller: itemPriceController,
                          decoration: const InputDecoration(
                              hintText: 'Item price', hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
                          onSaved: (value) {
                            ///PASS VALUES TO ABOVE CREATED VARIABLES
                            itemprice = double.parse(value!);
                          },
                        )),
                  ),
                  const Divider(
                    color: Colors.teal,
                    thickness: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload new item',
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.add_photo_alternate,
            color: Colors.grey,
            size: 200,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () {
                showDialogbox();
              },
              child: const Text('Add new item'))
        ]),
      ),
    );
  }
}
