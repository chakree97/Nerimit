import 'package:flutter/material.dart';
import 'package:movies/provider/providerimagepicker.dart';
import 'package:movies/widget/texttheme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddSlip extends StatelessWidget {
  const AddSlip({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slip payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextWhite("Please add your slip payment", 14),
            Expanded(
              child: SpaceGap(16, AxisType.vertical),
            ),
            MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_)=>AddImage())
              ],
              child: ImageUpload()
            ),
            Expanded(
              child: SpaceGap(16, AxisType.vertical),
            ),
            InkWell(
              child: Container(
                width: width,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xff33FFFF),
                      Color(0xff00ccff),
                    ]
                  )
                ),
                child: Center(
                  child: TextWhite("Confrim", 16)
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

class ImageUpload extends StatelessWidget {
  const ImageUpload({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        context.read<AddImage>().UpdateImage();
      },
      child: (context.watch<AddImage>().fileImage == null)?
      Container(
        width: width*0.6,
        height: width*0.6,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 4
          )
        ),
        child: Center(
          child: IconButton(
            onPressed: (){
              context.read<AddImage>().UpdateImage();
            }, 
            color: Colors.white,
            icon: const Icon(
              Icons.camera_alt_outlined
            )
          ),
        ),
      ):
      Container(
        child: Image.file(
          context.read<AddImage>().fileImage!,
          fit: BoxFit.cover,
        ),
      )
    );
  }
}