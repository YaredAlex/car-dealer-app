import 'dart:io';

import 'package:flutter/material.dart';

ImageProvider resolveImage(String path) {
  if (path.startsWith('http')) {
    return NetworkImage(path);
  } else if (path.startsWith('/')) {
    return FileImage(File(path));
  } else {
    return AssetImage(path);
  }
}
