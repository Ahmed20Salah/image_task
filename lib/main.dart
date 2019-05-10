import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    // for getting image from link
    Image image = Image.network(
      'https://halaqat.net/quran/hafs/images/5.png',
      // to resize image as we used it in a list view .... in list view or column
      // the children take the max width
      height: MediaQuery.of(context).size.height - 100,
    );
    Completer<ui.Image> completer = Completer<ui.Image>();
    // catch the image data
    image.image.resolve(ImageConfiguration()).addListener(
        (ImageInfo info, bool _) =>
            // saving image data in completer
            completer.complete(info.image));
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Ratio"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // cause we waiting for a data from server
          FutureBuilder<ui.Image>(
            future: completer.future,
            builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
              if (snapshot.hasData) {
                return Text(
                  '${snapshot.data.width}x${snapshot.data.height}',
                  style: TextStyle(fontSize: 50 , fontWeight: FontWeight.bold) , textAlign: TextAlign.center,
                );
              } else {
                return Text('Loading...');
              }
            },
          ),
          SizedBox(height: 40.0,),
          image,
        ],
      ),
    );
  }
}
