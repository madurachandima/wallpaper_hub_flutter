import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_hub/toast_message/toast.dart';

// ignore: must_be_immutable
class ImageView extends StatelessWidget {
  String? imageUrl;
  String? id;
  ImageView({Key? key, @required this.imageUrl, @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> askPermission() async {
      if (!await Permission.storage.isGranted) {
        PermissionStatus statusStorage = await Permission.storage.request();

        if (statusStorage.isGranted)
          return true;
        else
          return false;
      }
      return true;
    }

    saveImage() async {
      if (await askPermission()) {
        var response = await Dio().get(imageUrl.toString(),
            options: Options(responseType: ResponseType.bytes));
        var result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
            name: id);

        if (result['isSuccess']) {
          toastSuccesMessage("Image saved in gallery");
          Navigator.pop(context);
        } else {
          toastErrorMessage("Image save fail");
        }
      } else {
        toastErrorMessage("Please grante the requred permission");
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Hero(
              tag: imageUrl.toString(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(imageUrl.toString(), fit: BoxFit.cover),
              )),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: saveImage,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff1C1B1B).withOpacity(0.8),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white54, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Color(0x36FFFFFF),
                              Color(0x0FFFFFFF)
                            ])),
                        child: Column(
                          children: [
                            Text("Set Wallpaper"),
                            Text(
                              "Image will be saved in gallery",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white70),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
