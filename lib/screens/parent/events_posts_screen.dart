import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import '../../widgets/post_card.dart';
import '../../widgets/create_post_dialog.dart';
import '../../widgets/post_details_dialog.dart';
import '../../widgets/parent_drawer.dart';

const Color bgIce = Color(0xFFEFF6FF);
const Color primaryBlue = Color(0xFF2563EB);

class EventsPostsScreen extends StatefulWidget {
  final String userRole;

  const EventsPostsScreen({super.key, required this.userRole});

  @override
  State<EventsPostsScreen> createState() => _EventsPostsScreenState();
}

class _EventsPostsScreenState extends State<EventsPostsScreen> {
  List<Post> posts = [];
  List<Post> filteredPosts = [];

  String searchQuery = "";
  String filterType = "all";
  String filterClass = "all";

  @override
  void initState() {
    super.initState();
    loadDummyPosts();
  }

  void loadDummyPosts() {
    posts = [
      Post(
        id: "1",
        title: "Annual Sports Day 2026",
        description: "Annual sports event for all students.",
        mediaList: [
          "https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=800",
          "https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf?w=800",
        ],
        mediaType: "image",
        postedBy: "Admin",
        postedByRole: "Admin",
        date: "2026-03-25",
        time: "10:30 AM",
        eventType: "Event",
        targetAudience: "All Students",
        likes: 145,
        comments: 23,
      ),
    ];

    filteredPosts = posts;
  }

  void applyFilters() {
    List<Post> temp = [...posts];

    if (searchQuery.isNotEmpty) {
      temp = temp.where((p) =>
      p.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    if (filterType != "all") {
      temp = temp.where((p) => p.eventType == filterType).toList();
    }

    if (filterClass != "all") {
      temp = temp.where((p) => p.targetAudience == filterClass).toList();
    }

    setState(() => filteredPosts = temp);
  }

  void handleCreate(Post newPost) {
    setState(() {
      posts.insert(0, newPost);
      filteredPosts = posts;
    });
  }

  void deletePost(String id) {
    setState(() {
      posts.removeWhere((p) => p.id == id);
      filteredPosts = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = widget.userRole == "admin";

    return Scaffold(
      drawer: const ParentDrawer(),
      backgroundColor: bgIce,

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Events & Posts",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// 🔍 FILTER CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [

                    /// SEARCH
                    TextField(
                      onChanged: (val) {
                        searchQuery = val;
                        applyFilters();
                      },
                      decoration: const InputDecoration(
                        hintText: "Search posts...",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// ✅ RESPONSIVE DROPDOWNS (FIXED)
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          /// 📱 MOBILE → COLUMN
                          return Column(
                            children: [
                              _buildTypeDropdown(),
                              const SizedBox(height: 10),
                              _buildClassDropdown(),
                            ],
                          );
                        } else {
                          /// 💻 LARGE SCREEN → ROW
                          return Row(
                            children: [
                              Expanded(child: _buildTypeDropdown()),
                              const SizedBox(width: 10),
                              Expanded(child: _buildClassDropdown()),
                            ],
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 12),

                    /// 🚫 ADMIN ONLY BUTTON
                    if (isAdmin)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  CreatePostDialog(onCreate: handleCreate),
                            );
                          },
                          child: const Text("Create Post"),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 📋 POSTS LIST
              Expanded(
                child: ListView.builder(
                  itemCount: filteredPosts.length,
                  itemBuilder: (_, i) {
                    final post = filteredPosts[i];

                    return PostCard(
                      post: post,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              PostDetailsDialog(post: post),
                        );
                      },
                      onDelete: isAdmin
                          ? () => deletePost(post.id)
                          : () {},
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 🔽 DROPDOWN WIDGETS (CLEAN REUSE)

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: filterType,
      decoration: const InputDecoration(
        labelText: "Type",
        border: OutlineInputBorder(),
      ),
      items: ["all", "Announcement", "Event", "Media"]
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (val) {
        filterType = val!;
        applyFilters();
      },
    );
  }

  Widget _buildClassDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: filterClass,
      decoration: const InputDecoration(
        labelText: "Class",
        border: OutlineInputBorder(),
      ),
      items: [
        "all",
        "All Students",
        "Grade 8",
        "Grade 9",
        "Grade 10"
      ]
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (val) {
        filterClass = val!;
        applyFilters();
      },
    );
  }
}