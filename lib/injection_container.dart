import 'package:get_it/get_it.dart';
import 'package:vhack_client/features/auth/domain/usecases/user/get_single_user_uc.dart';
import 'package:vhack_client/features/auth/domain/usecases/user/getusers_uc.dart';
import 'package:vhack_client/features/auth/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:vhack_client/features/auth/presentation/cubit/user/user_cubit.dart';
import 'package:vhack_client/features/crop/data/database/crop_remote_database.dart';
import 'package:vhack_client/features/crop/data/repositories/crop_repo_impl.dart';
import 'package:vhack_client/features/crop/domain/repositories/crop_repo.dart';
import 'package:vhack_client/features/crop/domain/usecases/deletecrop_uc.dart';
import 'package:vhack_client/features/crop/domain/usecases/getcrops_uc.dart';
import 'package:vhack_client/features/crop/domain/usecases/postcrop_uc.dart';
import 'package:vhack_client/features/crop/presentation/cubit/crop/crop_cubit.dart';
import 'package:vhack_client/features/field/data/database/field_remote_database.dart';
import 'package:vhack_client/features/field/data/repositories/field_repo_impl.dart';
import 'package:vhack_client/features/field/domain/repositories/field_repo.dart';
import 'package:vhack_client/features/field/domain/usecase/deletefield_uc.dart';
import 'package:vhack_client/features/field/domain/usecase/getfields_uc.dart';
import 'package:vhack_client/features/field/domain/usecase/getsinglefield_uc.dart';
import 'package:vhack_client/features/field/domain/usecase/postfield_uc.dart';
import 'package:vhack_client/features/field/presentation/cubit/field/field_cubit.dart';
import 'package:vhack_client/features/field/presentation/cubit/single_field/single_field_cubit.dart';
import 'package:vhack_client/features/job/data/database/job_remote_database.dart';
import 'package:vhack_client/features/job/data/repositories/job_repo_impl.dart';
import 'package:vhack_client/features/job/domain/repositories/job_repo.dart';
import 'package:vhack_client/features/job/domain/usecases/deletejob_uc.dart';
import 'package:vhack_client/features/job/domain/usecases/getjobs_uc.dart';
import 'package:vhack_client/features/job/domain/usecases/postjob_uc.dart';
import 'package:vhack_client/features/job/domain/usecases/singlejob_uc.dart';
import 'package:vhack_client/features/job/presentation/cubit/job/job_cubit.dart';
import 'package:vhack_client/features/job/presentation/cubit/single_job/single_job_cubit.dart';
import 'package:vhack_client/features/machine/data/database/machine_remote_database.dart';
import 'package:vhack_client/features/machine/data/repositories/machine_repo_impl.dart';
import 'package:vhack_client/features/machine/domain/repositories/machine_repo.dart';
import 'package:vhack_client/features/machine/domain/usecases/deletemachine_uc.dart';
import 'package:vhack_client/features/machine/domain/usecases/getmachines_uc.dart';
import 'package:vhack_client/features/machine/domain/usecases/postmachine_uc.dart';
import 'package:vhack_client/features/machine/domain/usecases/updatemachine_uc.dart';
import 'package:vhack_client/features/machine/presentation/cubit/machine/machine_cubit.dart';
import 'package:vhack_client/features/team/data/database/forum_remote_database.dart';
import 'package:vhack_client/features/team/data/database/team_remote_database.dart';
import 'package:vhack_client/features/team/data/repositories/forum_repo_impl.dart';
import 'package:vhack_client/features/team/data/repositories/team_repo_impl.dart';
import 'package:vhack_client/features/team/domain/repositories/forum_repo.dart';
import 'package:vhack_client/features/team/domain/repositories/team_repo.dart';
import 'package:vhack_client/features/team/domain/usecases/forum/deleteforum_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/forum/getforum_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/forum/postforum_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/team/deleteteam_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/team/getsingleteam_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/team/getteam_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/team/postteam_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/team/updateteam_uc.dart';
import 'package:vhack_client/features/team/presentation/cubit/forum/forum_cubit.dart';
import 'package:vhack_client/features/team/presentation/cubit/team/single_team/single_team_cubit.dart';
import 'package:vhack_client/features/team/presentation/cubit/team/team_cubit.dart';

import 'features/auth/data/database/user_remote_database.dart';
import 'features/auth/data/repositories/user_repo_impl.dart';
import 'features/auth/domain/repositories/user_repo.dart';
import 'features/auth/domain/usecases/auth/getuserdetail_uc.dart';
import 'features/auth/domain/usecases/credential/signin_uc.dart';
import 'features/auth/domain/usecases/credential/signout_uc.dart';
import 'features/auth/domain/usecases/credential/signup_uc.dart';
import 'features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'features/auth/presentation/cubit/credential/credential_cubit.dart';

final sl = GetIt.instance;
void init() {
  sl.registerFactory<CredentialCubit>(
      () => CredentialCubit(signInUC: sl.call(), signUpUC: sl.call()));
  sl.registerFactory<AuthCubit>(
      () => AuthCubit(getUserDetailUC: sl.call(), signOutUC: sl.call()));
  sl.registerFactory<UserCubit>(() => UserCubit(getUsersUC: sl.call()));
  sl.registerFactory<GetSingleUserCubit>(
      () => GetSingleUserCubit(getSingleUserUC: sl.call()));
  sl.registerFactory<FieldCubit>(() => FieldCubit(
      postFieldUC: sl.call(),
      deleteFieldUC: sl.call(),
      getFieldsdUC: sl.call()));
  sl.registerFactory<SingleFieldCubit>(() => SingleFieldCubit(
        getSingleFieldUC: sl.call(),
      ));
  sl.registerFactory<JobCubit>(() => JobCubit(
      postJobUC: sl.call(), deleteJobUC: sl.call(), getJobsUC: sl.call()));
  sl.registerFactory<SingleJobCubit>(() => SingleJobCubit(
        singleJobUC: sl.call(),
      ));
  sl.registerFactory<MachineCubit>(() => MachineCubit(
      postMachineUC: sl.call(),
      deleteMachineUC: sl.call(),
      getMachinesUC: sl.call(),
      updateMachineUC: sl.call()));
  sl.registerFactory<CropCubit>(() => CropCubit(
      postCropUC: sl.call(), deleteCropUC: sl.call(), getCropsUC: sl.call()));
  sl.registerFactory<ForumCubit>(() => ForumCubit(
      postForumUC: sl.call(), deleteForumUC: sl.call(), getForumUC: sl.call()));
  sl.registerFactory<TeamCubit>(() => TeamCubit(
      postTeamUC: sl.call(),
      deleteTeamUC: sl.call(),
      getTeamsUC: sl.call(),
      updateTeamUC: sl.call()));
  sl.registerFactory<SingleTeamCubit>(() => SingleTeamCubit(
        getSingleTeamUC: sl.call(),
      ));

  sl.registerLazySingleton<SignInUC>(() => SignInUC(userRepo: sl.call()));
  sl.registerLazySingleton<SignUpUC>(() => SignUpUC(userRepo: sl.call()));
  sl.registerLazySingleton<GetUserDetailUC>(
      () => GetUserDetailUC(userRepo: sl.call()));
  sl.registerLazySingleton<SignOutUC>(() => SignOutUC(userRepo: sl.call()));
  sl.registerLazySingleton<GetUsersUC>(() => GetUsersUC(userRepo: sl.call()));
  sl.registerLazySingleton<GetSingleUserUC>(
      () => GetSingleUserUC(userRepo: sl.call()));
  sl.registerLazySingleton<PostFieldUC>(
      () => PostFieldUC(fieldRepo: sl.call()));
  sl.registerLazySingleton<DeleteFieldUC>(
      () => DeleteFieldUC(fieldRepo: sl.call()));
  sl.registerLazySingleton<GetFieldsdUC>(
      () => GetFieldsdUC(fieldRepo: sl.call()));
  sl.registerLazySingleton<GetSingleFieldUC>(
      () => GetSingleFieldUC(fieldRepo: sl.call()));
  sl.registerLazySingleton<PostJobUC>(() => PostJobUC(jobRepo: sl.call()));
  sl.registerLazySingleton<DeleteJobUC>(() => DeleteJobUC(jobRepo: sl.call()));
  sl.registerLazySingleton<GetJobsUC>(() => GetJobsUC(jobRepo: sl.call()));
  sl.registerLazySingleton<SingleJobUC>(() => SingleJobUC(jobRepo: sl.call()));
  sl.registerLazySingleton<PostMachineUC>(
      () => PostMachineUC(machineRepo: sl.call()));
  sl.registerLazySingleton<DeleteMachineUC>(
      () => DeleteMachineUC(machineRepo: sl.call()));
  sl.registerLazySingleton<GetMachinesUC>(
      () => GetMachinesUC(machineRepo: sl.call()));
  sl.registerLazySingleton<UpdateMachineUC>(
      () => UpdateMachineUC(machineRepo: sl.call()));
  sl.registerLazySingleton<PostCropUC>(() => PostCropUC(cropRepo: sl.call()));
  sl.registerLazySingleton<DeleteCropUC>(
      () => DeleteCropUC(cropRepo: sl.call()));
  sl.registerLazySingleton<GetCropsUC>(() => GetCropsUC(cropRepo: sl.call()));
  sl.registerLazySingleton<PostForumUC>(
      () => PostForumUC(forumRepo: sl.call()));
  sl.registerLazySingleton<DeleteForumUC>(
      () => DeleteForumUC(forumRepo: sl.call()));
  sl.registerLazySingleton<GetForumUC>(() => GetForumUC(forumRepo: sl.call()));
  sl.registerLazySingleton<PostTeamUC>(() => PostTeamUC(teamRepo: sl.call()));
  sl.registerLazySingleton<DeleteTeamUC>(
      () => DeleteTeamUC(teamRepo: sl.call()));
  sl.registerLazySingleton<GetTeamsUC>(() => GetTeamsUC(teamRepo: sl.call()));
  sl.registerLazySingleton<UpdateTeamUC>(
      () => UpdateTeamUC(teamRepo: sl.call()));
  sl.registerLazySingleton<GetSingleTeamUC>(
      () => GetSingleTeamUC(teamRepo: sl.call()));

  sl.registerLazySingleton<UserRepo>(
      () => UserRepoImpl(userRemoteDatabase: sl.call()));
  sl.registerLazySingleton<UserRemoteDatabase>(() => UserRemoteDatabaseImpl());
  sl.registerLazySingleton<FieldRepo>(
      () => FieldRepoImpl(fieldRemoteDatabase: sl.call()));
  sl.registerLazySingleton<FieldRemoteDatabase>(
      () => FieldRemoteDatabaseImpl());
  sl.registerLazySingleton<JobRepo>(
      () => JobRepoImpl(jobRemoteDatabase: sl.call()));
  sl.registerLazySingleton<JobRemoteDatabase>(() => JobRemoteDatabaseImpl());
  sl.registerLazySingleton<MachineRepo>(
      () => MachineRepoImpl(machineRemoteDatabase: sl.call()));
  sl.registerLazySingleton<MachineRemoteDatabase>(
      () => MachineRemoteDatabaseImpl());
  sl.registerLazySingleton<CropRepo>(
      () => CropRepoImpl(cropRemoteDatabase: sl.call()));
  sl.registerLazySingleton<CropRemoteDatabase>(() => CropRemoteDatabaseImpl());
  sl.registerLazySingleton<ForumRepo>(
      () => ForumRepoImpl(forumRemoteDatabase: sl.call()));
  sl.registerLazySingleton<ForumRemoteDatabase>(
      () => ForumRemoteDatabaseImpl());
  sl.registerLazySingleton<TeamRepo>(
      () => TeamRepoImpl(teamRemoteDatabase: sl.call()));
  sl.registerLazySingleton<TeamRemoteDatabase>(() => TeamRemoteDatabaseImpl());
}
