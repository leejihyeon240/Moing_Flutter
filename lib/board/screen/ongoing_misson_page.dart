// OngoingMissionPage.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moing_flutter/mission_prove/mission_prove_page.dart';
import 'package:provider/provider.dart';

import '../../const/color/colors.dart';
import '../../missions/create/missions_create_page.dart';
import '../component/board_repeat_mission_card.dart';
import '../component/board_single_mission_card.dart';
import 'ongoing_misson_state.dart';

class OngoingMissionPage extends StatelessWidget {
  static const routeName = '/board/mission/ongoing';

  const OngoingMissionPage({Key? key}) : super(key: key);

  static route(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    final int teamId = arguments as int;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                OngoingMissionState(context: context, teamId: teamId)),
      ],
      builder: (context, _) {
        return const OngoingMissionPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OngoingMissionState>();

    final data = state.repeatMissionStatus?.data;
    if (data == null) {
      log('repeatMissionData is null');
    } else if (data.isEmpty) {
      log('data is empty');
    } else {
      log('data is not empty: $data');
    }

    final singleMissionData = state.singleMissionStatus?.data;
    if (singleMissionData == null) {
      log('singleMissionData is null');
    } else {
      log('singleMissionData is not empty: $singleMissionData');
    }

    return Scaffold(
      backgroundColor: grayScaleGrey900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                _Title(
                  mainText: '반복 미션',
                  countText:
                      '${context.watch<OngoingMissionState>().repeatMissionStatus?.data.length ?? 0}',
                ),
                const SizedBox(
                  height: 12.0,
                ),
                if (state.repeatMissionStatus?.data != null &&
                    state.repeatMissionStatus!.data.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 170 / 245,
                    ),
                    itemCount: state.repeatMissionStatus!.data.length,
                    itemBuilder: (context, index) {
                      final e = state.repeatMissionStatus!.data[index];
                      return BoardRepeatMissionCard(
                        title: e.title,
                        dueTo: e.dueTo,
                        done: e.done,
                        number: e.number,
                        missionId: e.missionId,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              MissionProvePage.routeName,
                              arguments: {
                                'isRepeated': true,
                                'teamId':
                                    context.read<OngoingMissionState>().teamId,
                                'missionId': e.missionId,
                              });
                        },
                      );
                    },
                  )
                else
                  const Center(
                    child: Text(
                      '아직 미션이 없어요.',
                      style: TextStyle(
                        color: grayScaleGrey400,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                const SizedBox(height: 24.0),
                _Title(
                  mainText: '한번 미션',
                  countText:
                      '${context.watch<OngoingMissionState>().singleMissionStatus?.data.length ?? 0}',
                ),
                const SizedBox(
                  height: 12.0,
                ),
                if (state.singleMissionStatus?.data != null &&
                    state.singleMissionStatus!.data.isNotEmpty)
                  ...state.singleMissionStatus!.data
                      .map(
                        (e) => // ...
                            Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: BoardSingleMissionCard(
                            title: e.title,
                            status: e.status,
                            dueTo: e.dueTo,
                            missionType: e.missionType,
                            missionId: e.missionId,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  MissionProvePage.routeName,
                                  arguments: {
                                    'isRepeated': false,
                                    'teamId': context
                                        .read<OngoingMissionState>()
                                        .teamId,
                                    'missionId': e.missionId,
                                    // 'way': e.way,
                                  });
                            },
                          ),
                        ),
                      )
                      .toList()
                else
                  const Center(
                    child: Text(
                      '아직 미션이 없어요.',
                      style: TextStyle(
                        color: grayScaleGrey400,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                const SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const _BottomButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _Title extends StatelessWidget {
  final String mainText;
  final String countText;

  _Title({
    required this.mainText,
    required this.countText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          mainText,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: grayScaleGrey100,
          ),
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          countText,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: grayScaleGrey400,
          ),
        ),
      ],
    );
  }
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      // FloatingActionButton으로 변경
      onPressed: () {
        Navigator.of(context).pushNamed(
          MissionsCreatePage.routeName,
          arguments: context.read<OngoingMissionState>().teamId,
        );
      },
      backgroundColor: grayScaleGrey100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      label: const Text(
        '만들기 +',
        style: TextStyle(
          color: grayScaleGrey700,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
