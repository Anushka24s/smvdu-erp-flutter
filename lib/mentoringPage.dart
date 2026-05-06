import 'package:flutter/material.dart';
import 'app_navigation.dart';
import 'app_theme.dart';
import 'package:smvdu_erp/publicationPage.dart';

// ─── Standalone entry (remove if embedding) ───────────────────────────────────
void main() => runApp(const _MentoringApp());

class _MentoringApp extends StatelessWidget {
  const _MentoringApp();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder:
          (_, mode, __) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: buildLightTheme(),
            darkTheme: buildDarkTheme(),
            themeMode: mode,
            home: const MentoringPage(),
          ),
    );
  }
}

// ─── Data Model ───────────────────────────────────────────────────────────────

class MeetingEntry {
  final String date;
  final int mentees;
  final String outcome;
  final bool minutesUploaded;
  bool selected;

  MeetingEntry({
    required this.date,
    required this.mentees,
    required this.outcome,
    required this.minutesUploaded,
    this.selected = false,
  });
}

// ─── Mentoring Page ───────────────────────────────────────────────────────────

class MentoringPage extends StatefulWidget {
  const MentoringPage({super.key});

  @override
  State<MentoringPage> createState() => _MentoringPageState();
}

class _MentoringPageState extends State<MentoringPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  final List<MeetingEntry> _meetings = [
    MeetingEntry(
      date: '05 Mar 2025',
      mentees: 12,
      outcome: 'Semester planning',
      minutesUploaded: true,
    ),
    MeetingEntry(
      date: '20 Feb 2025',
      mentees: 10,
      outcome: 'Internship guidance',
      minutesUploaded: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _goBackToDashboard(BuildContext drawerContext) async {
    Navigator.pop(drawerContext);
    await Future<void>.delayed(Duration.zero);
    if (!mounted) return;
    await Navigator.of(context).maybePop();
  }

  // ─── Drawer ──────────────────────────────────────────────────────────────────

  // ignore: unused_element
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFFFAFAFD),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
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
                  ),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Color(0xFF1E3A5F),
                    child: Icon(Icons.person, size: 36, color: Colors.white70),
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  'Faculty Member',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '23bee006@smvdu.ac.in',
                  style: TextStyle(color: Colors.white60, fontSize: 12.5),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          _dItem(
            Icons.dashboard_outlined,
            'Dashboard',
            false,
            onTap: () {
              _goBackToDashboard(context);
            },
          ),
          _dItem(
            Icons.person_outline,
            'My Profile',
            false,
            onTap: () => Navigator.pop(context),
          ),
          _dSection('Teaching & Mentoring'),
          _dItem(
            Icons.school_outlined,
            'My Teaching, Mentoring & Guidance',
            false,
          ),
          _dSub(
            Icons.menu_book_outlined,
            'Teaching',
            false,
            onTap: () => Navigator.pop(context),
          ),
          _dSub(
            Icons.group_outlined,
            'Mentoring',
            true,
            onTap: () => Navigator.pop(context),
          ),
          _dSub(
            Icons.lightbulb_outline,
            'Guidance',
            false,
            onTap: () => Navigator.pop(context),
          ),
          _dSection('Research'),
          _dItem(
            Icons.article_outlined,
            'My Publications & IP',
            false,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PublicationsPage()),
              );
            },
          ),
          _dSub(
            Icons.library_books_outlined,
            'Publications',
            false,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PublicationsPage()),
              );
            },
          ),
          _dSub(Icons.verified_outlined, 'IP & Patents', false),
          _dItem(
            Icons.business_center_outlined,
            'Projects & Consultancy',
            false,
          ),
          _dSection('Events & Service'),
          _dItem(
            Icons.event_note_outlined,
            'Conferences / FDP / Workshops',
            false,
          ),
          _dItem(Icons.campaign_outlined, 'Events Organized', false),
          _dItem(
            Icons.volunteer_activism_outlined,
            'Service & Outreach',
            false,
          ),
          _dSection('APR'),
          _dItem(Icons.assignment_outlined, 'APR', false),
          _dSub(Icons.edit_note_outlined, 'Prepare APR', false),
          _dSub(Icons.send_outlined, 'Preview & Submit', false),
          SizedBox(height: 8),
          Divider(indent: 16, endIndent: 16),
          _dItem(Icons.logout_rounded, 'Logout', false, isLogout: true),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _dSection(String label) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
    child: Text(
      label.toUpperCase(),
      style: TextStyle(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        letterSpacing: 1.2,
      ),
    ),
  );

  Widget _dItem(
    IconData icon,
    String label,
    bool selected, {
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    final color =
        isLogout
            ? Colors.red[400]!
            : selected
            ? const Color(0xFF1565C0)
            : const Color(0xFF546E7A);
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, size: 20, color: color),
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
      onTap: onTap ?? () => Navigator.pop(context),
    );
  }

  Widget _dSub(
    IconData icon,
    String label,
    bool selected, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
        onTap: onTap ?? () => Navigator.pop(context),
      ),
    );
  }

  // ─── Summary Strip ────────────────────────────────────────────────────────────

  Widget _buildSummaryStrip() {
    final uploaded = _meetings.where((m) => m.minutesUploaded).length;
    final pending = _meetings.where((m) => !m.minutesUploaded).length;
    final totalMentees = _meetings.fold<int>(0, (sum, m) => sum + m.mentees);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A2540), Color(0xFF1565C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _stripStat('${_meetings.length}', 'Meetings'),
          _vDiv(),
          _stripStat('$totalMentees', 'Total\nMentees'),
          _vDiv(),
          _stripStat('$uploaded', 'Minutes\nUploaded'),
          _vDiv(),
          _stripStat('$pending', 'Evidence\nPending'),
        ],
      ),
    );
  }

  Widget _stripStat(String v, String l) => Column(
    children: [
      Text(
        v,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(height: 2),
      Text(
        l,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white60,
          fontSize: 11,
          height: 1.3,
        ),
      ),
    ],
  );

  Widget _vDiv() =>
      Container(width: 1, height: 36, color: Colors.white.withOpacity(0.2));

  // ─── Meeting Card ─────────────────────────────────────────────────────────────

  Widget _buildMeetingCard(MeetingEntry m, int index) {
    final statusColor =
        m.minutesUploaded ? const Color(0xFF2E7D32) : const Color(0xFFE65100);
    final statusBg =
        m.minutesUploaded ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0);
    final statusIcon =
        m.minutesUploaded
            ? Icons.check_circle_rounded
            : Icons.hourglass_top_rounded;
    final statusLabel =
        m.minutesUploaded ? 'Minutes uploaded' : 'Evidence pending';

    return AnimatedBuilder(
      animation: _fade,
      builder:
          (_, child) => FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.07 * (index + 1)),
                end: Offset.zero,
              ).animate(_fade),
              child: child,
            ),
          ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                m.selected
                    ? const Color(0xFF1565C0).withOpacity(0.4)
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
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _showDetail(m),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top row ───────────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Checkbox
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: m.selected,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: const Color(0xFF1565C0),
                          onChanged: (v) => setState(() => m.selected = v!),
                        ),
                      ),
                      SizedBox(width: 10),

                      // Date badge + outcome
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date chip
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onSurface,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 12,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    m.date,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              m.outcome,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Mentees badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${m.mentees}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1565C0),
                              ),
                            ),
                            Text(
                              'mentees',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF1565C0),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 14),
                  Divider(height: 1, color: Color(0xFFF0F4F8)),
                  SizedBox(height: 12),

                  // ── Bottom row ────────────────────────────────────
                  Row(
                    children: [
                      // Evidence status
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(statusIcon, size: 14, color: statusColor),
                            SizedBox(width: 5),
                            Text(
                              statusLabel,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Action buttons
                      _iconBtn(
                        Icons.edit_outlined,
                        const Color(0xFF1565C0),
                        () {},
                      ),
                      SizedBox(width: 4),
                      _iconBtn(
                        Icons.delete_outline_rounded,
                        const Color(0xFFE53935),
                        () {},
                      ),
                      SizedBox(width: 4),
                      _iconBtn(
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

  Widget _iconBtn(IconData icon, Color color, VoidCallback onTap) {
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

  // ─── Detail Sheet ─────────────────────────────────────────────────────────────

  void _showDetail(MeetingEntry m) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => DraggableScrollableSheet(
            initialChildSize: 0.55,
            maxChildSize: 0.85,
            minChildSize: 0.4,
            builder:
                (_, ctrl) => Container(
                  decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: ListView(
                    controller: ctrl,
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
                      SizedBox(height: 20),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  size: 13,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  m.date,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              m.outcome,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),
                      Divider(color: Color(0xFFF0F4F8)),
                      SizedBox(height: 16),

                      _detRow('Date', m.date),
                      _detRow('Mentees Present', '${m.mentees}'),
                      _detRow('Outcome / Topic', m.outcome),
                      _detRow(
                        'Evidence Status',
                        m.minutesUploaded ? 'Minutes uploaded' : 'Pending',
                      ),

                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.edit_outlined, size: 18),
                              label: Text('Edit'),
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
                          SizedBox(width: 12),
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.upload_file_rounded,
                                size: 18,
                              ),
                              label: Text('Upload Minutes'),
                              style: FilledButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
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

  Widget _detRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.5,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    ),
  );

  // ─── Log Meeting Sheet ────────────────────────────────────────────────────────

  void _showLogMeetingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => DraggableScrollableSheet(
            initialChildSize: 0.75,
            maxChildSize: 0.95,
            minChildSize: 0.5,
            builder:
                (_, ctrl) => Container(
                  decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: ListView(
                    controller: ctrl,
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
                      SizedBox(height: 20),

                      Text(
                        'Log Meeting',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Record mentoring session details and upload meeting minutes.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),

                      SizedBox(height: 24),

                      _addField(
                        'Meeting Date',
                        Icons.calendar_today_outlined,
                        hint: 'e.g. 05 Mar 2025',
                      ),
                      SizedBox(height: 14),
                      _addField(
                        'Number of Mentees',
                        Icons.people_outline_rounded,
                        hint: 'e.g. 12',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 14),
                      _addField(
                        'Outcome / Topic',
                        Icons.topic_outlined,
                        hint: 'e.g. Semester planning',
                        maxLines: 2,
                      ),
                      SizedBox(height: 14),

                      // Upload minutes button
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F4FF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFD0DCFF),
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF1565C0,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.upload_file_rounded,
                                  color: Color(0xFF1565C0),
                                  size: 22,
                                ),
                              ),
                              SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Upload Meeting Minutes',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1565C0),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'PDF or DOCX, max 5MB',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 28),

                      // Info note
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFBBDEFB)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 16,
                              color: Color(0xFF1565C0),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Upload minutes of meeting to be eligible for points in APR.',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFF1565C0),
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),

                      FilledButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.check_rounded),
                        label: Text(
                          'Save Meeting',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  Widget _addField(
    String label,
    IconData icon, {
    String? hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(color: Color(0xFFB0BEC5)),
        prefixIcon: Icon(icon, size: 18, color: Theme.of(context).colorScheme.onSurfaceVariant),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFE0E7EF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFE0E7EF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF1565C0), width: 1.5),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const FacultyNavigationDrawer(currentRoute: AppRoute.mentoring),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'Mentoring',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        actions: [
          ThemeToggleButton(),
          CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF1E3A5F),
            child: Icon(Icons.person, size: 18, color: Colors.white70),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.primary,
        onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // ── Page header ───────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Mentoring Records',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.onSurface,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const Spacer(),
                        FilledButton.icon(
                          onPressed: _showLogMeetingSheet,
                          icon: Icon(Icons.add_rounded, size: 18),
                          label: Text('Log meeting'),
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
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
                    SizedBox(height: 12),

                    // Info banner
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFBBDEFB)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 18,
                            color: Color(0xFF1565C0),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Upload minutes of meeting to be eligible for points in APR.',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF1565C0),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Summary strip ─────────────────────────────────────────
            SliverToBoxAdapter(child: _buildSummaryStrip()),

            // ── Section label ─────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 4),
                child: Text(
                  'Meetings',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),

            // ── Cards ─────────────────────────────────────────────────
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => _buildMeetingCard(_meetings[i], i),
                childCount: _meetings.length,
              ),
            ),

            // ── Footer ───────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${_meetings.length} of ${_meetings.length} records',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showLogMeetingSheet,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        icon: Icon(Icons.add_rounded),
        label: Text(
          'Log Meeting',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 4,
      ),
    );
  }
}
