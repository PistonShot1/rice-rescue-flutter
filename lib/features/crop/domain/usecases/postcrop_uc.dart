import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
import 'package:vhack_client/features/crop/domain/repositories/crop_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class PostCropUC {
  final CropRepo cropRepo;

  PostCropUC({required this.cropRepo});

  Future<Either<String, ResponseData>> call(CropEntity cropEntity) {
    return cropRepo.postCrop(cropEntity);
  }
}
