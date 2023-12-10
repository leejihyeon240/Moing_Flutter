import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget {
  final String notificationCount;
  final void Function() onTap;

  const HomeAppBar({
    required this.notificationCount,
    required this.onTap,
    super.key});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'asset/icons/moing_logo.svg',
          width: 80,
          height: 32,
        ),
        const Spacer(),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 21,
              height: 25,
              decoration: const BoxDecoration(
                color: Color(0xffFF6464),
                shape: BoxShape.circle,
              ),
            ),
            Text(
              notificationCount,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(width: 4.0,),
        GestureDetector(
          onTap: onTap,
          child: SvgPicture.asset(
            'asset/image/icon_notification.svg',
            width: 24.0,
            height: 24.0,
          ),
        ),
      ],
    );
  }
}
