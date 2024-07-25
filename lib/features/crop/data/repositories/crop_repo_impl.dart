import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/crop/data/database/crop_remote_database.dart';
import 'package:vhack_client/features/crop/data/model/crop_model.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
import 'package:vhack_client/features/crop/domain/repositories/crop_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class CropRepoImpl implements CropRepo {
  final CropRemoteDatabase cropRemoteDatabase;

  CropRepoImpl({required this.cropRemoteDatabase});
  @override
  Future<Either<String, ResponseData>> deleteCrop(CropEntity cropEntity) async {
    try {
      return Right(await cropRemoteDatabase
          .deleteCrop(CropModel.fromEntity(cropEntity)));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CropEntity>>> getCrops() async {
    try {
      final crops = await cropRemoteDatabase.getCrops();
      final listCrops = crops.map((e) => e.toEntity()).toList();
      return Right(listCrops);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ResponseData>> postCrop(CropEntity cropEntity) async {
    try {
      return Right(
          await cropRemoteDatabase.postCrop(CropModel.fromEntity(cropEntity)));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
