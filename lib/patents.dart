import 'package:flutter/material.dart';
import 'app_navigation.dart';
import 'app_theme.dart';

class IpRecord {
  final String type;
  final String applicationNo;
  final String filedOn;
  final String publishedGranted;
  final String status;
  final String proof;
  bool selected;

  IpRecord({
    required this.type,
    required this.applicationNo,
    required this.filedOn,
    required this.publishedGranted,
    required this.status,
    required this.proof,
    this.selected = false,
  });
}

class IpPatentsPage extends StatefulWidget {
  const IpPatentsPage({super.key});

  @override
  State<IpPatentsPage> createState() => _IpPatentsPageState();
}

class _IpPatentsPageState extends State<IpPatentsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  String _filterType = 'All';

  final List<IpRecord> _records = [
    IpRecord(
      type: 'Patent',
      applicationNo: '2024/DEL/01234',
      filedOn: '10 Jan 2024',
      publishedGranted: '12 Jun 2024',
      status: 'Published',
      proof: 'Publication Gazette',
    ),
    IpRecord(
      type: 'Copyright',
      applicationNo: 'L-123456/2023',
      filedOn: '04 Sep 2023',
      publishedGranted: '18 Dec 2023',
      status: 'Registered',
      proof: 'Certificate uploaded',
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

  // ─── Type helpers ─────────────────────────────────────────────────────────────

  Map<String, dynamic> _typeData(String type) {
    switch (type) {
      case 'Patent':
        return {
          'color': const Color(0xFF0A2540),
          'bg': const Color(0xFFE3F2FD),
          'icon': Icons.lightbulb_outline_rounded,
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
      case 'Trademark':
        return {
          'color': const Color(0xFF00838F),
          'bg': const Color(0xFFE0F7FA),
          'icon': Icons.verified_outlined,
        };
      default:
        return {
          'color': const Color(0xFF546E7A),
          'bg': const Color(0xFFF0F4F8),
          'icon': Icons.article_outlined,
        };
    }
  }

  Map<String, dynamic> _statusData(String status) {
    switch (status) {
      case 'Granted':
      case 'Registered':
        return {
          'color': const Color(0xFF2E7D32),
          'bg': const Color(0xFFE8F5E9),
          'icon': Icons.check_circle_rounded,
        };
      case 'Published':
        return {
          'color': const Color(0xFF1565C0),
          'bg': const Color(0xFFE3F2FD),
          'icon': Icons.public_rounded,
        };
      case 'Filed':
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
          _dItem(Icons.article_outlined, 'My Publications & IP', true),
          _dSub(Icons.library_books_outlined, 'Publications', false),
          _dSub(Icons.verified_outlined, 'IP & Patents', true),
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
    final patents = _records.where((r) => r.type == 'Patent').length;
    final copyrights = _records.where((r) => r.type == 'Copyright').length;
    final granted =
        _records
            .where((r) => r.status == 'Granted' || r.status == 'Registered')
            .length;

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
          _stripStat('${_records.length}', 'Total\nRecords'),
          _vDiv(),
          _stripStat('$patents', 'Patents'),
          _vDiv(),
          _stripStat('$copyrights', 'Copyrights'),
          _vDiv(),
          _stripStat('$granted', 'Granted /\nRegistered'),
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

  // ─── Filter Chips ─────────────────────────────────────────────────────────────

  Widget _buildFilterRow() {
    final filters = ['All', 'Patent', 'Copyright', 'Design', 'Trademark'];
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8),
        itemBuilder: (_, i) {
          final f = filters[i];
          final sel = _filterType == f;
          final d =
              f == 'All'
                  ? {
                    'color': const Color(0xFF0A2540),
                    'bg': const Color(0xFFE3F2FD),
                    'icon': Icons.filter_list_rounded,
                  }
                  : _typeData(f);
          return GestureDetector(
            onTap: () => setState(() => _filterType = f),
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
                    f,
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

  // ─── IP Record Card ───────────────────────────────────────────────────────────

  Widget _buildRecordCard(IpRecord r, int index) {
    final td = _typeData(r.type);
    final sd = _statusData(r.status);
    final proofUploaded =
        r.proof.toLowerCase().contains('uploaded') ||
        r.proof.toLowerCase().contains('gazette') ||
        r.proof.toLowerCase().contains('certificate');

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
                r.selected
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
            onTap: () => _showDetail(r),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top row ──────────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: r.selected,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: const Color(0xFF1565C0),
                          onChanged: (v) => setState(() => r.selected = v!),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Type badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: td['bg'] as Color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        td['icon'] as IconData,
                                        size: 12,
                                        color: td['color'] as Color,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        r.type,
                                        style: TextStyle(
                                          color: td['color'] as Color,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                // Status badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: sd['bg'] as Color,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: (sd['color'] as Color).withOpacity(
                                        0.3,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        sd['icon'] as IconData,
                                        size: 12,
                                        color: sd['color'] as Color,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        r.status,
                                        style: TextStyle(
                                          color: sd['color'] as Color,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            // Application number — prominent
                            Text(
                              r.applicationNo,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.onSurface,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // ── Dates row ─────────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: _dateChip(
                          Icons.upload_rounded,
                          'Filed',
                          r.filedOn,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _dateChip(
                          Icons.check_circle_outline_rounded,
                          'Published / Granted',
                          r.publishedGranted,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Divider(height: 1, color: Color(0xFFF0F4F8)),
                  SizedBox(height: 10),

                  // ── Proof + actions ───────────────────────────────
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              proofUploaded
                                  ? const Color(0xFFE8F5E9)
                                  : const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              proofUploaded
                                  ? Icons.check_circle_rounded
                                  : Icons.hourglass_top_rounded,
                              size: 13,
                              color:
                                  proofUploaded
                                      ? const Color(0xFF2E7D32)
                                      : const Color(0xFFE65100),
                            ),
                            SizedBox(width: 5),
                            Text(
                              r.proof,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color:
                                    proofUploaded
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

  Widget _dateChip(IconData icon, String label, String value) {
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
              Icon(icon, size: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
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

  // ─── Detail Sheet ─────────────────────────────────────────────────────────────

  void _showDetail(IpRecord r) {
    final td = _typeData(r.type);
    final sd = _statusData(r.status);

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
                              color: td['bg'] as Color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  td['icon'] as IconData,
                                  size: 14,
                                  color: td['color'] as Color,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  r.type,
                                  style: TextStyle(
                                    color: td['color'] as Color,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: sd['bg'] as Color,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: (sd['color'] as Color).withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  sd['icon'] as IconData,
                                  size: 14,
                                  color: sd['color'] as Color,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  r.status,
                                  style: TextStyle(
                                    color: sd['color'] as Color,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),
                      Text(
                        r.applicationNo,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                          letterSpacing: 0.3,
                        ),
                      ),

                      SizedBox(height: 20),
                      Divider(color: Color(0xFFF0F4F8)),
                      SizedBox(height: 12),

                      _detRow('Type', r.type),
                      _detRow('Application No.', r.applicationNo),
                      _detRow('Filed On', r.filedOn),
                      _detRow('Published / Granted', r.publishedGranted),
                      _detRow('Status', r.status),
                      _detRow('Proof', r.proof),

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

  // ─── Add Record Sheet ─────────────────────────────────────────────────────────

  void _showAddSheet() {
    String selType = 'Patent';
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
                              'Add Record',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Maintain complete lifecycle including filed, published and granted dates.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Type selector
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
                                    'Trademark',
                                  ].map((t) {
                                    final d = _typeData(t);
                                    final sel = selType == t;
                                    return GestureDetector(
                                      onTap: () => setModal(() => selType = t),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 180,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              sel
                                                  ? d['color'] as Color
                                                  : d['bg'] as Color,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: (d['color'] as Color)
                                                .withOpacity(sel ? 0 : 0.3),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              d['icon'] as IconData,
                                              size: 13,
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

                            SizedBox(height: 18),
                            _field(
                              'Application / Registration No.',
                              Icons.tag_rounded,
                            ),
                            SizedBox(height: 12),
                            _field(
                              'Filed On',
                              Icons.upload_rounded,
                              hint: 'e.g. 10 Jan 2024',
                            ),
                            SizedBox(height: 12),
                            _field(
                              'Published / Granted Date',
                              Icons.check_circle_outline_rounded,
                              hint: 'e.g. 12 Jun 2024',
                            ),
                            SizedBox(height: 12),
                            _field(
                              'Status',
                              Icons.info_outline_rounded,
                              hint: 'Filed / Published / Granted / Registered',
                            ),

                            SizedBox(height: 18),

                            // Upload proof tile
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F4FF),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFD0DCFF),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF1565C0,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.upload_file_rounded,
                                        color: Color(0xFF1565C0),
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Upload Sanction / Grant Letter',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1565C0),
                                            ),
                                          ),
                                          Text(
                                            'PDF, max 5MB',
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
                            ),

                            SizedBox(height: 14),

                            // Info note
                            Container(
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFBBDEFB),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    size: 15,
                                    color: Color(0xFF1565C0),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Upload sanction or grant letters as evidence. Detailed forms with status timelines can be configured per record type.',
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

                            SizedBox(height: 24),
                            FilledButton.icon(
                              onPressed: () => Navigator.pop(ctx),
                              icon: Icon(Icons.add_rounded),
                              label: Text(
                                'Add Record',
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

  Widget _field(
    String label,
    IconData icon, {
    String? hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
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
    final filtered =
        _filterType == 'All'
            ? _records
            : _records.where((r) => r.type == _filterType).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const FacultyNavigationDrawer(currentRoute: AppRoute.patents),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'IP & Patents',
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
            // Page title + Add button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Patents, Copyright\n& Design',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                          height: 1.25,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: _showAddSheet,
                      icon: Icon(Icons.add_rounded, size: 18),
                      label: Text('Add record'),
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

            // Summary strip
            SliverToBoxAdapter(child: _buildSummaryStrip()),

            // Info banner
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
                        'Maintain complete lifecycle including filed, published and granted dates. Upload sanction or grant letters as evidence.',
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

            // Section label
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 18, 16, 10),
                child: Text(
                  'Filing History',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),

            // Filter chips
            SliverToBoxAdapter(child: _buildFilterRow()),
            SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Cards
            filtered.isEmpty
                ? SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 40,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No $_filterType records yet',
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
                    (_, i) => _buildRecordCard(filtered[i], i),
                    childCount: filtered.length,
                  ),
                ),

            // Footer count
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${filtered.length} of ${_records.length} records',
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
          'Add Record',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 4,
      ),
    );
  }
}
