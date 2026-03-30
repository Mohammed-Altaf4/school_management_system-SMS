import 'dart:io';
import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
    required this.onDelete,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TOP BAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(post.eventType,
                    style: const TextStyle(fontWeight: FontWeight.bold)),

                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 18),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,
                          size: 18, color: Colors.red),
                      onPressed: widget.onDelete,
                    ),
                  ],
                )
              ],
            ),

            Text(post.title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 6),

            Text(post.description),

            /// 🔥 INSTAGRAM SWIPE
            if (post.mediaList != null && post.mediaList!.isNotEmpty)
              Column(
                children: [
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      itemCount: post.mediaList!.length,
                      onPageChanged: (i) {
                        setState(() => currentIndex = i);
                      },
                      itemBuilder: (_, i) {
                        final media = post.mediaList![i];
                        final isNetwork = media.startsWith("http");

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: isNetwork
                              ? Image.network(media, fit: BoxFit.cover)
                              : Image.file(File(media), fit: BoxFit.cover),
                        );
                      },
                    ),
                  ),

                  /// DOTS
                  if (post.mediaList!.length > 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        post.mediaList!.length,
                            (i) => Container(
                          margin: const EdgeInsets.all(3),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: currentIndex == i
                                ? Colors.black
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${post.postedBy} • ${post.date}"),
                Row(
                  children: [
                    const Icon(Icons.favorite,
                        size: 16, color: Colors.red),
                    Text(" ${post.likes}"),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}