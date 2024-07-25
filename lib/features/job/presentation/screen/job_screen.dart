import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/features/job/presentation/cubit/job/job_cubit.dart';
import 'package:vhack_client/features/job/presentation/screen/single_job_screen.dart';
import 'package:vhack_client/presentation/components/button/icon_text_button.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/components/card/job/job_card.dart';
import 'package:vhack_client/presentation/components/date/timeline_date.dart';
import 'package:vhack_client/features/job/presentation/screen/plan_job_screen.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';
import 'package:vhack_client/injection_container.dart' as di;

class JobScreen extends StatefulWidget {
  final UserEntity userEntity;
  const JobScreen({super.key, required this.userEntity});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  DateTime? selectedDate;

  List<Map<String, dynamic>> listJob = [
    {'jobIcon': 'assets/job/spray.svg', 'jobTitle': 'Spray Job'},
    {'jobIcon': 'assets/job/fertilizer.svg', 'jobTitle': 'Fertilizer Job'},
    {'jobIcon': 'assets/job/irrigation.svg', 'jobTitle': 'Irrigation Job'},
    {'jobIcon': 'assets/job/harvest.svg', 'jobTitle': 'Harvest Job'}
  ];

  void deleteJob(JobEntity jobEntity) {
    BlocProvider.of<JobCubit>(context).deleteJob(jobID: jobEntity.jobID!);
  }

  @override
  void initState() {
    BlocProvider.of<JobCubit>(context).getJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.getBackgroundColor(context),
        floatingActionButton: floatingActionButton(),
        appBar: buildAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: buildHeader(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: buildListWidget(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            buildListJob()
          ],
        ));
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PlanJobScreen(
            userEntity: widget.userEntity,
          ),
        ));
      },
      child: Icon(
        Icons.add,
        color: CustomColor.getWhiteColor(context),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: CustomColor.getBackgroundColor(context),
      elevation: 0.5,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        'Job',
        style: CustomTextStyle.getTitleStyle(
            context, 18, CustomColor.getSecondaryColor(context)),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: CustomTextStyle.getSubTitleStyle(
                        context, 15, CustomColor.getTertieryColor(context)),
                  ),
                  Text(
                    'April 19, 2024',
                    style: CustomTextStyle.getTitleStyle(
                        context, 18, CustomColor.getSecondaryColor(context)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          buildDatePicker()
        ],
      ),
    );
  }

  Widget buildDatePicker() {
    return TimeLineDate(
      onDateChange: (valueDate) {
        selectedDate = valueDate;
      },
    );
  }

  Widget buildListWidget() {
    return BlocBuilder<JobCubit, JobState>(
      builder: (context, state) {
        if (state is JobLoaded) {
          final myJobs = state.jobs
              .where((job) => job.jobOwnerID == widget.userEntity.userID)
              .toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(child: buildWidget('To-do', myJobs.length)),
                const SizedBox(
                  width: 10,
                ),
                Expanded(child: buildWidget('Completed', 0))
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(child: buildWidget('To-do', 0)),
                const SizedBox(
                  width: 10,
                ),
                Expanded(child: buildWidget('Completed', 0))
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildWidget(String title, int value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColor.getPrimaryColor(context),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x3F14181B),
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyle.getSubTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value.toString(),
            style: CustomTextStyle.getTitleStyle(
                context, 32, CustomColor.getSecondaryColor(context)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'You almost there',
            style: CustomTextStyle.getSubTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          ),
        ],
      ),
    );
  }

  Widget buildListJob() {
    return BlocBuilder<JobCubit, JobState>(
      builder: (context, state) {
        if (state is JobLoaded) {
          final myJobs = state.jobs
              .where((job) => job.jobOwnerID == widget.userEntity.userID)
              .toList();
          return SliverList.builder(
            itemCount: myJobs.length,
            itemBuilder: (context, index) {
              JobEntity eachJob = myJobs[index];
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: buildEachJobCard(eachJob));
            },
          );
        }
        if (state is JobEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                state.emptyTitle,
                style: CustomTextStyle.getTitleStyle(
                    context, 15, CustomColor.getSecondaryColor(context)),
              ),
            ),
          );
        }
        if (state is JobFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                state.failureTitle,
                style: CustomTextStyle.getTitleStyle(
                    context, 15, CustomColor.getSecondaryColor(context)),
              ),
            ),
          );
        }
        return SliverToBoxAdapter(child: Container());
      },
    );
  }

  Widget buildEachJobCard(JobEntity eachJob) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SingleJobScree(jobEntity: eachJob),
        ));
      },
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {},
            icon: Icons.done,
            backgroundColor: Colors.blue,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
          ),
          SlidableAction(
            onPressed: (context) {
              deleteJob(eachJob);
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12)),
          )
        ]),
        child: JobCard(
          job: eachJob,
        ),
      ),
    );
  }
}
