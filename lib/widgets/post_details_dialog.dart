import 'dart:io';
import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostDetailsDialog extends StatelessWidget {
  final Post post;

  const PostDetailsDialog({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(post.title),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(post.description),

            if (post.mediaList != null)
              Column(
                children: post.mediaList!.map((media) {
                  final isNetwork = media.startsWith("http");

                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: isNetwork
                        ? Image.network(media)
                        : Image.file(File(media)),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        )
      ],
    );
  }
}