import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moing_flutter/const/color/colors.dart';
import 'package:moing_flutter/model/comment/comment_model.dart';

class CommentCard extends StatelessWidget {
  final CommentData commentData;

  const CommentCard({super.key, required this.commentData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(commentData: commentData),
          const SizedBox(height: 12.0),
          _Content(commentData: commentData),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final CommentData commentData;

  const _Header({required this.commentData});

  @override
  Widget build(BuildContext context) {
    log(commentData.writerNickName);
    return Row(
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: grayScaleGrey500,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          commentData.writerNickName,
          style: const TextStyle(
            color: grayScaleGrey400,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4.0),
        if (commentData.writerIsLeader)
          Image.asset(
            'asset/image/icon_crown.png',
            width: 14.0,
            height: 14.0,
          ),
        const Spacer(),
        if (commentData.isWriter)
          GestureDetector(
            onTap: () {},
            child: const Text(
              '삭제',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: grayBlack8,
              ),
            ),
          ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final CommentData commentData;

  const _Content({required this.commentData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Text(
        commentData.content,
        style: const TextStyle(
          color: grayBlack3,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          height: 1.7,
        ),
      ),
    );
  }
}
