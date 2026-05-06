import 'package:flutter/material.dart';
import 'app_navigation.dart';
import 'app_theme.dart';
import 'publicationPage.dart';

// ─── Data Model ───────────────────────────────────────────────────────────────

class SuperviseeEntry {
  final String program;
  final String student;
  final int regYear;
  final String ftPt;
  final String title;
  final String outcome;
  final bool synopsisUploaded;
  bool selected;

  SuperviseeEntry({
    required this.program,
    required this.student,
    required this.regYear,
    required this.ftPt,
    required this.title,
    required this.outcome,
    required this.synopsisUploaded,
    this.selected = false,
  });
}

// ─── Guidance Page ────────────────────────────────────────────────────────────

class GuidancePage extends StatefulWidget {
  const GuidancePage({super.key});

  @override
  State<GuidancePage> createState() => _GuidancePageState();
}

class _GuidancePageState extends State<GuidancePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  final List<SuperviseeEntry> _supervisees = [
    SuperviseeEntry(
      program: 'PhD',
      student: 'Anita Sharma',
      regYear: 2021,
      ftPt: 'FT',
      title: 'AI for Healthcare',
      outcome: 'Submitted',
      synopsisUploaded: true,
    ),
    SuperviseeEntry(
      program: 'M.Tech',
      student: 'Rahul Verma',
      regYear: 2023,
      ftPt: 'PT',
      title: 'Edge Computing',
      outcome: 'In Progress',
      synopsisUploaded: false,
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

          // Dashboard — navigates back
          _dItem(
            Icons.dashboard_outlined,
            'Dashboard',
            false,
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
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
            false,
            onTap: () => Navigator.pop(context),
          ),
          _dSub(
            Icons.lightbulb_outline,
            'Guidance',
            true,
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
    final submitted =
        _supervisees.where((s) => s.outcome == 'Submitted').length;
    final inProgress =
        _supervisees.where((s) => s.outcome == 'In Progress').length;
    final pending = _supervisees.where((s) => !s.synopsisUploaded).length;

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
          _stripStat('${_supervisees.length}', 'Total'),
          _vDiv(),
          _stripStat('$submitted', 'Submitted'),
          _vDiv(),
          _stripStat('$inProgress', 'In Progress'),
          _vDiv(),
          _stripStat('$pending', 'Pending\nSynopsis'),
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

  // ─── Supervisee Card ──────────────────────────────────────────────────────────

  Widget _buildCard(SuperviseeEntry s, int index) {
    final outcomeColor =
        s.outcome == 'Submitted'
            ? const Color(0xFF2E7D32)
            : s.outcome == 'In Progress'
            ? const Color(0xFF1565C0)
            : const Color(0xFFE65100);

    final programColor =
        s.program == 'PhD'
            ? const Color(0xFF6A1B9A)
            : s.program == 'M.Tech'
            ? const Color(0xFF00838F)
            : const Color(0xFF0A2540);

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
                s.selected
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
            onTap: () => _showDetail(s),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top row ──────────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Checkbox
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: s.selected,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: const Color(0xFF1565C0),
                          onChanged: (v) => setState(() => s.selected = v!),
                        ),
                      ),
                      SizedBox(width: 10),

                      // Program badge + student name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: programColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    s.program,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F4F8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    s.ftPt,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF546E7A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text(
                              s.student,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Outcome badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: outcomeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: outcomeColor.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          s.outcome,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: outcomeColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // ── Research title ────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.auto_stories_outlined,
                          size: 15,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            s.title,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12),

                  // ── Bottom row ────────────────────────────────────
                  Row(
                    children: [
                      // Reg year chip
                      _chip(
                        Icons.calendar_today_outlined,
                        'Reg. ${s.regYear}',
                        const Color(0xFF546E7A),
                      ),
                      SizedBox(width: 8),

                      // Synopsis status
                      _chip(
                        s.synopsisUploaded
                            ? Icons.check_circle_rounded
                            : Icons.hourglass_top_rounded,
                        s.synopsisUploaded
                            ? 'Synopsis uploaded'
                            : 'Pending synopsis',
                        s.synopsisUploaded
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFE65100),
                        filled: true,
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

  Widget _chip(
    IconData icon,
    String label,
    Color color, {
    bool filled = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: filled ? color.withOpacity(0.1) : const Color(0xFFF0F4F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
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

  // ─── Detail Bottom Sheet ──────────────────────────────────────────────────────

  void _showDetail(SuperviseeEntry s) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => DraggableScrollableSheet(
            initialChildSize: 0.6,
            maxChildSize: 0.9,
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

                      // Header
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
                            child: Text(
                              s.program,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              s.student,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        s.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF546E7A),
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: 24),
                      Divider(color: Color(0xFFF0F4F8)),
                      SizedBox(height: 16),

                      _detRow('Program', s.program),
                      _detRow('Student', s.student),
                      _detRow('Registration Year', '${s.regYear}'),
                      _detRow(
                        'Full Time / Part Time',
                        s.ftPt == 'FT' ? 'Full Time' : 'Part Time',
                      ),
                      _detRow('Research Title', s.title),
                      _detRow('Outcome', s.outcome),
                      _detRow(
                        'Synopsis',
                        s.synopsisUploaded ? 'Uploaded' : 'Pending',
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
                              label: Text('Upload Synopsis'),
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

  // ─── Add Supervisee Sheet ─────────────────────────────────────────────────────

  void _showAddSheet() {
    String selectedProgram = 'PhD';
    String selectedFtPt = 'FT';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => StatefulBuilder(
            builder:
                (ctx, setModalState) => DraggableScrollableSheet(
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
                              'Add Supervisee',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Capture UG/PG/PhD supervision details and milestones.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(height: 24),

                            // Program selector
                            Text(
                              'Program',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF546E7A),
                              ),
                            ),
                            SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children:
                                  ['PhD', 'M.Tech', 'M.Sc', 'B.Tech']
                                      .map(
                                        (p) => ChoiceChip(
                                          label: Text(p),
                                          selected: selectedProgram == p,
                                          selectedColor: const Color(
                                            0xFF0A2540,
                                          ),
                                          labelStyle: TextStyle(
                                            color:
                                                selectedProgram == p
                                                    ? Colors.white
                                                    : const Color(0xFF37474F),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                          onSelected:
                                              (_) => setModalState(
                                                () => selectedProgram = p,
                                              ),
                                        ),
                                      )
                                      .toList(),
                            ),

                            SizedBox(height: 18),
                            _addField('Student Name', Icons.person_outline),
                            SizedBox(height: 14),
                            _addField(
                              'Research Title',
                              Icons.auto_stories_outlined,
                              maxLines: 2,
                            ),
                            SizedBox(height: 14),
                            _addField(
                              'Registration Year',
                              Icons.calendar_today_outlined,
                              keyboardType: TextInputType.number,
                            ),

                            SizedBox(height: 18),
                            // FT/PT
                            Text(
                              'Full Time / Part Time',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF546E7A),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _ftPtChip(
                                    'Full Time',
                                    'FT',
                                    selectedFtPt == 'FT',
                                    (v) {
                                      setModalState(() => selectedFtPt = v);
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: _ftPtChip(
                                    'Part Time',
                                    'PT',
                                    selectedFtPt == 'PT',
                                    (v) {
                                      setModalState(() => selectedFtPt = v);
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 28),
                            FilledButton.icon(
                              onPressed: () => Navigator.pop(ctx),
                              icon: Icon(Icons.add_rounded),
                              label: Text(
                                'Add Supervisee',
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
          ),
    );
  }

  Widget _addField(
    String label,
    IconData icon, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
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

  Widget _ftPtChip(
    String label,
    String value,
    bool selected,
    Function(String) onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF0A2540) : const Color(0xFFF0F4F8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : const Color(0xFF78909C),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const FacultyNavigationDrawer(currentRoute: AppRoute.guidance),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'Guidance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        // ← Back button auto-appears when pushed via Navigator.push
        actions: [
          IconButton(
            icon: ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder:
                  (_, mode, __) => Icon(
                    mode == ThemeMode.dark
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    color: Colors.white70,
                  ),
            ),
            onPressed: () {
              toggleAppTheme();
            },
          ),
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
            // Page title + info card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Guidance',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.onSurface,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const Spacer(),
                        FilledButton.icon(
                          onPressed: _showAddSheet,
                          icon: Icon(Icons.add_rounded, size: 18),
                          label: Text('Add supervisee'),
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
                              'Capture guidance for UG/PG/PhD, including co-supervisors, submission milestones and outcome evidence.',
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

            // Summary strip
            SliverToBoxAdapter(child: _buildSummaryStrip()),

            // Section header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 4),
                child: Text(
                  'Supervision Records',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),

            // Cards
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => _buildCard(_supervisees[i], i),
                childCount: _supervisees.length,
              ),
            ),

            // Footer count
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${_supervisees.length} of ${_supervisees.length} records',
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
        onPressed: _showAddSheet,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        icon: Icon(Icons.add_rounded),
        label: Text(
          'Add Supervisee',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 4,
      ),
    );
  }
}
