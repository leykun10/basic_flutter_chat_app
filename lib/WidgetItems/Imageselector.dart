import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class ImageProfile extends StatefulWidget {
  Function imageSetter;
  ImageProfile(this.imageSetter);
  @override
  _ImageProfileState createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {


  File image;
  ImagePicker picker=ImagePicker();
  imageSelect() async{
    PickedFile pickedImage=await picker.getImage(source: ImageSource.camera,
    imageQuality: 50,
    maxWidth: 150);
    setState(() {
      image=File(pickedImage.path);
    });
    widget.imageSetter(image);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: imageSelect,
      child: Stack(
        children: [
          CircleAvatar(radius: 40,backgroundImage: image==null?null:FileImage(image),),
          if(image==null)
          Positioned(
              left: 11,
              child: Icon(Icons.perm_identity,size: 60,color: Colors.white,)),
          if(image==null)
          Positioned(
              top: 50,
              left: 26,
              child: Icon(Icons.add,color: Colors.white,size: 26,)),

        ],
      ),
    );
  }
}
