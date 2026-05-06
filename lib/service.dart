import 'package:flutter/material.dart';
import 'app_navigation.dart';

// ─── Data Models ────────────────────────────────────────────────────────────

enum CommentStatus { actionRequired, resolved }

class ThreadedComment {
  final String author;
  final String initials;
  final String message;
  final String date;
  final CommentStatus status;

  const ThreadedComment({
    required this.author,
    required this.initials,
    required this.message,
    required this.date,
    required this.status,
  });
}

// ─── Main Screen ─────────────────────────────────────────────────────────────

class PreviewSubmitScreen extends StatefulWidget {
  const PreviewSubmitScreen({super.key});

  @override
  State<PreviewSubmitScreen> createState() => _PreviewSubmitScreenState();
}

class _PreviewSubmitScreenState extends State<PreviewSubmitScreen> {
  final List<ThreadedComment> _comments = const [
    ThreadedComment(
      author: 'HOD',
      initials: 'H',
      message: 'Please attach feedback summary for CSE301.',
      date: '12 Mar 2025',
      status: CommentStatus.actionRequired,
    ),
    ThreadedComment(
      author: 'Faculty',
      initials: 'F',
      message: 'Uploaded feedback summary for review.',
      date: '13 Mar 2025',
      status: CommentStatus.resolved,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FacultyNavigationDrawer(currentRoute: '/service'),
      appBar: AppBar(
        title: const Text('Service & Outreach'),
        backgroundColor: const Color(0xFF1A2B4A),
      ),
      body: _MainContent(comments: _comments),
    );
  }
}

// ─── Main Content ─────────────────────────────────────────────────────────────

class _MainContent extends StatefulWidget {
  final List<ThreadedComment> comments;

  const _MainContent({required this.comments});

  @override
  State<_MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<_MainContent> {
  bool _showAddComment = false;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Page Title ───────────────────────────────────────────
          Row(
            children: [
              const Text(
                'Preview & Submit APR',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A2B4A),
                ),
              ),
              const SizedBox(width: 12),
              _StatusChip(label: 'Draft', color: const Color(0xFFE65100)),
            ],
          ),
          const SizedBox(height: 24),

          // ── APR Snapshot Card ────────────────────────────────────
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'APR Snapshot',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A2B4A),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download, size: 16),
                      label: const Text('Download PDF'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A2B4A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Review computed scores and attached evidence. Once submitted, the APR becomes read-only and is routed to HOD → Dean → DQA.',
                  style: TextStyle(
                    color: Color(0xFF546E7A),
                    fontSize: 13.5,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1A2B4A),
                        side: const BorderSide(color: Color(0xFF1A2B4A)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Preview scorecard'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _showSubmitDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE65100),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Submit to HOD'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Threaded Comments Card ───────────────────────────────
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Threaded comments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A2B4A),
                  ),
                ),
                const SizedBox(height: 16),

                // Comments list
                ...widget.comments.map((c) => _CommentTile(comment: c)),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 12),

                // Add Comment toggle
                if (!_showAddComment)
                  OutlinedButton(
                    onPressed: () => setState(() => _showAddComment = true),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1A2B4A),
                      side: const BorderSide(color: Color(0xFFB0BEC5)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text('Add comment'),
                  )
                else
                  _AddCommentBox(
                    controller: _commentController,
                    onCancel:
                        () => setState(() {
                          _showAddComment = false;
                          _commentController.clear();
                        }),
                    onSubmit:
                        () => setState(() {
                          _showAddComment = false;
                          _commentController.clear();
                        }),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Submit APR to HOD?'),
            content: const Text(
              'Once submitted, the APR becomes read-only and will be routed to HOD → Dean → DQA for review.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE65100),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
    );
  }
}

// ─── Reusable Widgets ─────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: child,
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final ThreadedComment comment;

  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    final isActionRequired = comment.status == CommentStatus.actionRequired;
    final chipColor =
        isActionRequired ? const Color(0xFFE65100) : const Color(0xFF2E7D32);
    final chipLabel = isActionRequired ? 'Action required' : 'Resolved';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFF546E7A),
            child: Text(
              comment.initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.author,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF1A2B4A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: chipColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        chipLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.message,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF37474F),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment.date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF90A4AE),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddCommentBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  const _AddCommentBox({
    required this.controller,
    required this.onCancel,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Write a comment...',
            hintStyle: const TextStyle(color: Color(0xFFB0BEC5)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFB0BEC5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF1A2B4A)),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A2B4A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text('Post comment'),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: onCancel,
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF546E7A)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
