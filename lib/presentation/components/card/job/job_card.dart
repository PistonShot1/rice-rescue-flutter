import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/shared/constant/custom_date.dart';

import '../../../../features/auth/domain/entity/user_entity.dart';
import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class JobCard extends StatelessWidget {
  final JobEntity job;
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return buildJobCard(context);
  }

  Color getColor(JobEntity jobEntity) {
    final priorityColors = {
      'Low': Colors.green,
      'Medium': Colors.yellow,
      'High': Colors.orange,
    };

    return priorityColors[jobEntity.jobPriority] ?? Colors.black;
  }

  String names(List<UserEntity> users) {
    List<dynamic> userNames = users.map((user) => user.userName ?? '').toList();
    return userNames.join(', ');
  }

  Widget buildJobCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.getPrimaryColor(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 0.5),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x3F14181B),
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 10,
            decoration: BoxDecoration(
                color: getColor(job),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset(
                  'assets/Temperature.svg',
                  semanticsLabel: job.jobName,
                  height: 40,
                  width: 40,
                ),
                title: Text(
                  job.jobName!,
                  style: CustomTextStyle.getTitleStyle(
                      context, 15, CustomColor.getTertieryColor(context)),
                ),
                subtitle: Text(
                  names(job.jobMembers!),
                  style: CustomTextStyle.getSubTitleStyle(
                      context, 12, CustomColor.getTertieryColor(context)),
                ),
                trailing: Text(
                  ConvertDate.convertDateString(job.jobDate!),
                  style: CustomTextStyle.getTitleStyle(
                      context, 12, CustomColor.getSecondaryColor(context)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
