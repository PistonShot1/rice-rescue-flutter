import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/machine/presentation/cubit/machine/machine_cubit.dart';
import 'package:vhack_client/presentation/components/textfield/search_textfield.dart';
import 'package:vhack_client/features/machine/presentation/screen/tabbar/machines_active_screen.dart';
import 'package:vhack_client/features/machine/presentation/screen/tabbar/machines_all_screen.dart';
import 'package:vhack_client/features/machine/presentation/screen/tabbar/machines_inactive_screen.dart';
import 'package:vhack_client/features/machine/presentation/screen/add_machine_screen.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../domain/entity/machine_entity.dart';

class MachinesScreen extends StatefulWidget {
  final UserEntity userEntity;
  const MachinesScreen({super.key, required this.userEntity});

  @override
  State<MachinesScreen> createState() => _MachinesScreenState();
}

class _MachinesScreenState extends State<MachinesScreen> {
  List<Map<String, dynamic>> machines = [
    {
      'machineID': '1',
      'machineName': 'Tractor',
      'machineURL':
          'https://image.made-in-china.com/202f0j00jAKVUBiRMwzv/4WD-Agricultural-Dump-Truck-Tractor-for-Paddy-Field.webp',
      'machineJob': 'Land Preparation',
      'machineStatus': true
    },
    {
      'machineID': '2',
      'machineName': 'Rotary Tiller',
      'machineURL':
          'https://image.made-in-china.com/2f0j00HsglrUKzscpu/1gqn220-Rotary-Tiller-for-Farm-Tractor-Gear-Drive-Cultivator-Beater-Rotary-Plowing-Tiller-Machine-CE-Orchard-Agriculture-Paddy-Dry-Field-Agricultural-Machinery.webp',
      'machineJob': 'Land Preparation',
      'machineStatus': false
    },
    {
      'machineID': '3',
      'machineName': 'Seeder',
      'machineURL':
          'https://inputs.kalgudi.com/data/p_images/1626153803268.jpeg',
      'machineJob': 'Seeding',
      'machineStatus': false
    },
    {
      'machineID': '4',
      'machineName': 'Transplanter',
      'machineURL':
          'https://5.imimg.com/data5/DS/CW/MY-24923732/4-rows-paddy-transplanter.png',
      'machineJob': 'Transplanting Seedlings',
      'machineStatus': false
    },
    {
      'machineID': '5',
      'machineName': 'Fertilizer Spreader',
      'machineURL':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrtCxk4msAjHrJEJQVx2DhuIxnQYBykMc30Q&usqp=CAUpesticide ',
      'machineJob': 'Fertilizer Application',
      'machineStatus': true
    },
    {
      'machineID': '6',
      'machineName': 'Pesticide Sprayer',
      'machineURL':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGpG_swboYFOc8soiN9w8x2WksY0akXjahmQ&usqp=CAU',
      'machineJob': 'Pest Control',
      'machineStatus': true
    },
    {
      'machineID': '7',
      'machineName': 'Harvester',
      'machineURL':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStb4I6vZHhMaikjt4nAb_r5HLUrZb6--tPw0vz9FsGa1Vpbd9fBBZjbAjXgYQfOu0Lf90&usqp=CAU',
      'machineJob': 'Harvesting',
      'machineStatus': true
    },
    {
      'machineID': '8',
      'machineName': 'Thresher',
      'machineURL':
          'https://bensonagro.com/media/front/images/electric-paddy-thresher.jpg',
      'machineJob': 'Threshing',
      'machineStatus': true
    },
    {
      'machineID': '9',
      'machineName': 'Drying Machine',
      'machineURL':
          'https://sc04.alicdn.com/kf/H60020543632a4be3848904ff904e0696m.jpg',
      'machineJob': 'Grain Drying',
      'machineStatus': true
    },
    {
      'machineID': '10',
      'machineName': 'Rice Mill',
      'machineURL':
          'https://sccgmachinery.com/wp-content/uploads/2021/09/7.png',
      'machineJob': 'Rice Milling',
      'machineStatus': true
    },
  ];

  @override
  void initState() {
    BlocProvider.of<MachineCubit>(context).getMachines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MachineCubit, MachineState>(
      builder: (context, state) {
        if (state is MachineLoaded) {
          return buildContent(state.machines);
        }
        if (state is MachineFailure) {
          return buildUtilScreen(state.failureTitle);
        }
        if (state is MachineEmpty) {
          return buildUtilScreen(state.emptyTitle);
        }
        if (state is MachineLoading) {
          return buildUtilScreen("");
        }
        return buildUtilScreen("");
      },
    );
  }

  Widget buildContent(List<MachineEntity> listMachine) => Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      appBar: CustomAppBar.BuildMainAppBar(context, false),
      floatingActionButton: buildFloatingActionButton(),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(child: buildHeader()),
                buildSilverAppBar()
              ];
            },
            body: TabBarView(
              children: [
                MachinesAllScreen(
                  machines: listMachine,
                ),
                MachinesActiveScreen(
                  machines: listMachine,
                ),
                MachinesInactiveScreen(
                  machines: listMachine,
                )
              ],
            )),
      ));

  Widget buildUtilScreen(String title) => Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      appBar: CustomAppBar.BuildMainAppBar(context, false),
      floatingActionButton: buildFloatingActionButton(),
      body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(child: buildHeader()),
                  buildSilverAppBar()
                ];
              },
              body: Center(
                  child: Text(
                title,
                style: CustomTextStyle.getTitleStyle(
                    context, 21, CustomColor.getSecondaryColor(context)),
              )))));

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddMachineScreen(
            userEntity: widget.userEntity,
          ),
        ));
      },
      child: Icon(
        Icons.fire_truck_outlined,
        color: CustomColor.getWhiteColor(context),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Machines',
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getSecondaryColor(context)),
          ),
          Text(
            'This is all available machines in our services',
            style: CustomTextStyle.getSubTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          ),
        ],
      ),
    );
  }

  Widget buildSilverAppBar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      shape: Border(
          bottom:
              BorderSide(color: Color(0xFFAAAAAA).withOpacity(1), width: 1)),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).colorScheme.tertiary,
              indicatorColor: Theme.of(context).colorScheme.secondary,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  child: Text(
                    'All',
                    style: CustomTextStyle.getTitleStyle(
                        context, 15, CustomColor.getSecondaryColor(context)),
                  ),
                ),
                Tab(
                  child: Text(
                    'Active',
                    style: CustomTextStyle.getTitleStyle(
                        context, 15, CustomColor.getSecondaryColor(context)),
                  ),
                ),
                Tab(
                  child: Text(
                    'Inactive',
                    style: CustomTextStyle.getTitleStyle(
                        context, 15, CustomColor.getSecondaryColor(context)),
                  ),
                )
              ])),
    );
  }
}
