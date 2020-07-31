
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate_app/Api/upload_image.dart';
import 'package:real_estate_app/model/photos_model.dart';
import 'package:real_estate_app/widget/constant.dart';

class ListImage extends StatefulWidget {
  List<String>propertyImages;
  ListImage({this.propertyImages});
  @override
  State<StatefulWidget> createState() {
    return _ListImage();
  }
}

class _ListImage extends State<ListImage> {
  bool isUploadImage;
  File image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return (index == widget.propertyImages.length)
              ? addNewImagePicture((widget.propertyImages.length==0?"اضف صورة رئيسية":"اضف صورة فرعية"))
              : showUploadedPhotos(index);
        },
        itemCount: widget.propertyImages.length + 1,
      ),
    );
  }
  Future getImageFileFromGallery() async {
    File imageFile;
    try {
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print("error Happened");
    }

    if (imageFile != null) {
      setState(() {
        isUploadImage = true;
      });
    }

    if (imageFile != null)
      setState(() {
        image = imageFile;
        isUploadImage = true;
      });
    if (image != null)
      UploadImageModel.uploadImageCreateActivity(imageFile,
          imageType: "property")
          .then((response) {
        response.stream.transform(utf8.decoder).listen((value) {
          print("updateImageApi::: $value");
          PhotosModel updateImageApi = photosModelFromJson(value);
          print("path::: ${updateImageApi.data}");
          if (updateImageApi.status == "OK") {
            setState(() {
              isUploadImage = false;
              widget.propertyImages.add(updateImageApi.data);
            });
          }
          setState(() {
            isUploadImage = false;
          });
        });
      });
  }

//isUploadImage
  Widget addNewImagePicture(String title) {
    return Container(
      height: 150,
      width: 140,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              getImageFileFromGallery();
            },
            child: Container(
              height: 150,
              width: 140,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  color: Colors.white.withOpacity(0.4),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(title),
                    ),
                  ),
                ),
              ),
            ),
          ),
          (isUploadImage == true)
              ? Align(
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          )
              : Container()
        ],
      ),
    );
  }

  Widget showUploadedPhotos(int index) {
    print("the value for image :: ${widget.propertyImages[index]}");
    return Container(
      height: 150,
      width: 140,
      child: Card(
          elevation: 4,
          color: Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: <Widget>[
              Container(
                height: 150,
                width: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: Constant.baseUrl + widget.propertyImages[index],
                    fit: BoxFit.fill,
                    placeholder: (context, imageUrl) => Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor:
                          new AlwaysStoppedAnimation<Color>(Color(0xff0E4BEF)),
                        )),
                    errorWidget: (context, imageUrl, error) => SvgPicture.asset(
                      'svgFile/oraganazation1.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.propertyImages.removeAt(index);
                  });
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 12,
                      child: Icon(Icons.clear),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

}
