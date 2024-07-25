import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

abstract class CropRepo {
  Future<Either<String, ResponseData>> postCrop(CropEntity cropEntity);
  Future<Either<String, ResponseData>> deleteCrop(CropEntity cropEntity);
  Future<Either<String, List<CropEntity>>> getCrops();
}
