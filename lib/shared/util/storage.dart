import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/shared/util/avatar_data.dart';

class Storage {
  static Future<AvatarData?> getURL(
      {required File selectedFile,
      required UserEntity userEntity,
      required String path}) async {
    final uuid = const Uuid().v4();
    UploadTask? uploadTask;
    String fileName = uuid;
    try {
      final file = File(selectedFile.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child(path)
          .child(userEntity.userID!)
          .child(fileName);
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      return AvatarData(avatarURL: urlDownload, avatarURLName: fileName);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
