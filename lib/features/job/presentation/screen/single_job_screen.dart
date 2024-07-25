import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/features/job/presentation/cubit/single_job/single_job_cubit.dart';
import 'package:vhack_client/shared/constant/custom_date.dart';
import 'package:vhack_client/injection_container.dart' as di;
import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';
import '../../../auth/domain/entity/user_entity.dart';

class SingleJobScree extends StatelessWidget {
  final JobEntity jobEntity;
  const SingleJobScree({super.key, required this.jobEntity});

  Color getColor(JobEntity jobEntity) {
    final priorityColors = {
      'Low': Colors.green,
      'Medium': Colors.yellow.shade600,
      'High': Colors.red,
    };

    return priorityColors[jobEntity.jobPriority] ?? Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SingleJobCubit>(
      create: (context) =>
          di.sl<SingleJobCubit>()..getSingleJob(jobEntity: jobEntity),
      child: BlocBuilder<SingleJobCubit, SingleJobState>(
        builder: (context, state) {
          if (state is SingleJobLoaded) {
            return Scaffold(
                backgroundColor: CustomColor.getBackgroundColor(context),
                appBar: buildAppBar(context),
                body: buildContent(context, state.jobEntity));
          }
          if (state is SingleJobFailure) {
            return Scaffold(
                backgroundColor: CustomColor.getBackgroundColor(context),
                appBar: buildAppBar(context),
                body: Center(
                    child: Text(
                  state.failureTitle,
                  style: CustomTextStyle.getTitleStyle(
                      context, 18, CustomColor.getSecondaryColor(context)),
                )));
          }
          if (state is SingleJobLoading) {
            return Scaffold(
                backgroundColor: CustomColor.getBackgroundColor(context),
                appBar: buildAppBar(context),
                body: Center(
                    child: CircularProgressIndicator(
                  color: CustomColor.getSecondaryColor(context),
                )));
          }
          return Scaffold(
            backgroundColor: CustomColor.getBackgroundColor(context),
            body: Center(
                child: CircularProgressIndicator(
              color: CustomColor.getSecondaryColor(context),
            )),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.getSecondaryColor(context),
      elevation: 0.5,
      centerTitle: true,
      automaticallyImplyLeading: true,
      title: Text(
        'Task Detail',
        style: CustomTextStyle.getTitleStyle(
            context, 18, CustomColor.getWhiteColor(context)),
      ),
    );
  }

  Widget buildContent(BuildContext context, JobEntity job) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Text(
                job.jobName!,
                style: CustomTextStyle.getTitleStyle(
                    context, 32, CustomColor.getTertieryColor(context)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
              height: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            buildInfoCard(context,
                title: 'Date',
                iconData: Icons.calendar_month_outlined,
                content: ConvertDate.convertDateString(job.jobDate!)),
            const SizedBox(
              height: 20,
            ),
            buildInfoCard(context,
                title: 'Type',
                iconData: Icons.account_tree_outlined,
                content: job.jobType!),
            const SizedBox(
              height: 20,
            ),
            buildInfoCard(context,
                title: 'Field',
                iconData: Icons.area_chart_outlined,
                content: job.jobField!.fieldName!),
            const SizedBox(
              height: 20,
            ),
            buildPriority(context),
            const SizedBox(
              height: 20,
            ),
            buildDesc(context),
            const SizedBox(
              height: 20,
            ),
            buildListInfoCard(context, 'Members', job.jobMembers!),
          ],
        ),
      );

  Widget buildInfoCard(BuildContext context,
      {required String title,
      required IconData iconData,
      required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyle.getTitleStyle(context, 15, Colors.grey),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(
                iconData,
                color: CustomColor.getTertieryColor(context),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                content,
                style: CustomTextStyle.getSubTitleStyle(
                    context, 15, CustomColor.getTertieryColor(context)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildPriority(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Priority',
              style: CustomTextStyle.getTitleStyle(context, 15, Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.flag_outlined,
                  color: getColor(jobEntity),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Medium',
                  style: CustomTextStyle.getTitleStyle(
                      context, 15, getColor(jobEntity)),
                )
              ],
            ),
          ],
        ),
      );

  Widget buildDesc(
    BuildContext context,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: CustomTextStyle.getTitleStyle(context, 15, Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              jobEntity.jobDesc!,
              style: CustomTextStyle.getSubTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            )
          ],
        ),
      );

  Widget buildListInfoCard(
          BuildContext context, String title, final List<UserEntity> users) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: CustomTextStyle.getTitleStyle(context, 15, Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    if (users.isEmpty) {
                      return Text(
                        'Nothing to show here',
                        style: CustomTextStyle.getSubTitleStyle(
                            context, 15, CustomColor.getTertieryColor(context)),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: CustomColor.getSecondaryColor(context)),
                          child: Center(
                              child: Text(
                            users[index].userName!,
                            style: CustomTextStyle.getTitleStyle(context, 12,
                                CustomColor.getWhiteColor(context)),
                          )),
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      );
}
