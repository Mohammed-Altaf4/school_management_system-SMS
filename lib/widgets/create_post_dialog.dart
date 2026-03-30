import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/post_model.dart';

class CreatePostDialog extends StatefulWidget {
  final Function(Post) onCreate;

  const CreatePostDialog({super.key, required this.onCreate});

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final title = TextEditingController();
  final desc = TextEditingController();

  String type = "Announcement";
  String target = "All Students";

  final picker = ImagePicker();
  List<File> mediaFiles = []; // ✅ multiple images

  Future pickImages() async {
    final picked = await picker.pickMultiImage();

    if (picked.isNotEmpty) {
      setState(() {
        mediaFiles = picked.map((e) => File(e.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              const Text("Create New Post",
                  style: TextStyle(fontWeight: FontWeight.bold)),

              TextField(
                controller: title,
                decoration: const InputDecoration(labelText: "Title"),
              ),

              TextField(
                controller: desc,
                decoration: const InputDecoration(labelText: "Description"),
              ),

              DropdownButtonFormField(
                initialValue: type,
                items: ["Announcement", "Event", "Media"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => type = v!),
              ),

              const SizedBox(height: 10),

              /// 🔥 MULTI IMAGE UPLOAD
              GestureDetector(
                onTap: pickImages,
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: mediaFiles.isEmpty
                      ? const Center(child: Text("Upload Images"))
                      : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mediaFiles.length,
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.file(
                        mediaFiles[i],
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  widget.onCreate(
                    Post(
                      id: DateTime.now().toString(),
                      title: title.text,
                      description: desc.text,
                      mediaList:
                      mediaFiles.map((e) => e.path).toList(), // ✅
                      postedBy: "Admin",
                      postedByRole: "Admin",
                      date: DateTime.now().toString().split(" ")[0],
                      time: "Now",
                      eventType: type,
                      targetAudience: target,
                      likes: 0,
                      comments: 0,
                    ),
                  );

                  Navigator.pop(context);
                },
                child: const Text("Create"),
              )
            ],
          ),
        ),
      ),
    );
  }
}