import 'package:flutter/material.dart';
import 'app_navigation.dart';
import 'app_theme.dart';

void main() => runApp(const _ProjApp());

class _ProjApp extends StatelessWidget {
  const _ProjApp();
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
            home: const ProjectsConsultancyPage(),
          ),
    );
  }
}

// ─── Models ───────────────────────────────────────────────────────────────────

class SponsoredProject {
  final String title;
  final String agency;
  final String amount;
  final String duration;
  final String role;
  final String status;
  final String proof;
  bool selected;

  SponsoredProject({
    required this.title,
    required this.agency,
    required this.amount,
    required this.duration,
    required this.role,
    required this.status,
    required this.proof,
    this.selected = false,
  });
}

class ConsultancyEntry {
  final String title;
  final String client;
  final String totalCost;
  final String duration;
  final String consultants;
  final String status;
  final String proof;
  bool selected;

  ConsultancyEntry({
    required this.title,
    required this.client,
    required this.totalCost,
    required this.duration,
    required this.consultants,
    required this.status,
    required this.proof,
    this.selected = false,
  });
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class ProjectsConsultancyPage extends StatefulWidget {
  const ProjectsConsultancyPage({super.key});

  @override
  State<ProjectsConsultancyPage> createState() =>
      _ProjectsConsultancyPageState();
}

class _ProjectsConsultancyPageState extends State<ProjectsConsultancyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  final List<SponsoredProject> _projects = [
    SponsoredProject(
      title: 'Smart Campus Energy Optimization',
      agency: 'SERB',
      amount: '₹45,00,000',
      duration: '2023–2026',
      role: 'PI',
      status: 'Ongoing',
      proof: 'Sanction letter uploaded',
    ),
    SponsoredProject(
      title: 'AI-Based Crop Disease Detection',
      agency: 'DST',
      amount: '₹28,50,000',
      duration: '2022–2025',
      role: 'Co-PI',
      status: 'Completed',
      proof: 'Completion report uploaded',
    ),
  ];

  final List<ConsultancyEntry> _consultancies = [
    ConsultancyEntry(
      title: 'AI Strategy Workshop',
      client: 'TechCorp Pvt Ltd',
      totalCost: '₹3,50,000',
      duration: 'Jan 2025 – Mar 2025',
      consultants: 'Dr. Sharma, Dr. Verma',
      status: 'Completed',
      proof: 'Work order uploaded',
    ),
    ConsultancyEntry(
      title: 'Data Analytics Pipeline Design',
      client: 'FinServ India',
      totalCost: '₹1,80,000',
      duration: 'Mar 2025 – Jun 2025',
      consultants: 'Dr. Sharma',
      status: 'Ongoing',
      proof: 'Agreement pending',
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

  // ─── Helpers ─────────────────────────────────────────────────────────────────

  Map<String, dynamic> _statusStyle(String status) {
    switch (status) {
      case 'Completed':
        return {
          'color': const Color(0xFF2E7D32),
          'bg': const Color(0xFFE8F5E9),
          'icon': Icons.check_circle_rounded,
        };
      case 'Ongoing':
        return {
          'color': const Color(0xFF1565C0),
          'bg': const Color(0xFFE3F2FD),
          'icon': Icons.timelapse_rounded,
        };
      case 'Submitted':
        return {
          'color': const Color(0xFF6A1B9A),
          'bg': const Color(0xFFF3E5F5),
          'icon': Icons.send_rounded,
        };
      default:
        return {
          'color': const Color(0xFFE65100),
          'bg': const Color(0xFFFFF3E0),
          'icon': Icons.hourglass_top_rounded,
        };
    }
  }

  Map<String, dynamic> _roleStyle(String role) {
    switch (role) {
      case 'PI':
        return {
          'color': const Color(0xFF0A2540),
          'bg': const Color(0xFFE3F2FD),
        };
      case 'Co-PI':
        return {
          'color': const Color(0xFF6A1B9A),
          'bg': const Color(0xFFF3E5F5),
        };
      default:
        return {
          'color': const Color(0xFF546E7A),
          'bg': const Color(0xFFF0F4F8),
        };
    }
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
              Navigator.pop(context);
              Navigator.popUntil(context, (r) => r.isFirst);
            },
          ),
          _dItem(Icons.person_outline, 'My Profile', false),
          _dSection('Teaching & Mentoring'),
          _dItem(
            Icons.school_outlined,
            'My Teaching, Mentoring & Guidance',
            false,
          ),
          _dSub(Icons.menu_book_outlined, 'Teaching', false),
          _dSub(Icons.group_outlined, 'Mentoring', false),
          _dSub(Icons.lightbulb_outline, 'Guidance', false),
          _dSection('Research'),
          _dItem(Icons.article_outlined, 'My Publications & IP', false),
          _dSub(Icons.library_books_outlined, 'Publications', false),
          _dSub(Icons.verified_outlined, 'IP & Patents', false),
          _dItem(
            Icons.business_center_outlined,
            'Projects & Consultancy',
            true,
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

  Widget _dSection(String l) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
    child: Text(
      l.toUpperCase(),
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
    final c =
        isLogout
            ? Colors.red[400]!
            : selected
            ? const Color(0xFF1565C0)
            : const Color(0xFF546E7A);
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, size: 20, color: c),
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
    final ongoing = _projects.where((p) => p.status == 'Ongoing').length;
    final totalFunding = '₹73.5L';
    final consultDone =
        _consultancies.where((c) => c.status == 'Completed').length;

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
          _stat('${_projects.length}', 'Projects'),
          _vDiv(),
          _stat('$ongoing', 'Ongoing'),
          _vDiv(),
          _stat(totalFunding, 'Total\nFunding'),
          _vDiv(),
          _stat('${_consultancies.length}', 'Consultancies'),
        ],
      ),
    );
  }

  Widget _stat(String v, String l) => Column(
    children: [
      Text(
        v,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
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

  // ─── Sponsored Project Card ───────────────────────────────────────────────────

  Widget _buildProjectCard(SponsoredProject p, int index) {
    final ss = _statusStyle(p.status);
    final rs = _roleStyle(p.role);
    final proofOk = p.proof.toLowerCase().contains('uploaded');

    return _animatedCard(
      index: index,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                p.selected
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
            onTap: () => _showProjectDetail(p),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: p.selected,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: const Color(0xFF1565C0),
                          onChanged: (v) => setState(() => p.selected = v!),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Role badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: rs['bg'] as Color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    p.role,
                                    style: TextStyle(
                                      color: rs['color'] as Color,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                // Agency badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F4F8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    p.agency,
                                    style: TextStyle(
                                      color: Color(0xFF546E7A),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                // Status
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ss['bg'] as Color,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: (ss['color'] as Color).withOpacity(
                                        0.3,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        ss['icon'] as IconData,
                                        size: 11,
                                        color: ss['color'] as Color,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        p.status,
                                        style: TextStyle(
                                          color: ss['color'] as Color,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              p.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // Amount + Duration row
                  Row(
                    children: [
                      Expanded(
                        child: _infoChip(
                          Icons.currency_rupee_rounded,
                          'Sanctioned',
                          p.amount,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _infoChip(
                          Icons.date_range_outlined,
                          'Duration',
                          p.duration,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Divider(height: 1, color: Color(0xFFF0F4F8)),
                  SizedBox(height: 10),

                  // Proof + actions
                  Row(
                    children: [
                      _proofChip(p.proof, proofOk),
                      const Spacer(),
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

  // ─── Consultancy Card ─────────────────────────────────────────────────────────

  Widget _buildConsultancyCard(ConsultancyEntry c, int index) {
    final ss = _statusStyle(c.status);
    final proofOk = c.proof.toLowerCase().contains('uploaded');

    return _animatedCard(
      index: index + _projects.length,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                c.selected
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
            onTap: () => _showConsultancyDetail(c),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: c.selected,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: const Color(0xFF1565C0),
                          onChanged: (v) => setState(() => c.selected = v!),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Client badge
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE0F7FA),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      c.client,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xFF00838F),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ss['bg'] as Color,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: (ss['color'] as Color).withOpacity(
                                        0.3,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        ss['icon'] as IconData,
                                        size: 11,
                                        color: ss['color'] as Color,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        c.status,
                                        style: TextStyle(
                                          color: ss['color'] as Color,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              c.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // Cost + Duration
                  Row(
                    children: [
                      Expanded(
                        child: _infoChip(
                          Icons.currency_rupee_rounded,
                          'Total Cost',
                          c.totalCost,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _infoChip(
                          Icons.date_range_outlined,
                          'Duration',
                          c.duration,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Consultants
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people_outline_rounded,
                          size: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            c.consultants,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  Divider(height: 1, color: Color(0xFFF0F4F8)),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      _proofChip(c.proof, proofOk),
                      const Spacer(),
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

  // ─── Shared Widgets ───────────────────────────────────────────────────────────

  Widget _animatedCard({required int index, required Widget child}) {
    return AnimatedBuilder(
      animation: _fade,
      builder:
          (_, c) => FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.06 * (index + 1)),
                end: Offset.zero,
              ).animate(_fade),
              child: c,
            ),
          ),
      child: child,
    );
  }

  Widget _infoChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
              SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _proofChip(String proof, bool uploaded) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: uploaded ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            uploaded ? Icons.check_circle_rounded : Icons.hourglass_top_rounded,
            size: 13,
            color: uploaded ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
          ),
          SizedBox(width: 5),
          Text(
            proof,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color:
                  uploaded ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, Color color, VoidCallback onTap) => InkWell(
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

  // ─── Detail Sheets ────────────────────────────────────────────────────────────

  void _showProjectDetail(SponsoredProject p) {
    final ss = _statusStyle(p.status);
    _showDetailSheet(
      title: p.title,
      headerWidgets: [
        _detailBadge(p.role, _roleStyle(p.role)),
        SizedBox(width: 8),
        _detailBadge(p.agency, {
          'color': const Color(0xFF546E7A),
          'bg': const Color(0xFFF0F4F8),
        }),
        SizedBox(width: 8),
        _statusBadge(p.status, ss),
      ],
      rows: [
        _detRow('Agency', p.agency),
        _detRow('Sanctioned Amount', p.amount),
        _detRow('Duration', p.duration),
        _detRow('Role', p.role),
        _detRow('Status', p.status),
        _detRow('Proof', p.proof),
      ],
      uploadLabel: 'Upload Sanction Letter',
    );
  }

  void _showConsultancyDetail(ConsultancyEntry c) {
    final ss = _statusStyle(c.status);
    _showDetailSheet(
      title: c.title,
      headerWidgets: [
        _detailBadge(c.client, {
          'color': const Color(0xFF00838F),
          'bg': const Color(0xFFE0F7FA),
        }),
        SizedBox(width: 8),
        _statusBadge(c.status, ss),
      ],
      rows: [
        _detRow('Client', c.client),
        _detRow('Total Cost', c.totalCost),
        _detRow('Duration', c.duration),
        _detRow('Consultants', c.consultants),
        _detRow('Status', c.status),
        _detRow('Proof', c.proof),
      ],
      uploadLabel: 'Upload Work Order',
    );
  }

  void _showDetailSheet({
    required String title,
    required List<Widget> headerWidgets,
    required List<Widget> rows,
    required String uploadLabel,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => DraggableScrollableSheet(
            initialChildSize: 0.65,
            maxChildSize: 0.92,
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
                      Wrap(spacing: 6, children: headerWidgets),
                      SizedBox(height: 12),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(color: Color(0xFFF0F4F8)),
                      SizedBox(height: 8),
                      ...rows,
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
                              label: Text(
                                uploadLabel,
                                style: TextStyle(fontSize: 12),
                              ),
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

  Widget _detailBadge(String label, Map<String, dynamic> style) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: style['bg'] as Color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: style['color'] as Color,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _statusBadge(String status, Map<String, dynamic> ss) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: ss['bg'] as Color,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: (ss['color'] as Color).withOpacity(0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(ss['icon'] as IconData, size: 12, color: ss['color'] as Color),
        SizedBox(width: 4),
        Text(
          status,
          style: TextStyle(
            color: ss['color'] as Color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );

  Widget _detRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
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
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    ),
  );

  // ─── Add Sheets ───────────────────────────────────────────────────────────────

  void _showAddProjectSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => DraggableScrollableSheet(
            initialChildSize: 0.88,
            maxChildSize: 0.95,
            minChildSize: 0.6,
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
                      _sheetHandle(),
                      SizedBox(height: 20),
                      Text(
                        'Add Sponsored Project',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Capture sponsored projects with sanction details, PI/Co-PI roles and status updates.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 20),
                      _field('Project Title', Icons.title_rounded, maxLines: 2),
                      SizedBox(height: 12),
                      _field('Funding Agency', Icons.account_balance_outlined),
                      SizedBox(height: 12),
                      _field(
                        'Sanctioned Amount (₹)',
                        Icons.currency_rupee_rounded,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 12),
                      _field(
                        'Duration (e.g. 2023–2026)',
                        Icons.date_range_outlined,
                      ),
                      SizedBox(height: 12),
                      _field('Role (PI / Co-PI)', Icons.person_outline_rounded),
                      SizedBox(height: 12),
                      _field(
                        'Status',
                        Icons.info_outline_rounded,
                        hint: 'Ongoing / Completed / Submitted',
                      ),
                      SizedBox(height: 16),
                      _uploadTile(
                        'Upload Sanction Letter',
                        Icons.upload_file_rounded,
                        'PDF, max 5MB',
                      ),
                      SizedBox(height: 24),
                      _submitBtn('Add Project', () => Navigator.pop(context)),
                    ],
                  ),
                ),
          ),
    );
  }

  void _showAddConsultancySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => DraggableScrollableSheet(
            initialChildSize: 0.88,
            maxChildSize: 0.95,
            minChildSize: 0.6,
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
                      _sheetHandle(),
                      SizedBox(height: 20),
                      Text(
                        'Add Consultancy',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Maintain consultancy work orders with fee distribution and completion status.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 20),
                      _field(
                        'Consultancy Title',
                        Icons.title_rounded,
                        maxLines: 2,
                      ),
                      SizedBox(height: 12),
                      _field(
                        'Client / Organisation',
                        Icons.business_center_outlined,
                      ),
                      SizedBox(height: 12),
                      _field(
                        'Total Cost (₹)',
                        Icons.currency_rupee_rounded,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 12),
                      _field(
                        'Duration',
                        Icons.date_range_outlined,
                        hint: 'e.g. Jan 2025 – Mar 2025',
                      ),
                      SizedBox(height: 12),
                      _field(
                        'Consultants (names)',
                        Icons.people_outline_rounded,
                        maxLines: 2,
                      ),
                      SizedBox(height: 12),
                      _field(
                        'Status',
                        Icons.info_outline_rounded,
                        hint: 'Ongoing / Completed',
                      ),
                      SizedBox(height: 16),
                      _uploadTile(
                        'Upload Work Order / Agreement',
                        Icons.upload_file_rounded,
                        'PDF, max 5MB',
                      ),
                      SizedBox(height: 24),
                      _submitBtn(
                        'Add Consultancy',
                        () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  Widget _sheetHandle() => Center(
    child: Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );

  Widget _field(
    String label,
    IconData icon, {
    int maxLines = 1,
    String? hint,
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

  Widget _uploadTile(String label, IconData icon, String hint) => InkWell(
    onTap: () {},
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD0DCFF), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF1565C0), size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1565C0),
                  ),
                ),
                Text(
                  hint,
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 13,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    ),
  );

  Widget _submitBtn(String label, VoidCallback onTap) => FilledButton.icon(
    onPressed: onTap,
    icon: Icon(Icons.add_rounded),
    label: Text(
      label,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
    ),
    style: FilledButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  // ─── Section Header ───────────────────────────────────────────────────────────

  Widget _sectionHeader(
    String title,
    String subtitle,
    VoidCallback onAdd,
    String btnLabel,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              FilledButton.icon(
                onPressed: onAdd,
                icon: Icon(Icons.add_rounded, size: 16),
                label: Text(btnLabel, style: TextStyle(fontSize: 12)),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.5,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final canGoBack = Navigator.of(context).canPop();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer:
          canGoBack
              ? null
              : const FacultyNavigationDrawer(currentRoute: AppRoute.projects),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'Projects & Consultancy',
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
            // Page title
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                child: Text(
                  'Projects & Consultancy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ),

            // Summary strip
            SliverToBoxAdapter(child: _buildSummaryStrip()),

            // ── Sponsored Projects ────────────────────────────────────
            SliverToBoxAdapter(
              child: _sectionHeader(
                'Sponsored Projects',
                'Capture sponsored projects with sanction details, PI/Co-PI roles and status updates.',
                _showAddProjectSheet,
                'Add sponsored project',
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => _buildProjectCard(_projects[i], i),
                childCount: _projects.length,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                child: Text(
                  '${_projects.length} of ${_projects.length} projects',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // ── Consultancy ───────────────────────────────────────────
            SliverToBoxAdapter(
              child: _sectionHeader(
                'Consultancy',
                'Maintain consultancy work orders with fee distribution and completion status.',
                _showAddConsultancySheet,
                'Add consultancy',
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => _buildConsultancyCard(_consultancies[i], i),
                childCount: _consultancies.length,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${_consultancies.length} of ${_consultancies.length} consultancies',
                  style: TextStyle(
                    fontSize: 12,
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
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'consult',
            onPressed: _showAddConsultancySheet,
            backgroundColor: const Color(0xFF1565C0),
            foregroundColor: Colors.white,
            mini: true,
            child: Icon(Icons.handshake_outlined),
          ),
          SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'project',
            onPressed: _showAddProjectSheet,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
            icon: Icon(Icons.add_rounded),
            label: Text(
              'Add Project',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            elevation: 4,
          ),
        ],
      ),
    );
  }
}
