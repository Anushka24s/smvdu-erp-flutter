import 'package:flutter/material.dart';
import 'app_navigation.dart';
import 'app_theme.dart';

// ─── Standalone entry ─────────────────────────────────────────────────────────
void main() => runApp(const _PubApp());

class _PubApp extends StatelessWidget {
  const _PubApp();
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
            home: const PublicationsPage(),
          ),
    );
  }
}

// ─── Models ───────────────────────────────────────────────────────────────────

class PublicationEntry {
  final String type;
  final String title;
  final String journal;
  final int year;
  final String indexing;
  final String authorship;
  final String evidence;
  bool selected;

  PublicationEntry({
    required this.type,
    required this.title,
    required this.journal,
    required this.year,
    required this.indexing,
    required this.authorship,
    required this.evidence,
    this.selected = false,
  });
}

class IpEntry {
  final String type;
  final String title;
  final String filingNo;
  final int year;
  final String status;
  bool selected;

  IpEntry({
    required this.type,
    required this.title,
    required this.filingNo,
    required this.year,
    required this.status,
    this.selected = false,
  });
}

// ─── Publications Page ────────────────────────────────────────────────────────

class PublicationsPage extends StatefulWidget {
  const PublicationsPage({super.key});

  @override
  State<PublicationsPage> createState() => _PublicationsPageState();
}

class _PublicationsPageState extends State<PublicationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  String _selectedIpType = 'Patent';

  final List<PublicationEntry> _pubs = [
    PublicationEntry(
      type: 'Journal',
      title: 'Sustainable AI in Smart Campuses',
      journal: 'IEEE Access',
      year: 2024,
      indexing: 'SCI',
      authorship: 'First Author',
      evidence: 'First page uploaded',
    ),
    PublicationEntry(
      type: 'Conference',
      title: 'Learning Analytics for Mentoring',
      journal: 'ACM L@S',
      year: 2023,
      indexing: 'Scopus',
      authorship: 'Corresponding',
      evidence: 'Indexing proof pending',
    ),
  ];

  final List<IpEntry> _ipEntries = [
    IpEntry(
      type: 'Patent',
      title: 'Smart Campus Energy Optimization System',
      filingNo: 'IN202311045231',
      year: 2023,
      status: 'Filed',
    ),
    IpEntry(
      type: 'Copyright',
      title: 'Learning Analytics Dashboard Software',
      filingNo: 'SW-2024-00821',
      year: 2024,
      status: 'Granted',
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
          _dItem(Icons.article_outlined, 'My Publications & IP', true),
          _dSub(Icons.library_books_outlined, 'Publications', true),
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
    final journals = _pubs.where((p) => p.type == 'Journal').length;
    final conferences = _pubs.where((p) => p.type == 'Conference').length;
    final sciCount = _pubs.where((p) => p.indexing == 'SCI').length;

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
          _stripStat('${_pubs.length}', 'Total\nPublications'),
          _vDiv(),
          _stripStat('$journals', 'Journals'),
          _vDiv(),
          _stripStat('$conferences', 'Conferences'),
          _vDiv(),
          _stripStat('$sciCount', 'SCI\nIndexed'),
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

  // ─── Publication Card ─────────────────────────────────────────────────────────

  Widget _buildPubCard(PublicationEntry p, int index) {
    final typeColor =
        p.type == 'Journal'
            ? const Color(0xFF1565C0)
            : p.type == 'Conference'
            ? const Color(0xFF6A1B9A)
            : const Color(0xFF00838F);
    final typeBg =
        p.type == 'Journal'
            ? const Color(0xFFE3F2FD)
            : p.type == 'Conference'
            ? const Color(0xFFF3E5F5)
            : const Color(0xFFE0F7FA);

    final indexColor =
        p.indexing == 'SCI' || p.indexing == 'SCIE'
            ? const Color(0xFF2E7D32)
            : p.indexing == 'Scopus'
            ? const Color(0xFFE65100)
            : const Color(0xFF546E7A);

    final evidenceUploaded =
        p.evidence.toLowerCase().contains('uploaded') ||
        p.evidence.toLowerCase().contains('first page');

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
            onTap: () => _showPubDetail(p),
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
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: typeBg,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    p.type,
                                    style: TextStyle(
                                      color: typeColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
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
                                    color: indexColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    p.indexing,
                                    style: TextStyle(
                                      color: indexColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
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
                                    color: const Color(0xFFF0F4F8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${p.year}',
                                    style: TextStyle(
                                      color: Color(0xFF546E7A),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
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

                  // Journal / Proceedings
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
                          Icons.menu_book_outlined,
                          size: 15,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            p.journal,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Text(
                          p.authorship,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  // Evidence + actions
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              evidenceUploaded
                                  ? const Color(0xFFE8F5E9)
                                  : const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              evidenceUploaded
                                  ? Icons.check_circle_rounded
                                  : Icons.hourglass_top_rounded,
                              size: 13,
                              color:
                                  evidenceUploaded
                                      ? const Color(0xFF2E7D32)
                                      : const Color(0xFFE65100),
                            ),
                            SizedBox(width: 5),
                            Text(
                              p.evidence,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color:
                                    evidenceUploaded
                                        ? const Color(0xFF2E7D32)
                                        : const Color(0xFFE65100),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  // ─── IP Card ──────────────────────────────────────────────────────────────────

  Widget _buildIpCard(IpEntry ip, int index) {
    final typeData = _ipTypeData(ip.type);
    final statusColor =
        ip.status == 'Granted'
            ? const Color(0xFF2E7D32)
            : ip.status == 'Filed'
            ? const Color(0xFF1565C0)
            : const Color(0xFFE65100);

    return AnimatedBuilder(
      animation: _fade,
      builder: (_, child) => FadeTransition(opacity: _fade, child: child),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
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
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: typeData['bg'] as Color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              typeData['icon'] as IconData,
                              size: 13,
                              color: typeData['color'] as Color,
                            ),
                            SizedBox(width: 5),
                            Text(
                              ip.type,
                              style: TextStyle(
                                color: typeData['color'] as Color,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F4F8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${ip.year}',
                          style: TextStyle(
                            color: Color(0xFF546E7A),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: statusColor.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          ip.status,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    ip.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 8),
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
                          Icons.tag_rounded,
                          size: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 6),
                        Text(
                          ip.filingNo,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF546E7A),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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

  Map<String, dynamic> _ipTypeData(String type) {
    switch (type) {
      case 'Patent':
        return {
          'color': const Color(0xFF0A2540),
          'bg': const Color(0xFFE3F2FD),
          'icon': Icons.lightbulb_outline,
        };
      case 'Copyright':
        return {
          'color': const Color(0xFFE65100),
          'bg': const Color(0xFFFFF3E0),
          'icon': Icons.copyright_outlined,
        };
      case 'Design':
        return {
          'color': const Color(0xFF6A1B9A),
          'bg': const Color(0xFFF3E5F5),
          'icon': Icons.design_services_outlined,
        };
      default:
        return {
          'color': const Color(0xFF00838F),
          'bg': const Color(0xFFE0F7FA),
          'icon': Icons.menu_book_outlined,
        };
    }
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

  // ─── Publication Detail Sheet ─────────────────────────────────────────────────

  void _showPubDetail(PublicationEntry p) {
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
                      Text(
                        p.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(color: Color(0xFFF0F4F8)),
                      SizedBox(height: 12),
                      _detRow('Type', p.type),
                      _detRow('Journal / Proceedings', p.journal),
                      _detRow('Year', '${p.year}'),
                      _detRow('Indexing', p.indexing),
                      _detRow('Authorship', p.authorship),
                      _detRow('Evidence', p.evidence),
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
                              label: Text('Upload Proof'),
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

  // ─── Add Publication Sheet ────────────────────────────────────────────────────

  void _showAddPubSheet() {
    String selectedType = 'Journal';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => StatefulBuilder(
            builder:
                (ctx, setModal) => DraggableScrollableSheet(
                  initialChildSize: 0.85,
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
                              'Add Publication',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Capture journals, conferences, books and chapters with mandatory proof.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Type selector
                            Text(
                              'Type',
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
                                  ['Journal', 'Conference', 'Book', 'Chapter']
                                      .map(
                                        (t) => ChoiceChip(
                                          label: Text(t),
                                          selected: selectedType == t,
                                          selectedColor: const Color(
                                            0xFF0A2540,
                                          ),
                                          labelStyle: TextStyle(
                                            color:
                                                selectedType == t
                                                    ? Colors.white
                                                    : const Color(0xFF37474F),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                          onSelected:
                                              (_) => setModal(
                                                () => selectedType = t,
                                              ),
                                        ),
                                      )
                                      .toList(),
                            ),
                            SizedBox(height: 16),
                            _addField(
                              'Title',
                              Icons.title_rounded,
                              maxLines: 2,
                            ),
                            SizedBox(height: 12),
                            _addField(
                              'Journal / Proceedings',
                              Icons.menu_book_outlined,
                            ),
                            SizedBox(height: 12),
                            _addField(
                              'Year',
                              Icons.calendar_today_outlined,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 12),
                            _addField(
                              'Indexing (SCI / Scopus / ABDC)',
                              Icons.analytics_outlined,
                            ),
                            SizedBox(height: 12),
                            _addField(
                              'Authorship Role',
                              Icons.person_outline_rounded,
                            ),
                            SizedBox(height: 20),

                            // Upload section
                            _uploadTile(
                              'Upload First Page',
                              Icons.upload_file_rounded,
                              'PDF, max 5MB',
                            ),
                            SizedBox(height: 10),
                            _uploadTile(
                              'Upload Indexing Proof',
                              Icons.verified_outlined,
                              'Screenshot or PDF',
                            ),

                            SizedBox(height: 24),
                            FilledButton.icon(
                              onPressed: () => Navigator.pop(ctx),
                              icon: Icon(Icons.add_rounded),
                              label: Text(
                                'Add Publication',
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

  // ─── Add IP Sheet ─────────────────────────────────────────────────────────────

  void _showAddIpSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => DraggableScrollableSheet(
            initialChildSize: 0.8,
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
                        'Record IP / Book',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Track filings and grants for patents, copyright, design registrations and books.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 20),

                      // IP type chips
                      Text(
                        'IP Type',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF546E7A),
                        ),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            [
                              'Patent',
                              'Copyright',
                              'Design',
                              'Book / Chapter',
                            ].map((t) {
                              final d = _ipTypeData(t.split(' /')[0]);
                              final sel = _selectedIpType == t.split(' /')[0];
                              return GestureDetector(
                                onTap:
                                    () => setState(
                                      () => _selectedIpType = t.split(' /')[0],
                                    ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        sel
                                            ? (d['color'] as Color)
                                            : (d['bg'] as Color),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: (d['color'] as Color).withOpacity(
                                        sel ? 0 : 0.3,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        d['icon'] as IconData,
                                        size: 14,
                                        color:
                                            sel
                                                ? Colors.white
                                                : d['color'] as Color,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        t,
                                        style: TextStyle(
                                          color:
                                              sel
                                                  ? Colors.white
                                                  : d['color'] as Color,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                      ),

                      SizedBox(height: 16),
                      _addField('Title', Icons.title_rounded, maxLines: 2),
                      SizedBox(height: 12),
                      _addField(
                        'Filing / Registration Number',
                        Icons.tag_rounded,
                      ),
                      SizedBox(height: 12),
                      _addField(
                        'Year',
                        Icons.calendar_today_outlined,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 12),
                      _addField(
                        'Status (Filed / Granted / Published)',
                        Icons.info_outline_rounded,
                      ),
                      SizedBox(height: 16),
                      _uploadTile(
                        'Upload Proof of Filing / Grant',
                        Icons.upload_file_rounded,
                        'PDF, max 5MB',
                      ),
                      SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.add_rounded),
                        label: Text(
                          'Record IP / Book',
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

  Widget _uploadTile(String label, IconData icon, String hint) {
    return InkWell(
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
              child: Icon(icon, color: const Color(0xFF1565C0), size: 18),
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
  }

  // ─── IP Type Filter Row ───────────────────────────────────────────────────────

  Widget _buildIpTypeFilter() {
    final types = ['Patent', 'Copyright', 'Design', 'Book'];
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: types.length,
        separatorBuilder: (_, __) => SizedBox(width: 8),
        itemBuilder: (_, i) {
          final t = types[i];
          final d = _ipTypeData(t);
          final sel = _selectedIpType == t;
          return GestureDetector(
            onTap: () => setState(() => _selectedIpType = t),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: sel ? d['color'] as Color : d['bg'] as Color,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: (d['color'] as Color).withOpacity(sel ? 0 : 0.25),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    d['icon'] as IconData,
                    size: 13,
                    color: sel ? Colors.white : d['color'] as Color,
                  ),
                  SizedBox(width: 5),
                  Text(
                    t,
                    style: TextStyle(
                      color: sel ? Colors.white : d['color'] as Color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final filteredIp =
        _selectedIpType == 'Book'
            ? _ipEntries.where((ip) => ip.type == 'Book / Chapter').toList()
            : _ipEntries.where((ip) => ip.type == _selectedIpType).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const FacultyNavigationDrawer(
        currentRoute: AppRoute.publications,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'Publications',
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
            // ── Page title ────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Publications &\nIntellectual Property',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                          height: 1.25,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    FilledButton.icon(
                      onPressed: _showAddPubSheet,
                      icon: Icon(Icons.add_rounded, size: 18),
                      label: Text('Add'),
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
              ),
            ),

            // ── Summary strip ─────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: _buildSummaryStrip(),
              ),
            ),

            // ── Info banner ───────────────────────────────────────────
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                padding: const EdgeInsets.all(13),
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
                        'Capture journals, conferences, books and chapters with mandatory first page and indexing proof.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF1565C0),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Publications section label ─────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 18, 16, 4),
                child: Text(
                  'Publications',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),

            // ── Publication cards ─────────────────────────────────────
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => _buildPubCard(_pubs[i], i),
                childCount: _pubs.length,
              ),
            ),

            // ── IP section ────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'IP, Patents & Books',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Track filings and grants for patents, copyright, design registrations and books.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: _showAddIpSheet,
                      icon: Icon(Icons.add_rounded, size: 16),
                      label: Text(
                        'Record',
                        style: TextStyle(fontSize: 13),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onSurface,
                        side: BorderSide(color: Theme.of(context).colorScheme.onSurface),
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
              ),
            ),

            // ── IP type filter ────────────────────────────────────────
            SliverToBoxAdapter(child: _buildIpTypeFilter()),
            SliverToBoxAdapter(child: SizedBox(height: 12)),

            // ── IP cards ─────────────────────────────────────────────
            filteredIp.isEmpty
                ? SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 36,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'No $_selectedIpType records yet',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => _buildIpCard(filteredIp[i], i),
                    childCount: filteredIp.length,
                  ),
                ),

            SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddPubSheet,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        icon: Icon(Icons.add_rounded),
        label: Text(
          'Add Publication',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 4,
      ),
    );
  }
}
