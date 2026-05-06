import 'package:flutter/material.dart';

class AppRoute {
  static const dashboard = '/dashboard';
  static const profile = '/profile';
  static const teaching = '/teaching';
  static const mentoring = '/mentoring';
  static const guidance = '/guidance';
  static const publications = '/publications';
  static const patents = '/patents';
  static const projects = '/projects';
  static const conferences = '/conferences';
  static const eventsOrganized = '/events-organized';
  static const service = '/service';
  static const prepareApr = '/prepare-apr';
  static const previewApr = '/preview-apr';
  static const login = '/login';
}

class FacultyNavigationDrawer extends StatelessWidget {
  final String currentRoute;

  const FacultyNavigationDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final drawerBg = theme.drawerTheme.backgroundColor ??
        (isDark ? const Color(0xFF161B22) : const Color(0xFFFAFAFD));

    return Drawer(
      backgroundColor: drawerBg,
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
                        color: Colors.black.withValues(alpha: 0.2),
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
          _drawerItem(
            context,
            Icons.dashboard_outlined,
            'Dashboard',
            AppRoute.dashboard,
          ),
          _drawerSection('Teaching & Mentoring'),
          _drawerItem(
            context,
            Icons.school_outlined,
            'My Teaching, Mentoring & Guidance',
            AppRoute.teaching,
          ),
          _drawerSubItem(
            context,
            Icons.menu_book_outlined,
            'Teaching',
            AppRoute.teaching,
          ),
          _drawerSubItem(
            context,
            Icons.group_outlined,
            'Mentoring',
            AppRoute.mentoring,
          ),
          _drawerSubItem(
            context,
            Icons.lightbulb_outline,
            'Guidance',
            AppRoute.guidance,
          ),
          _drawerSection('Research'),
          _drawerItem(
            context,
            Icons.article_outlined,
            'My Publications & IP',
            AppRoute.publications,
          ),
          _drawerSubItem(
            context,
            Icons.library_books_outlined,
            'Publications',
            AppRoute.publications,
          ),
          _drawerSubItem(
            context,
            Icons.verified_outlined,
            'IP & Patents',
            AppRoute.patents,
          ),
          _drawerItem(
            context,
            Icons.business_center_outlined,
            'Projects & Consultancy',
            AppRoute.projects,
          ),
          _drawerSection('Events & Service'),
          _drawerItem(
            context,
            Icons.event_note_outlined,
            'Conferences / FDP / Workshops',
            AppRoute.conferences,
          ),
          _drawerItem(
            context,
            Icons.campaign_outlined,
            'Events Organized',
            AppRoute.eventsOrganized,
          ),
          _drawerItem(
            context,
            Icons.volunteer_activism_outlined,
            'Service & Outreach',
            AppRoute.service,
          ),
          _drawerSection('APR'),
          _drawerItem(
            context,
            Icons.assignment_outlined,
            'APR',
            AppRoute.prepareApr,
          ),
          _drawerSubItem(
            context,
            Icons.edit_note_outlined,
            'Prepare APR',
            AppRoute.prepareApr,
          ),
          _drawerSubItem(
            context,
            Icons.send_outlined,
            'Preview & Submit',
            AppRoute.previewApr,
          ),
          const SizedBox(height: 8),
          const Divider(indent: 16, endIndent: 16),
          _drawerItem(
            context,
            Icons.logout_rounded,
            'Logout',
            AppRoute.login,
            isLogout: true,
            replaceAll: true,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _drawerSection(String label) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color:
                  isDark ? const Color(0xFF8B949E) : const Color(0xFF90A4AE),
              letterSpacing: 1.2,
            ),
          ),
        );
      },
    );
  }

  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String label,
    String route, {
    bool isLogout = false,
    bool replaceAll = false,
  }) {
    final selected = currentRoute == route;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isLogout
            ? Colors.red[400]!
            : selected
            ? Theme.of(context).colorScheme.primary
            : isDark
            ? const Color(0xFF8B949E)
            : const Color(0xFF546E7A);
    final titleColor =
        isLogout
            ? Colors.red[400]
            : selected
            ? (isDark ? const Color(0xFFE6EDF3) : const Color(0xFF0A2540))
            : (isDark ? const Color(0xFFC9D1D9) : const Color(0xFF37474F));
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, size: 20, color: color),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          color: titleColor,
        ),
      ),
      selected: selected,
      selectedTileColor:
          isDark ? const Color(0xFF1F2A37) : const Color(0xFFE3F2FD),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: () => _goTo(context, route, replaceAll: replaceAll),
    );
  }

  Widget _drawerSubItem(
    BuildContext context,
    IconData icon,
    String label,
    String route,
  ) {
    final selected = currentRoute == route;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: Icon(
          icon,
          size: 18,
          color:
              selected
                  ? Theme.of(context).colorScheme.primary
                  : isDark
                  ? const Color(0xFF8B949E)
                  : const Color(0xFF78909C),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color:
                selected
                    ? (isDark
                        ? const Color(0xFFE6EDF3)
                        : const Color(0xFF0A2540))
                    : (isDark
                        ? const Color(0xFFC9D1D9)
                        : const Color(0xFF546E7A)),
          ),
        ),
        selected: selected,
        selectedTileColor:
            isDark ? const Color(0xFF1F2A37) : const Color(0xFFE3F2FD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: () => _goTo(context, route),
      ),
    );
  }

  void _goTo(BuildContext context, String route, {bool replaceAll = false}) {
    Navigator.pop(context);
    if (currentRoute == route) return;

    if (replaceAll) {
      Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
      return;
    }

    Navigator.pushReplacementNamed(context, route);
  }
}
