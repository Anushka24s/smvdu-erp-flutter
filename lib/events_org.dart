import 'package:flutter/material.dart';
import 'app_navigation.dart';
import 'app_theme.dart';

void main() => runApp(const _ConfApp());

class _ConfApp extends StatelessWidget {
  const _ConfApp();
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
            home: const ConferencesAttendedPage(),
          ),
    );
  }
}

// ─── Model ────────────────────────────────────────────────────────────────────

class AttendedEvent {
  final String type;
  final String title;
  final String role;
  final String duration;
  final String organizer;
  final String level;
  final String proof;
  bool selected;

  AttendedEvent({
    required this.type,
    required this.title,
    required this.role,
    required this.duration,
    required this.organizer,
    required this.level,
    required this.proof,
    this.selected = false,
  });
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class ConferencesAttendedPage extends StatefulWidget {
  const ConferencesAttendedPage({super.key});

  @override
  State<ConferencesAttendedPage> createState() =>
      _ConferencesAttendedPageState();
}

class _ConferencesAttendedPageState extends State<ConferencesAttendedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  String _filterType = 'All';

  final List<AttendedEvent> _events = [
    AttendedEvent(
      type: 'Conference',
      title: 'IEEE Education Society Summit',
      role: 'Paper presentation',
      duration: '2 days',
      organizer: 'IEEE',
      level: 'International (India)',
      proof: 'Certificate uploaded',
    ),
    AttendedEvent(
      type: 'FDP',
      title: 'AI Pedagogy for Higher Education',
      role: 'Attended',
      duration: '5 days',
      organizer: 'AICTE',
      level: 'National',
      proof: 'Pending certificate',
    ),
    AttendedEvent(
      type: 'Workshop',
      title: 'Deep Learning with PyTorch',
      role: 'Resource Person',
      duration: '3 days',
      organizer: 'NIT Srinagar',
      level: 'Regional',
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

  // ─── Style helpers ────────────────────────────────────────────────────────────

  Map<String, dynamic> _typeStyle(String type) {
    switch (type) {
      case 'Conference':
        return {
          'color': const Color(0xFF0A2540),
          'bg': const Color(0xFFE3F2FD),
          'icon': Icons.groups_rounded,
        };
      case 'FDP':
        return {
          'color': const Color(0xFF6A1B9A),
          'bg': const Color(0xFFF3E5F5),
          'icon': Icons.school_outlined,
        };
      case 'Workshop':
        return {
          'color': const Color(0xFF00838F),
          'bg': const Color(0xFFE0F7FA),
          'icon': Icons.build_outlined,
        };
      case 'MOOC':
        return {
          'color': const Color(0xFFE65100),
          'bg': const Color(0xFFFFF3E0),
          'icon': Icons.play_circle_outline_rounded,
        };
      default:
        return {
          'color': const Color(0xFF546E7A),
          'bg': const Color(0xFFF0F4F8),
          'icon': Icons.event_outlined,
        };
    }
  }

  Map<String, dynamic> _levelStyle(String level) {
    if (level.toLowerCase().contains('international')) {
      return {
        'color': const Color(0xFF1565C0),
        'bg': const Color(0xFFE3F2FD),
        'icon': Icons.public_rounded,
      };
    } else if (level.toLowerCase().contains('national')) {
      return {
        'color': const Color(0xFF2E7D32),
        'bg': const Color(0xFFE8F5E9),
        'icon': Icons.flag_outlined,
      };
    } else {
      return {
        'color': const Color(0xFF78909C),
        'bg': const Color(0xFFF0F4F8),
        'icon': Icons.location_on_outlined,
      };
    }
  }

  Map<String, dynamic> _roleStyle(String role) {
    switch (role) {
      case 'Paper presentation':
        return {
          'color': const Color(0xFF0A2540),
          'bg': const Color(0xFFE8EAF6),
        };
      case 'Resource Person':
      case 'Chair':
      case 'Invited Lecture':
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
            false,
          ),
          _dSection('Events & Service'),
          _dItem(
            Icons.event_note_outlined,
            'Conferences / FDP / Workshops',
            true,
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
    final conferences = _events.where((e) => e.type == 'Conference').length;
    final fdps = _events.where((e) => e.type == 'FDP').length;
    final certUploaded =
        _events.where((e) => e.proof.toLowerCase().contains('uploaded')).length;

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
          _stat('${_events.length}', 'Total\nEvents'),
          _vDiv(),
          _stat('$conferences', 'Conferences'),
          _vDiv(),
          _stat('$fdps', 'FDPs'),
          _vDiv(),
          _stat('$certUploaded', 'Certificates\nUploaded'),
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

  // ─── Filter Row ───────────────────────────────────────────────────────────────

  Widget _buildFilterRow() {
    final filters = ['All', 'Conference', 'FDP', 'Workshop', 'MOOC'];
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
                  : _typeStyle(f);
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

  // ─── Event Card ───────────────────────────────────────────────────────────────

  Widget _buildCard(AttendedEvent e, int index) {
    final td = _typeStyle(e.type);
    final ld = _levelStyle(e.level);
    final rd = _roleStyle(e.role);
    final certOk = e.proof.toLowerCase().contains('uploaded');

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
                e.selected
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
            onTap: () => _showDetail(e),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top row ───────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: e.selected,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: const Color(0xFF1565C0),
                          onChanged: (v) => setState(() => e.selected = v!),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges row
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: [
                                _badge(
                                  e.type,
                                  td['color'] as Color,
                                  td['bg'] as Color,
                                  icon: td['icon'] as IconData,
                                ),
                                _badge(
                                  e.level,
                                  ld['color'] as Color,
                                  ld['bg'] as Color,
                                  icon: ld['icon'] as IconData,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              e.title,
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

                  // ── Info row ──────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: _infoChip(
                          Icons.person_outline_rounded,
                          'Role',
                          e.role,
                          rd,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _infoChip(
                          Icons.schedule_outlined,
                          'Duration',
                          e.duration,
                          null,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Organizer
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
                          Icons.apartment_rounded,
                          size: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 8),
                        Text(
                          e.organizer,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  Divider(height: 1, color: Color(0xFFF0F4F8)),
                  SizedBox(height: 10),

                  // ── Proof + actions ───────────────────────────
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              certOk
                                  ? const Color(0xFFE8F5E9)
                                  : const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              certOk
                                  ? Icons.check_circle_rounded
                                  : Icons.hourglass_top_rounded,
                              size: 13,
                              color:
                                  certOk
                                      ? const Color(0xFF2E7D32)
                                      : const Color(0xFFE65100),
                            ),
                            SizedBox(width: 5),
                            Text(
                              e.proof,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color:
                                    certOk
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

  Widget _badge(String label, Color color, Color bg, {IconData? icon}) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 11, color: color),
              SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );

  Widget _infoChip(
    IconData icon,
    String label,
    String value,
    Map<String, dynamic>? style,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: style != null ? (style['bg'] as Color) : const Color(0xFFF5F7FA),
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
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color:
                  style != null
                      ? (style['color'] as Color)
                      : const Color(0xFF0A2540),
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

  void _showDetail(AttendedEvent e) {
    final td = _typeStyle(e.type);
    final ld = _levelStyle(e.level);

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
                      Wrap(
                        spacing: 8,
                        children: [
                          _badge(
                            e.type,
                            td['color'] as Color,
                            td['bg'] as Color,
                            icon: td['icon'] as IconData,
                          ),
                          _badge(
                            e.level,
                            ld['color'] as Color,
                            ld['bg'] as Color,
                            icon: ld['icon'] as IconData,
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        e.title,
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
                      _detRow('Event Type', e.type),
                      _detRow('Role', e.role),
                      _detRow('Duration', e.duration),
                      _detRow('Organizer', e.organizer),
                      _detRow('Level', e.level),
                      _detRow('Proof / Certificate', e.proof),
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
                              label: Text('Upload Certificate'),
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

  // ─── Add Event Sheet ──────────────────────────────────────────────────────────

  void _showAddSheet() {
    String selType = 'Conference';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => StatefulBuilder(
            builder:
                (ctx, setModal) => DraggableScrollableSheet(
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
                              'Add Event',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Include role, duration and attach certificates. Use MOOC for online courses.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Event type selector
                            Text(
                              'Event Type',
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
                                    'Conference',
                                    'FDP',
                                    'Workshop',
                                    'MOOC',
                                  ].map((t) {
                                    final d = _typeStyle(t);
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
                              'Event Title',
                              Icons.title_rounded,
                              maxLines: 2,
                            ),
                            SizedBox(height: 12),
                            _field(
                              'Role',
                              Icons.person_outline_rounded,
                              hint:
                                  'Paper presentation / Attended / Chair / Invited Lecture',
                            ),
                            SizedBox(height: 12),
                            _field(
                              'Duration',
                              Icons.schedule_outlined,
                              hint: 'e.g. 2 days, 5 days',
                            ),
                            SizedBox(height: 12),
                            _field('Organizer', Icons.apartment_rounded),
                            SizedBox(height: 12),
                            _field(
                              'Level',
                              Icons.public_rounded,
                              hint: 'International / National / Regional',
                            ),
                            SizedBox(height: 16),

                            // Upload certificate
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
                                            'Upload Certificate',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1565C0),
                                            ),
                                          ),
                                          Text(
                                            'PDF or image, max 5MB',
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
                                      'Include role (presentation/chair/invited lecture), duration and attach certificates. Use MOOC for online courses.',
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
                                'Add Event',
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
        hintStyle: TextStyle(color: Color(0xFFB0BEC5), fontSize: 12),
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
            ? _events
            : _events.where((e) => e.type == _filterType).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const FacultyNavigationDrawer(
        currentRoute: AppRoute.eventsOrganized,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'Conferences / FDP / Workshops',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
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
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Conferences / FDP /\nWorkshops (Attended)',
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
                      label: Text('Add event'),
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
                        'Include role (presentation/chair/invited lecture), duration and attach certificates. Use the MOOC tab for online courses.',
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
                  'Events Attended',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),

            // Filter row
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
                          'No $_filterType events yet',
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
                    (_, i) => _buildCard(filtered[i], i),
                    childCount: filtered.length,
                  ),
                ),

            // Footer
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${filtered.length} of ${_events.length} records',
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
          'Add Event',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 4,
      ),
    );
  }
}
