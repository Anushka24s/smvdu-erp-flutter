import 'package:flutter/material.dart';

void main() {
  runApp(const FacultyApp());
}

class FacultyApp extends StatelessWidget {
  const FacultyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faculty Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF0A2540),
        brightness: Brightness.light,
        fontFamily: 'Roboto',
      ),
      home: const TeachingAssignmentsPage(),
    );
  }
}

// ─── Data Model ──────────────────────────────────────────────────────────────

class CourseEntry {
  final String code;
  final String title;
  final int classStrength;
  final String ltp;
  final int sessionsDelivered;
  final double feedbackScore;
  final bool evidenceUploaded;
  bool selected;

  CourseEntry({
    required this.code,
    required this.title,
    required this.classStrength,
    required this.ltp,
    required this.sessionsDelivered,
    required this.feedbackScore,
    required this.evidenceUploaded,
    this.selected = false,
  });
}

// ─── Main Page ────────────────────────────────────────────────────────────────

class TeachingAssignmentsPage extends StatefulWidget {
  const TeachingAssignmentsPage({super.key});

  @override
  State<TeachingAssignmentsPage> createState() =>
      _TeachingAssignmentsPageState();
}

class _TeachingAssignmentsPageState extends State<TeachingAssignmentsPage>
    with SingleTickerProviderStateMixin {
  bool _isOdd = true;
  String _selectedYear = '2024-25';
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<CourseEntry> _courses = [
    CourseEntry(
      code: 'CSE301',
      title: 'Machine Learning',
      classStrength: 65,
      ltp: '3-1-0',
      sessionsDelivered: 40,
      feedbackScore: 4.5,
      evidenceUploaded: true,
    ),
    CourseEntry(
      code: 'CSE210',
      title: 'Database Systems',
      classStrength: 70,
      ltp: '3-0-2',
      sessionsDelivered: 38,
      feedbackScore: 4.2,
      evidenceUploaded: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  // ─── Drawer ────────────────────────────────────────────────────────────────

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFFFAFAFD),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0A2540), Color(0xFF1565C0)],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white30, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 32,
                    backgroundColor: Color(0xFF1E3A5F),
                    child: Icon(Icons.person, size: 36, color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Faculty Member',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  '23bee006@smvdu.ac.in',
                  style: TextStyle(color: Colors.white60, fontSize: 12.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _drawerItem(Icons.dashboard_outlined, 'Dashboard', false),
          _drawerItem(Icons.person_outline, 'My Profile', false),
          _drawerSection('Teaching & Mentoring'),
          _drawerItem(
            Icons.school_outlined,
            'My Teaching, Mentoring & Guidance',
            false,
          ),
          _drawerSubItem(Icons.menu_book_outlined, 'Teaching', true),
          _drawerSubItem(Icons.group_outlined, 'Mentoring', false),
          _drawerSubItem(Icons.lightbulb_outline, 'Guidance', false),
          _drawerSection('Research'),
          _drawerItem(Icons.article_outlined, 'My Publications & IP', false),
          _drawerSubItem(Icons.library_books_outlined, 'Publications', false),
          _drawerSubItem(Icons.verified_outlined, 'IP & Patents', false),
          _drawerItem(
            Icons.business_center_outlined,
            'Projects & Consultancy',
            false,
          ),
          _drawerSection('Events & Service'),
          _drawerItem(
            Icons.event_note_outlined,
            'Conferences / FDP / Workshops',
            false,
          ),
          _drawerItem(Icons.campaign_outlined, 'Events Organized', false),
          _drawerItem(
            Icons.volunteer_activism_outlined,
            'Service & Outreach',
            false,
          ),
          _drawerSection('APR'),
          _drawerItem(Icons.assignment_outlined, 'APR', false),
          _drawerSubItem(Icons.edit_note_outlined, 'Prepare APR', false),
          _drawerSubItem(Icons.send_outlined, 'Preview & Submit', false),
          const SizedBox(height: 8),
          const Divider(indent: 16, endIndent: 16),
          _drawerItem(Icons.logout_rounded, 'Logout', false, isLogout: true),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _drawerSection(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: Color(0xFF90A4AE),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _drawerItem(
    IconData icon,
    String label,
    bool selected, {
    bool isLogout = false,
  }) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      leading: Icon(
        icon,
        size: 20,
        color:
            isLogout
                ? Colors.red[400]
                : selected
                ? const Color(0xFF1565C0)
                : const Color(0xFF546E7A),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          color:
              isLogout
                  ? Colors.red[400]
                  : selected
                  ? const Color(0xFF0A2540)
                  : const Color(0xFF37474F),
        ),
      ),
      selected: selected,
      selectedTileColor: const Color(0xFFE3F2FD),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: () => Navigator.pop(context),
    );
  }

  Widget _drawerSubItem(IconData icon, String label, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        leading: Icon(
          icon,
          size: 18,
          color: selected ? const Color(0xFF1565C0) : const Color(0xFF78909C),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? const Color(0xFF0A2540) : const Color(0xFF546E7A),
          ),
        ),
        selected: selected,
        selectedTileColor: const Color(0xFFE3F2FD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: () => Navigator.pop(context),
      ),
    );
  }

  // ─── Header Actions ─────────────────────────────────────────────────────────

  void _showActionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (_) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Actions',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                _actionTile(
                  icon: Icons.add_circle_outline_rounded,
                  label: 'Add Course',
                  color: const Color(0xFF0A2540),
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 12),
                _actionTile(
                  icon: Icons.upload_file_rounded,
                  label: 'Bulk Import',
                  color: const Color(0xFF1565C0),
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 12),
                _actionTile(
                  icon: Icons.cloud_upload_outlined,
                  label: 'Upload Evidence',
                  color: const Color(0xFF00897B),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: color, size: 14),
          ],
        ),
      ),
    );
  }

  // ─── Semester Toggle ─────────────────────────────────────────────────────────

  Widget _buildSemesterBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ODD / EVEN toggle
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _semesterTab('ODD', _isOdd),
                _semesterTab('EVEN', !_isOdd),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Year dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedYear,
                isDense: true,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0A2540),
                ),
                items:
                    ['2023-24', '2024-25', '2025-26']
                        .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                        .toList(),
                onChanged: (v) => setState(() => _selectedYear = v!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _semesterTab(String label, bool active) {
    return GestureDetector(
      onTap: () => setState(() => _isOdd = label == 'ODD'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF0A2540) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: active ? Colors.white : const Color(0xFF78909C),
          ),
        ),
      ),
    );
  }

  // ─── Course Cards ─────────────────────────────────────────────────────────────

  Widget _buildCourseCard(CourseEntry course, int index) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder:
          (context, child) => FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.08 * (index + 1)),
                end: Offset.zero,
              ).animate(_fadeAnimation),
              child: child,
            ),
          ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color:
                course.selected
                    ? const Color(0xFF1565C0).withOpacity(0.5)
                    : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => _showCourseDetail(course),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: checkbox + code badge + title + actions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: course.selected,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: const Color(0xFF1565C0),
                          onChanged:
                              (v) => setState(() => course.selected = v!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0A2540),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              course.code,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            course.title,
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0A2540),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      _buildFeedbackBadge(course.feedbackScore),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Stats row
                  Row(
                    children: [
                      _statChip(
                        Icons.people_outline,
                        '${course.classStrength}',
                        'Strength',
                      ),
                      const SizedBox(width: 8),
                      _statChip(Icons.schedule_outlined, course.ltp, 'L/T/P'),
                      const SizedBox(width: 8),
                      _statChip(
                        Icons.check_circle_outline,
                        '${course.sessionsDelivered}',
                        'Sessions',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Evidence row + action buttons
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              course.evidenceUploaded
                                  ? const Color(0xFFE8F5E9)
                                  : const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              course.evidenceUploaded
                                  ? Icons.check_circle_rounded
                                  : Icons.hourglass_top_rounded,
                              size: 14,
                              color:
                                  course.evidenceUploaded
                                      ? const Color(0xFF2E7D32)
                                      : const Color(0xFFE65100),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              course.evidenceUploaded
                                  ? 'Evidence uploaded'
                                  : 'Pending evidence',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color:
                                    course.evidenceUploaded
                                        ? const Color(0xFF2E7D32)
                                        : const Color(0xFFE65100),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      _iconAction(
                        Icons.edit_outlined,
                        const Color(0xFF1565C0),
                        () {},
                      ),
                      const SizedBox(width: 4),
                      _iconAction(
                        Icons.delete_outline_rounded,
                        const Color(0xFFE53935),
                        () {},
                      ),
                      const SizedBox(width: 4),
                      _iconAction(
                        Icons.picture_as_pdf_outlined,
                        const Color(0xFF546E7A),
                        () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statChip(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF546E7A)),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0A2540),
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Color(0xFF90A4AE)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackBadge(double score) {
    final Color color =
        score >= 4.4
            ? const Color(0xFF2E7D32)
            : score >= 4.0
            ? const Color(0xFF1565C0)
            : const Color(0xFFE65100);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            score.toString(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconAction(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 17, color: color),
      ),
    );
  }

  // ─── Course Detail Bottom Sheet ───────────────────────────────────────────────

  void _showCourseDetail(CourseEntry course) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => DraggableScrollableSheet(
            initialChildSize: 0.55,
            maxChildSize: 0.85,
            minChildSize: 0.35,
            builder:
                (_, controller) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: ListView(
                    controller: controller,
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0A2540),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              course.code,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              course.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0A2540),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _detailRow(
                        'Class Strength',
                        '${course.classStrength} students',
                      ),
                      _detailRow('L/T/P', course.ltp),
                      _detailRow(
                        'Sessions Delivered',
                        '${course.sessionsDelivered}',
                      ),
                      _detailRow(
                        'Feedback Score',
                        '${course.feedbackScore} / 5.0',
                      ),
                      _detailRow(
                        'Evidence',
                        course.evidenceUploaded ? 'Uploaded' : 'Pending',
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.edit_outlined, size: 18),
                              label: const Text('Edit'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.cloud_upload_outlined,
                                size: 18,
                              ),
                              label: const Text('Upload'),
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF0A2540),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF78909C),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0A2540),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Summary Stats Bar ─────────────────────────────────────────────────────

  Widget _buildSummaryStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A2540), Color(0xFF1565C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _summaryItem('2', 'Courses'),
          _vDivider(),
          _summaryItem('135', 'Students'),
          _vDivider(),
          _summaryItem('78', 'Sessions'),
          _vDivider(),
          _summaryItem('4.35', 'Avg Score'),
        ],
      ),
    );
  }

  Widget _summaryItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 11),
        ),
      ],
    );
  }

  Widget _vDivider() => Container(width: 1, height: 30, color: Colors.white24);

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      drawer: _buildDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2540),
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: const Text(
          'Teaching',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode_outlined, color: Colors.white70),
            onPressed: () {},
          ),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF1E3A5F),
            child: Icon(Icons.person, size: 18, color: Colors.white70),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: RefreshIndicator(
        color: const Color(0xFF0A2540),
        onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                child: Row(
                  children: [
                    const Text(
                      'Teaching Assignments',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0A2540),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: _showActionsSheet,
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: const Text('Actions'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF0A2540),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: _buildSummaryStats()),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 2),
                child: Text(
                  'Semester Overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0A2540),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: _buildSemesterBar()),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildCourseCard(_courses[index], index),
                childCount: _courses.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${_courses.length} of ${_courses.length} courses  •  ${_selectedYear} ${_isOdd ? "ODD" : "EVEN"} semester',
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF90A4AE),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showActionsSheet,
        backgroundColor: const Color(0xFF0A2540),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Course',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 4,
      ),
    );
  }
}
