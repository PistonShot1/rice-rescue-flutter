import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/auth/presentation/cubit/user/user_cubit.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/features/field/presentation/cubit/field/field_cubit.dart';
import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/features/job/presentation/cubit/job/job_cubit.dart';
import 'package:vhack_client/features/machine/domain/entity/machine_entity.dart';
import 'package:vhack_client/features/machine/presentation/cubit/machine/machine_cubit.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/components/dialog/machine/machine_dialog.dart';
import 'package:vhack_client/presentation/components/dialog/member/member_dialog.dart';
import 'package:vhack_client/presentation/components/dropdown/field_dropdown.dart';
import 'package:vhack_client/presentation/components/textfield/date_textfield.dart';
import 'package:vhack_client/presentation/components/textfield/desc_textfield.dart';
import 'package:vhack_client/presentation/components/textfield/field_textfield.dart';
import 'package:vhack_client/presentation/components/textfield/input_textfield.dart';
import 'package:vhack_client/presentation/screen/bridge_screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_snackbar.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';
import 'package:vhack_client/injection_container.dart' as di;

class CreateTaskScreen extends StatefulWidget {
  final UserEntity userEntity;
  final String jobType;
  const CreateTaskScreen(
      {super.key, required this.jobType, required this.userEntity});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController tcJobName = TextEditingController();
  final TextEditingController tcEndDate = TextEditingController();
  final TextEditingController tcDesc = TextEditingController();
  final TextEditingController tcField = TextEditingController();
  bool isLoading = false;
  List<UserEntity> selectedUsers = [];
  List<MachineEntity> selectedMachines = [];

  List listPriority = [
    ['Low', Colors.green, false],
    ['Medium', Colors.orange, false],
    ['High', Colors.red, false]
  ];

  List listField = [
    ['Field 1', false],
    ['Field 2', false],
    ['Field 3', false],
    ['Field 4', false]
  ];

  String? fieldDefault;
  String? selectedPriority;
  String? selectedFieldID;
  FieldEntity? selectedField;

  @override
  void initState() {
    tcEndDate.text == '';
    super.initState();
  }

  void selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: CustomColor.getSecondaryColor(
                context), // Your custom color here
            colorScheme: ColorScheme.light(
                primary: CustomColor.getSecondaryColor(context)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        tcEndDate.text = formattedDate;
      });
    } else {
      debugPrint('Date Null');
    }
  }

  void selectMember() {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return MemberDialog(
          id: 'job',
          title: 'Invite Your Member into this job',
          desc:
              'Your project has been created, now invite your team to continue',
          buttonTitle: 'Send Invites',
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              selectedUsers
                  .addAll(BlocProvider.of<UserCubit>(context).selectedUsers);
            });
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void selectMachine() {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return MachineDialog(
          onPressed: () {
            Navigator.pop(context);

            setState(() {
              selectedMachines.addAll(
                  BlocProvider.of<MachineCubit>(context).selectedMachines);
            });
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void priorityTypeSelected(int index) {
    setState(() {
      for (int i = 0; i < listPriority.length; i++) {
        setState(() {
          listPriority[i][2] = false;
        });
      }
      listPriority[index][2] = true;
      selectedPriority = listPriority[index][0];
      print(selectedPriority);
    });
  }

  void saveTask() {
    final List<UserEntity> selectedUsers =
        BlocProvider.of<UserCubit>(context).selectedUsers;
    final List<MachineEntity> selectedMachines =
        BlocProvider.of<MachineCubit>(context).selectedMachines;
    final List<String> machinesID = [];
    for (var eachMachine in selectedMachines) {
      machinesID.add(eachMachine.machineID!);
    }
    setState(() {
      isLoading = true;
    });
    if (selectedField == null ||
        tcJobName.text.isEmpty ||
        tcEndDate.text.isEmpty ||
        tcDesc.text.isEmpty ||
        selectedPriority!.isEmpty) {
      SnackBarUtil.showSnackBar('Please fill the form', Colors.red);
    } else {
      BlocProvider.of<JobCubit>(context)
          .postJob(
              jobEntity: JobEntity(
                  jobName: tcJobName.text,
                  jobType: widget.jobType,
                  jobDesc: tcDesc.text,
                  jobOwnerID: widget.userEntity.userID,
                  jobPriority: selectedPriority,
                  jobFieldID: selectedField!.fieldID,
                  jobDate: tcEndDate.text,
                  jobMachinesID: machinesID,
                  jobMembers: selectedUsers))
          .then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BridgeScreen(
                userID: widget.userEntity.userID,
              ),
            ),
            (route) => false);
        setState(() {
          isLoading = false;
        });
        BlocProvider.of<MachineCubit>(context).reset();
        BlocProvider.of<UserCubit>(context).reset();
      });
    }
  }

  //{ jobName, jobType, jobDesc, jobOwnerID, jobPriority, jobFieldID, jobDate }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.getBackgroundColor(context),
        appBar: buildAppBar(),
        body: Column(
          children: [buildContentForm(), buildCreateButton()],
        ));
  }

  AppBar buildAppBar() => AppBar(
        backgroundColor: CustomColor.getSecondaryColor(context),
        elevation: 0.5,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          'Create Task',
          style: CustomTextStyle.getTitleStyle(
              context, 18, CustomColor.getWhiteColor(context)),
        ),
      );

  Widget buildContentForm() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildFieldForm(),
            const SizedBox(
              height: 20,
            ),
            buildTaskForm(),
            const SizedBox(
              height: 20,
            ),
            builDate('Due Date', tcEndDate, 'Finish On...'),
            const SizedBox(
              height: 20,
            ),
            buildDescription(),
            const SizedBox(
              height: 20,
            ),
            buildButtonForm(),
            const SizedBox(
              height: 20,
            ),
            buildPriority(),
          ],
        ),
      ),
    );
  }

  Widget buildFieldForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Field Name',
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 10,
          ),
          buildDropDownField()
        ],
      ),
    );
  }

  Widget buildDropDownField() {
    return BlocProvider<FieldCubit>(
        create: (context) => di.sl<FieldCubit>()..getFields(),
        child: BlocBuilder<FieldCubit, FieldState>(
          builder: (context, state) {
            if (state is FieldLoaded) {
              return FieldDropDown(
                fields: state.fields,
                selectedField: selectedField,
                onChanged: (newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedField = newValue;
                    });
                    print(selectedFieldID);
                  }
                },
              );
            }
            return Container();
          },
        ));
  }

  Widget buildTaskForm() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Name',
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            ),
            const SizedBox(
              height: 10,
            ),
            InputTextField(
                tcInput: tcJobName, tcTitle: 'Task Name', tcIcon: Icons.task)
          ],
        ),
      );

  Widget builDate(
      String dateTitle, TextEditingController tcDate, String hintTextField) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateTitle,
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 10,
          ),
          DateTextField(
            hintTextField: hintTextField,
            tcDate: tcDate,
            onTap: () {
              selectDate();
            },
          ),
        ],
      ),
    );
  }

  Widget buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 10,
          ),
          DescTextField(
            tcDesc: tcDesc,
            descTitle: 'Description...',
          ),
        ],
      ),
    );
  }

  Widget buildButtonForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextOnlyButton(
              buttonTitle: 'Assign Members',
              onPressed: () {
                selectMember();
              },
              isMain: true,
              borderRadius: 12),
          const SizedBox(
            height: 10,
          ),
          TextOnlyButton(
              buttonTitle: 'Select Machines',
              onPressed: () {
                selectMachine();
              },
              isMain: false,
              borderRadius: 12)
        ],
      ),
    );
  }

  Widget buildPriority() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Priority',
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(height: 30, child: buildListPriorityChip())
        ],
      ),
    );
  }

  Widget buildListPriorityChip() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listPriority.length,
      itemBuilder: (context, index) {
        bool isSelected = listPriority[index][2];
        return GestureDetector(
          onTap: () {
            priorityTypeSelected(index);
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: buildPriorityChip(isSelected, index)),
        );
      },
    );
  }

  Widget buildPriorityChip(bool isSelected, int index) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isSelected ? listPriority[index][1] : Colors.black38),
            color:
                isSelected ? listPriority[index][1].shade200 : Colors.black12),
        child: Center(
            child: Text(
          listPriority[index][0],
          style: CustomTextStyle.getSubTitleStyle(context, 12, Colors.black),
        )));
  }

  Widget buildCreateButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 20, top: 10),
      child: TextOnlyButton(
          buttonTitle: isLoading ? 'Loading...' : 'Create',
          onPressed: () {
            saveTask();
          },
          isMain: true,
          borderRadius: 12),
    );
  }

  Widget buildBottomChip() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
          child: Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      ],
    );
  }
}
