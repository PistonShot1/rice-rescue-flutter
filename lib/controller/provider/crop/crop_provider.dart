import 'package:flutter/material.dart';
import 'package:vhack_client/model/crop_entity.dart';

class CropProvider extends ChangeNotifier {
  final List<CropEntity> _crops = [
    CropEntity(
        cropID: '65a56e35a47c645d134cef17',
        cropLocalID: '65a56e35a47c645d134cef17',
        cropDisease: 'Bacterial Leaf Bright',
        cropURL:
            'https://firebasestorage.googleapis.com/v0/b/rice-rescue.appspot.com/o/crops%2Fca00fa0a-d4e4-4fcb-b711-fa72d2da3ac3e0e64885-6e2c-417f-b4f3-b128f4739b3f2637419288937488438.jpg?alt=media&token=5df5af73-4cb8-4add-80e2-f1423552eef6',
        cropAt: '2024-01-16T09:23:09.408276',
        cropFileName:
            'ca00fa0a-d4e4-4fcb-b711-fa72d2da3ac3e0e64885-6e2c-417f-b4f3-b128f4739b3f2637419288937488438.jpg',
        cropPrecaution: 'Monitor',
        cropNutrient: '0%',
        cropHealth: '60%'),
    CropEntity(
        cropID: '65a56e35a47c645d134cef17',
        cropLocalID: '65a56e35a47c645d134cef17',
        cropDisease: 'Bacterial Leaf Bright',
        cropURL:
            'https://firebasestorage.googleapis.com/v0/b/rice-rescue.appspot.com/o/crops%2Fca00fa0a-d4e4-4fcb-b711-fa72d2da3ac3e0e64885-6e2c-417f-b4f3-b128f4739b3f2637419288937488438.jpg?alt=media&token=5df5af73-4cb8-4add-80e2-f1423552eef6',
        cropAt: '2024-01-17T09:23:09.408276',
        cropFileName:
            'ca00fa0a-d4e4-4fcb-b711-fa72d2da3ac3e0e64885-6e2c-417f-b4f3-b128f4739b3f2637419288937488438.jpg',
        cropPrecaution: 'Monitor',
        cropNutrient: '0%',
        cropHealth: '60%')
  ];
  List<CropEntity> get crops => _crops;
}
