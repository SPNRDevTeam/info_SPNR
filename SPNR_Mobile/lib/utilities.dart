// utility functions

import 'package:flutter/material.dart';

dynamic displayImage(dynamic item) { // displays image for any item with imgPath property
  if (item.imgPath.isNotEmpty) {
    print('displayed an image');
    return Image.network('http://localhost:5150/media/${item.imgPath.replaceAll('\\', '/').split('/')[2]}', fit: BoxFit.fitHeight,); // displays an image
  } else {
    print('image fetch failure');
  }
}