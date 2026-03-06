import 'package:flutter/material.dart';

// ─── Standalone entry (remove if embedding) ───────────────────────────────────

// ─── Profile Screen ───────────────────────────────────────────────────────────

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<_TabMeta> _tabs = const [
    _TabMeta(Icons.person_outline_rounded, 'Personal'),
    _TabMeta(Icons.work_outline_rounded, 'Employment'),
    _TabMeta(Icons.account_tree_outlined, 'Dept. Map'),
    _TabMeta(Icons.school_outlined, 'Qualifications'),
    _TabMeta(Icons.biotech_outlined, 'Research'),
    _TabMeta(Icons.badge_outlined, 'Identifiers'),
    _TabMeta(Icons.account_balance_outlined, 'Bank / PAN'),
    _TabMeta(Icons.location_on_outlined, 'Address'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ─── Shared Drawer ──────────────────────────────────────────────────────────

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
          _dItem(Icons.dashboard_outlined, 'Dashboard', false),
          _dItem(Icons.person_outline, 'My Profile', true),
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
          const SizedBox(height: 8),
          const Divider(indent: 16, endIndent: 16),
          _dItem(Icons.logout_rounded, 'Logout', false, isLogout: true),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _dSection(String label) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
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

  Widget _dItem(
    IconData icon,
    String label,
    bool selected, {
    bool isLogout = false,
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
      onTap: () => Navigator.pop(context),
    );
  }

  Widget _dSub(IconData icon, String label, bool selected) => Padding(
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
      onTap: () => Navigator.pop(context),
    ),
  );

  // ─── Tab Pill Selector ──────────────────────────────────────────────────────

  Widget _buildTabSelector() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile header row inside the white area
          Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0A2540), Color(0xFF1565C0)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0A2540).withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'FM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Faculty Member',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A2540),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Assistant Professor • CSE',
                    style: TextStyle(fontSize: 12.5, color: Color(0xFF78909C)),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Scrollable tab bar
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: const Color(0xFF78909C),
            labelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            indicator: BoxDecoration(
              color: const Color(0xFF0A2540),
              borderRadius: BorderRadius.circular(20),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.symmetric(vertical: 6),
            labelPadding: const EdgeInsets.symmetric(horizontal: 4),
            dividerColor: Colors.transparent,
            tabs:
                _tabs
                    .map(
                      (t) => Tab(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(t.icon, size: 14),
                              const SizedBox(width: 5),
                              Text(t.label),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  // ─── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FB),
      drawer: _buildDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2540),
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
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
      body: Column(
        children: [
          _buildTabSelector(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _PersonalTab(),
                _PlaceholderTab(
                  icon: Icons.work_outline_rounded,
                  label: 'Employment',
                  description:
                      'Your employment history and current position details.',
                ),
                _PlaceholderTab(
                  icon: Icons.account_tree_outlined,
                  label: 'Department Mapping',
                  description:
                      'Course and department assignments for this academic year.',
                ),
                _PlaceholderTab(
                  icon: Icons.school_outlined,
                  label: 'Qualifications',
                  description:
                      'Academic degrees, certifications and credentials.',
                ),
                _PlaceholderTab(
                  icon: Icons.biotech_outlined,
                  label: 'Research Areas',
                  description:
                      'Your active research interests and specializations.',
                ),
                _PlaceholderTab(
                  icon: Icons.badge_outlined,
                  label: 'Identifiers',
                  description:
                      'ORCID, Scopus, Google Scholar and other research IDs.',
                ),
                _PlaceholderTab(
                  icon: Icons.account_balance_outlined,
                  label: 'Bank / PAN',
                  description:
                      'Bank account and PAN card details for salary processing.',
                ),
                _PlaceholderTab(
                  icon: Icons.location_on_outlined,
                  label: 'Address',
                  description: 'Permanent and correspondence address details.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab Meta ─────────────────────────────────────────────────────────────────

class _TabMeta {
  final IconData icon;
  final String label;
  const _TabMeta(this.icon, this.label);
}

// ─── Personal Tab ─────────────────────────────────────────────────────────────

class _PersonalTab extends StatefulWidget {
  @override
  State<_PersonalTab> createState() => _PersonalTabState();
}

class _PersonalTabState extends State<_PersonalTab> {
  final _nameCtrl = TextEditingController(text: 'Faculty Member');
  final _designCtrl = TextEditingController(text: 'Assistant Professor');
  final _phoneCtrl = TextEditingController(text: '+91-9999999999');
  final _emailCtrl = TextEditingController(text: 'faculty@smvdu.ac.in');
  final _deptCtrl = TextEditingController(
    text: 'Computer Science & Engineering',
  );
  final _empIdCtrl = TextEditingController(text: 'SMVDU-FAC-2019-042');

  bool _saved = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _designCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _deptCtrl.dispose();
    _empIdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Avatar upload card ──────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 14,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0A2540), Color(0xFF1565C0)],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0A2540).withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'FM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1565C0),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.edit_rounded,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profile Photo',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0A2540),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'JPG or PNG, max 2MB',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _outlineBtn(Icons.upload_rounded, 'Upload', () {}),
                            const SizedBox(width: 8),
                            _outlineBtn(
                              Icons.description_outlined,
                              'Upload CV',
                              () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Form fields ─────────────────────────────────────────────
            _sectionLabel('Basic Information'),
            const SizedBox(height: 10),
            _fieldCard(
              children: [
                _field(
                  _nameCtrl,
                  'Full Name',
                  Icons.person_outline,
                  required: true,
                ),
                _divider(),
                _field(
                  _designCtrl,
                  'Designation',
                  Icons.work_outline,
                  required: true,
                ),
              ],
            ),

            const SizedBox(height: 14),
            _sectionLabel('Contact Details'),
            const SizedBox(height: 10),
            _fieldCard(
              children: [
                _field(
                  _phoneCtrl,
                  'Phone',
                  Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                _divider(),
                _field(
                  _emailCtrl,
                  'Email',
                  Icons.email_outlined,
                  required: true,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                ),
              ],
            ),

            const SizedBox(height: 14),
            _sectionLabel('Academic Details'),
            const SizedBox(height: 10),
            _fieldCard(
              children: [
                _field(_deptCtrl, 'Department', Icons.account_tree_outlined),
                _divider(),
                _field(
                  _empIdCtrl,
                  'Employee ID',
                  Icons.badge_outlined,
                  readOnly: true,
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ── Save button ────────────────────────────────────────────
            _SaveButton(
              saved: _saved,
              onPressed: () {
                FocusScope.of(context).unfocus();
                setState(() => _saved = true);
                Future.delayed(
                  const Duration(seconds: 2),
                  () => setState(() => _saved = false),
                );
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) => Text(
    label,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: Color(0xFF546E7A),
      letterSpacing: 0.5,
    ),
  );

  Widget _fieldCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _divider() => const Divider(
    height: 1,
    indent: 16,
    endIndent: 16,
    color: Color(0xFFF0F4F8),
  );

  Widget _field(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    bool required = false,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: ctrl,
        readOnly: readOnly,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF0A2540),
        ),
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          labelStyle: TextStyle(
            fontSize: 13,
            color: readOnly ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
          prefixIcon: Icon(
            icon,
            size: 18,
            color: readOnly ? Colors.grey.shade300 : const Color(0xFF78909C),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon:
              readOnly
                  ? Icon(
                    Icons.lock_outline_rounded,
                    size: 14,
                    color: Colors.grey.shade300,
                  )
                  : null,
        ),
      ),
    );
  }

  Widget _outlineBtn(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD0DCFF)),
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF0F4FF),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: const Color(0xFF1565C0)),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Animated Save Button ─────────────────────────────────────────────────────

class _SaveButton extends StatelessWidget {
  final bool saved;
  final VoidCallback onPressed;
  const _SaveButton({required this.saved, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              saved
                  ? [const Color(0xFF2E7D32), const Color(0xFF43A047)]
                  : [const Color(0xFF0A2540), const Color(0xFF1565C0)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (saved ? const Color(0xFF2E7D32) : const Color(0xFF0A2540))
                .withOpacity(0.3),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  saved ? Icons.check_circle_rounded : Icons.save_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  saved ? 'Changes Saved!' : 'Save Changes',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Placeholder Tab ──────────────────────────────────────────────────────────

class _PlaceholderTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  const _PlaceholderTab({
    required this.icon,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(icon, size: 34, color: const Color(0xFF1565C0)),
                ),
                const SizedBox(height: 20),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0A2540),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_rounded),
                  label: Text('Add $label'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1565C0),
                    side: const BorderSide(color: Color(0xFF1565C0)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
