import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
import 'package:vhack_client/features/crop/domain/repositories/crop_repo.dart';

class GetCropsUC {
  final CropRepo cropRepo;

  GetCropsUC({required this.cropRepo});

  Future<Either<String, List<CropEntity>>> call() {
    return cropRepo.getCrops();
  }
}
