import 'package:flutter/material.dart';
import 'resume_optimizer_section.dart';

// PUBLIC_INTERFACE
void main() {
  runApp(const CareerPathwayApp());
}

// PUBLIC_INTERFACE
class CareerPathwayApp extends StatelessWidget {
  const CareerPathwayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareerPathway',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color(0xFF2D6A4F), // Deep green
          onPrimary: Colors.white,
          secondary: const Color(0xFF40916C), // Soft green
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black87,
          surface: Colors.white,
          onSurface: Colors.black87,
        ),
        useMaterial3: true,
        // Accent color for FloatingActionButtons, etc.
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFD166), // Accent yellow
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D6A4F),
          foregroundColor: Colors.white,
        ),
      ),
      home: const CareerPathwayDashboard(),
    );
  }
}

// PUBLIC_INTERFACE
class CareerPathwayDashboard extends StatefulWidget {
  const CareerPathwayDashboard({super.key});

  @override
  State<CareerPathwayDashboard> createState() => _CareerPathwayDashboardState();
}

class _CareerPathwayDashboardState extends State<CareerPathwayDashboard> {
  int _selectedSidebarIndex = 0;

  // List of main dashboard sections represented in sidebar
  final List<String> _sidebarSections = [
    'Recommended Skills',
    'Profile & Updates',
    'Interview Prep',
    'Career Pathing',
    'Resume Optimizer'
  ];

  // Placeholder method for sidebar navigation
  void _onSidebarSelect(int index) {
    setState(() {
      _selectedSidebarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive layout: Consider mobile device but show sidebar (Drawer)
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CareerPathway',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          // Notification Icon + Dropdown
          NotificationBellDropdown(),

          // Profile Avatar/Settings
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                // TODO: handle profile navigation
              },
              child: const CircleAvatar(
                backgroundColor: Color(0xFF40916C),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF2D6A4F),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Dashboard Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Navigate career features',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  )
                ],
              ),
            ),
            // Sidebar options
            for (int i = 0; i < _sidebarSections.length; i++)
              ListTile(
                leading: _getSidebarIcon(i),
                title: Text(_sidebarSections[i]),
                selected: i == _selectedSidebarIndex,
                selectedTileColor: const Color(0xFF40916C).withOpacity(0.08),
                onTap: () {
                  Navigator.pop(context);
                  _onSidebarSelect(i);
                },
              )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Prominent Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(10),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF2D6A4F)),
                    hintText: 'Search for jobs, skills, or companies',
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            // Main dashboard area: Job List and Sidebar
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sidebar on wide layouts (hidden on mobile, only Drawer used)
                  // For demo: Only show when width >550, else mobile flows naturally
                  LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth > 550) {
                      return Container(
                        width: 220,
                        color: const Color(0xFF2D6A4F).withOpacity(0.04),
                        child: Column(
                          children: [
                            for (int i = 0; i < _sidebarSections.length; i++)
                              ListTile(
                                leading: _getSidebarIcon(i),
                                title: Text(_sidebarSections[i]),
                                selected: i == _selectedSidebarIndex,
                                selectedTileColor: const Color(0xFF40916C).withOpacity(0.09),
                                onTap: () => _onSidebarSelect(i),
                              )
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  // Main Content Area
                  Expanded(
                    child: _buildDashboardMainContent(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFFD166), // Accent
        foregroundColor: Colors.black87,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Update Profile/Skills'),
        onPressed: () {
          // TODO: Implement profile/skill update UX
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // PUBLIC_INTERFACE
  Widget _buildDashboardMainContent(BuildContext context) {
    // Placeholder widgets representing dashboard features for initial scaffolding.
    switch (_selectedSidebarIndex) {
      case 0:
        return _SkillRecommendationsSection();
      case 1:
        return _ProfileUpdateSection();
      case 2:
        return _InterviewPrepSection();
      case 3:
        return _CareerPathingSection();
      case 4:
        return const ResumeCoverLetterOptimizerSection();
      default:
        // Personalized Job List is always shown on main dashboard
        return _PersonalizedJobListSection();
    }
  }

  Icon _getSidebarIcon(int index) {
    switch (index) {
      case 0:
        return const Icon(Icons.star_outline, color: Color(0xFF2D6A4F));
      case 1:
        return const Icon(Icons.person_outline, color: Color(0xFF40916C));
      case 2:
        return const Icon(Icons.record_voice_over, color: Color(0xFFFFD166));
      case 3:
        return const Icon(Icons.trending_up, color: Color(0xFF2D6A4F));
      case 4:
        return const Icon(Icons.auto_fix_high_outlined, color: Color(0xFFFFD166));
      default:
        return const Icon(Icons.dashboard_customize_outlined);
    }
  }
}

// Placeholder section widgets for dashboard scaffolding

class _SkillRecommendationsSection extends StatelessWidget {
  // Sample placeholder: user current skills and missing skills for dream job
  final List<String> currentSkills = const [
    "Dart", "Flutter", "Git", "REST APIs"
  ];
  final List<Map<String, dynamic>> suggestedSkills = const [
    {
      "skill": "Unit Testing",
      "importance": "High",
      "reason": "Frequently required for developer roles",
    },
    {
      "skill": "State Management (e.g. Provider, Bloc)",
      "importance": "High",
      "reason": "Increases code maintainability in large Flutter apps",
    },
    {
      "skill": "CI/CD Basics",
      "importance": "Medium",
      "reason": "Improves software delivery process",
    },
    {
      "skill": "Firebase",
      "importance": "Medium",
      "reason": "Common in modern mobile app stacks",
    },
    {
      "skill": "UI/UX Fundamentals",
      "importance": "Low",
      "reason": "Helpful for delivering user-friendly apps",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // PUBLIC_INTERFACE
    final theme = Theme.of(context);
    final Color primary = const Color(0xFF2D6A4F);
    final Color accent = const Color(0xFFFFD166);
    final Color chipBg = const Color(0xFF40916C).withOpacity(0.13);

    // Visual skill gap "bar" and chips for recommended skills
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title and Icon
          Row(
            children: const [
              Icon(Icons.grade, size: 32, color: Color(0xFF2D6A4F)),
              SizedBox(width: 8),
              Text(
                "Skill Gap Analysis",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D6A4F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Identify skill gaps and upskill suggestions for your targeted roles.",
            style: TextStyle(
              fontSize: 15.5,
              color: Color(0xFF40916C),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 25),

          // Your profile current skills chips
          const Text(
            "Current Skills:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D6A4F),
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            children: [
              ...currentSkills.map(
                (skill) => Chip(
                  label: Text(
                    skill,
                    style: const TextStyle(
                      fontSize: 13.1,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D6A4F),
                    ),
                  ),
                  backgroundColor: chipBg,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // Skill gap analysis headline
          const Text(
            "Recommended Skills to Upskill:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF40916C),
            ),
          ),
          const SizedBox(height: 7),

          // For each recommended skill, show visual tag for importance (color-coding) and explanation
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: suggestedSkills.map((item) {
              Color badgeColor;
              switch (item["importance"]) {
                case "High":
                  badgeColor = accent;
                  break;
                case "Medium":
                  badgeColor = chipBg;
                  break;
                default:
                  badgeColor = Colors.grey.shade300;
              }
              return Card(
                elevation: 1.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: Icon(Icons.check_circle_outline,
                      color: badgeColor == accent ? primary : Color(0xFF40916C), size: 26),
                  title: Row(
                    children: [
                      Text(
                        item["skill"],
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15.3),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item["importance"],
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color:
                                (badgeColor == accent) ? primary : Color(0xFF40916C),
                            fontSize: 11.5,
                            letterSpacing: 0.1,
                          ),
                        ),
                      )
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 3),
                    child: Text(
                      item["reason"],
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.1,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          // Call to action
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.school, color: Color(0xFF2D6A4F), size: 22),
                SizedBox(width: 9),
                Expanded(
                  child: Text(
                    "Upskill to unlock more personalized job matches and boost your job prospects!",
                    style: TextStyle(
                      color: Color(0xFF2D6A4F),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      letterSpacing: 0.01,
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

class _ProfileUpdateSection extends StatefulWidget {
  @override
  State<_ProfileUpdateSection> createState() => _ProfileUpdateSectionState();
}

class _ProfileUpdateSectionState extends State<_ProfileUpdateSection> {
  // Controllers for user input fields
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _headlineController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Experience & Skills
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  // Preferences
  String? _preferredLocation;
  String? _jobType;
  bool _remoteOk = false;

  // "Saved" UI feedback
  bool _showSavedSnack = false;

  // PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color primary = const Color(0xFF2D6A4F);
    final Color accent = const Color(0xFFFFD166);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Card(
            elevation: 2.4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section header & icon
                    Row(
                      children: const [
                        Icon(Icons.person, size: 34, color: Color(0xFF40916C)),
                        SizedBox(width: 9),
                        Text(
                          "Profile Builder",
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Color(0xFF2D6A4F)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Add your personal details, experience and preferences to boost your job matches.",
                      style: TextStyle(fontSize: 15.3, color: Color(0xFF40916C), fontWeight: FontWeight.w400),
                    ),
                    const Divider(height: 32),
                    // Profile (Personal Details)
                    Text("Personal Details", style: theme.textTheme.titleMedium?.copyWith(color: primary, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        labelText: "Full Name",
                        icon: Icon(Icons.badge_outlined, color: Color(0xFF40916C)),
                        border: OutlineInputBorder(),
                        floatingLabelStyle: TextStyle(color: Color(0xFF2D6A4F)),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty) ? "Enter your name" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _headlineController,
                      decoration: const InputDecoration(
                        labelText: "Headline (e.g. Flutter Developer, Data Analyst)",
                        icon: Icon(Icons.work_outline_rounded, color: Color(0xFF40916C)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              icon: Icon(Icons.email_outlined, color: Color(0xFF40916C)),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty || !v.contains('@')) ? "Enter valid email" : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: "Phone",
                              icon: Icon(Icons.phone_outlined, color: Color(0xFF40916C)),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),

                    // Experience
                    Text("Experience", style: theme.textTheme.titleMedium?.copyWith(color: primary, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _experienceController,
                      decoration: const InputDecoration(
                        labelText: "Relevant Experience (e.g. 3 years at Company Y)",
                        icon: Icon(Icons.calendar_month_outlined, color: Color(0xFF40916C)),
                        border: OutlineInputBorder(),
                        hintText: "List time period and brief description",
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _skillsController,
                      decoration: const InputDecoration(
                        labelText: "Skills (comma separated)",
                        icon: Icon(Icons.memory_outlined, color: Color(0xFF40916C)),
                        border: OutlineInputBorder(),
                        hintText: "e.g. Dart, Flutter, REST APIs",
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Preferences
                    Text("Job Preferences", style: theme.textTheme.titleMedium?.copyWith(color: primary, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _preferredLocation,
                      items: [
                        for (String loc in ['Any', 'Remote', 'On-site', 'Hybrid']) DropdownMenuItem(value: loc, child: Text(loc)),
                      ],
                      decoration: const InputDecoration(
                        labelText: "Preferred Location",
                        icon: Icon(Icons.location_on_outlined, color: Color(0xFF40916C)),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => setState(() => _preferredLocation = v),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _jobType,
                      items: [
                        for (String jt in ['Any', 'Full Time', 'Part Time', 'Internship', 'Contract'])
                          DropdownMenuItem(value: jt, child: Text(jt)),
                      ],
                      decoration: const InputDecoration(
                        labelText: "Job Type",
                        icon: Icon(Icons.work_history_outlined, color: Color(0xFF40916C)),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => setState(() => _jobType = v),
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      value: _remoteOk,
                      onChanged: (v) => setState(() => _remoteOk = v ?? false),
                      title: const Text("Open to Remote Roles"),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: accent,
                      contentPadding: EdgeInsets.zero,
                    ),
                    const Divider(height: 24),

                    // Action buttons
                    Row(
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5),
                          ),
                          icon: const Icon(Icons.save_alt),
                          label: const Text("Save"),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              setState(() {
                                _showSavedSnack = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: const [
                                      Icon(Icons.check_circle, color: Color(0xFF40916C)),
                                      SizedBox(width: 9),
                                      Text("Profile information saved! (UI only)"),
                                    ],
                                  ),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: accent.withOpacity(0.97),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(width: 19),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.refresh, color: Color(0xFF40916C)),
                          label: const Text("Clear"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primary,
                            side: BorderSide(color: accent),
                            textStyle: const TextStyle(fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            setState(() {
                              _fullNameController.clear();
                              _headlineController.clear();
                              _emailController.clear();
                              _phoneController.clear();
                              _experienceController.clear();
                              _skillsController.clear();
                              _preferredLocation = null;
                              _jobType = null;
                              _remoteOk = false;
                              _showSavedSnack = false;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_showSavedSnack) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.check_circle_outline, color: accent, size: 22),
                          const SizedBox(width: 7),
                          const Text("Saved (not persisted yet)", style: TextStyle(color: Color(0xFF40916C), fontSize: 13.5)),
                        ],
                      )
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'interview_prep_section.dart';

class _InterviewPrepSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PUBLIC_INTERFACE
    return InterviewPrepSection();
  }
}

import 'career_pathing_growth_section.dart';

class _CareerPathingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PUBLIC_INTERFACE
    return CareerPathingGrowthSection();
  }
}

class _PersonalizedJobListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PUBLIC_INTERFACE
    // Placeholder profile and job matching
    final List<Map<String, dynamic>> matchedJobs = [

// PUBLIC_INTERFACE
/// Job Alerts/Notifications Icon with Dropdown
class NotificationBellDropdown extends StatefulWidget {
  const NotificationBellDropdown({Key? key}) : super(key: key);

  @override
  State<NotificationBellDropdown> createState() => _NotificationBellDropdownState();
}

class _NotificationBellDropdownState extends State<NotificationBellDropdown> {
  // Placeholder/mock notifications for jobs
  List<Map<String, dynamic>> notifications = [
    {
      "title": "New job: Flutter Developer",
      "subtitle": "TechNova • Remote",
      "time": "Just now",
      "isRead": false
    },
    {
      "title": "3 new matches based on your profile",
      "subtitle": "See recommended jobs",
      "time": "7min ago",
      "isRead": false
    },
    {
      "title": "Skill Matched: Unit Testing",
      "subtitle": "Boosts your job fit!",
      "time": "1h ago",
      "isRead": true
    },
    {
      "title": "Job Application Deadline Today",
      "subtitle": "Frontend Engineer at InnoSoft Inc.",
      "time": "2h ago",
      "isRead": true
    }
  ];

  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    // Pill badge with number for unread
    int unread = notifications.where((n) => n["isRead"] == false).length;
    final theme = Theme.of(context);
    final Color bellColor = unread > 0 ? const Color(0xFFFFD166) : Colors.white;

    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Icon(Icons.notifications_active_outlined, color: bellColor),
          tooltip: "Job Alerts & Notifications",
          onPressed: () {
            setState(() {
              showMenu = true;
            });
            // Show a styled dropdown Overlay or Dialog for the notifications
            showDialog(
              context: context,
              builder: (_) => JobAlertNotificationDialog(
                notifications: notifications,
                onMarkAllRead: () {
                  setState(() {
                    for (final n in notifications) {
                      n["isRead"] = true;
                    }
                  });
                  Navigator.pop(context);
                },
                onClose: () {
                  Navigator.pop(context);
                },
                onDeleteOne: (idx) {
                  setState(() {
                    notifications.removeAt(idx);
                  });
                },
              ),
            ).then((_) {
              setState(() {
                showMenu = false;
              });
            });
          },
        ),
        if (unread > 0)
          Positioned(
            right: 10,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD166),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                "$unread",
                style: const TextStyle(
                  color: Color(0xFF2D6A4F),
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// PUBLIC_INTERFACE
/// Notifications dialog with styling for job alerts
class JobAlertNotificationDialog extends StatelessWidget {
  final List<Map<String, dynamic>> notifications;
  final VoidCallback onMarkAllRead;
  final VoidCallback onClose;
  final Function(int idx) onDeleteOne;

  const JobAlertNotificationDialog({
    super.key,
    required this.notifications,
    required this.onMarkAllRead,
    required this.onClose,
    required this.onDeleteOne,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color primary = const Color(0xFF2D6A4F);
    final Color accent = const Color(0xFFFFD166);

    return Dialog(
      insetPadding: const EdgeInsets.only(top: 55, right: 17),
      alignment: Alignment.topRight,
      elevation: 8,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 345, maxHeight: 440),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(left: 19, top: 16, right: 7, bottom: 6),
              child: Row(
                children: [
                  const Icon(Icons.notifications_active, color: Color(0xFF2D6A4F), size: 24),
                  const SizedBox(width: 7),
                  const Text(
                    "Job Alerts & Notifications",
                    style: TextStyle(fontSize: 17.3, fontWeight: FontWeight.w700, color: Color(0xFF2D6A4F)),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, size: 22, color: Colors.black54),
                    tooltip: "Close",
                    onPressed: onClose,
                  )
                ],
              ),
            ),
            const Divider(height: 0, thickness: 1, color: Color(0xFF40916C)),
            if (notifications.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text("No new notifications.", style: TextStyle(color: Colors.black54))),
              )
            else
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemCount: notifications.length,
                  itemBuilder: (context, idx) {
                    final n = notifications[idx];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                      leading: Icon(
                        n["isRead"] ? Icons.mark_email_read_outlined : Icons.mark_email_unread_outlined,
                        color: n["isRead"] ? Colors.grey.shade400 : accent,
                        size: 28,
                      ),
                      title: Text(
                        n["title"],
                        style: TextStyle(
                          fontWeight: n["isRead"] ? FontWeight.w500 : FontWeight.w700,
                          color: n["isRead"] ? primary.withOpacity(0.63) : primary,
                          fontSize: 15.1,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (n["subtitle"] != null) ...[
                            Text(
                              n["subtitle"]!,
                              style: TextStyle(
                                color: n["isRead"] ? Colors.black54 : Color(0xFF40916C),
                                fontSize: 13.2,
                              ),
                            ),
                            const SizedBox(height: 1)
                          ],
                          Text(
                            n["time"] ?? "",
                            style: const TextStyle(color: Colors.black38, fontSize: 11.2),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                        tooltip: "Delete notification",
                        onPressed: () => onDeleteOne(idx),
                      ),
                    );
                  },
                ),
              ),
            // Footer actions
            if (notifications.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.done_all, size: 19),
                      label: const Text("Mark All as Read", style: TextStyle(fontSize: 13.5)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                      ),
                      onPressed: onMarkAllRead,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}
      {
        "title": "Flutter Developer",
        "company": "TechNova",
        "location": "Remote • US",
        "skills": ["Dart", "Flutter", "REST APIs"],
        "logo": Icons.phone_android,
        "badge": "Best Match",
        "jobType": "Full Time"
      },
      {
        "title": "Frontend Engineer",
        "company": "InnoSoft Inc.",
        "location": "New York, NY",
        "skills": ["React", "UI/UX", "JavaScript"],
        "logo": Icons.web,
        "badge": "New",
        "jobType": "Hybrid"
      },
      {
        "title": "Junior Data Analyst",
        "company": "Analytiq Systems",
        "location": "San Francisco, CA",
        "skills": ["SQL", "Python", "Excel"],
        "logo": Icons.bar_chart,
        "badge": null,
        "jobType": "Entry Level"
      },
      {
        "title": "Mobile App QA Tester",
        "company": "QualityFirst",
        "location": "Austin, TX",
        "skills": ["Testing", "Flutter", "Mobile"],
        "logo": Icons.bug_report,
        "badge": "Trending",
        "jobType": "Contract"
      }
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.business_center, color: Color(0xFF40916C), size: 28),
              SizedBox(width: 7),
              Text(
                'Personalized Job Matching',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D6A4F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Jobs matched for you, based on your current profile.",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF40916C),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          // Matched jobs list
          Expanded(
            child: matchedJobs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.work_off_outlined, size: 50, color: Color(0xFF40916C)),
                        SizedBox(height: 16),
                        Text(
                          "No jobs matched yet.",
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF2D6A4F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Update your profile to get recommended jobs.",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        )
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: matchedJobs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, idx) {
                      final j = matchedJobs[idx];
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 22,
                                backgroundColor: const Color(0xFF2D6A4F).withOpacity(0.11),
                                child: Icon(j["logo"], color: const Color(0xFF40916C), size: 28),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    j["title"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 17),
                                  ),
                                  if (j["badge"] != null) ...[
                                    const SizedBox(width: 7),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFD166),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        j["badge"].toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF2D6A4F),
                                          fontSize: 11,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    )
                                  ]
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          j["company"],
                                          style: const TextStyle(
                                            color: Color(0xFF40916C),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '• ${j["location"]}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Wrap(
                                      spacing: 6,
                                      children: [
                                        ...j["skills"].map<Widget>((skill) => Chip(
                                          label: Text(
                                            skill,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF2D6A4F),
                                            ),
                                          ),
                                          padding: EdgeInsets.zero,
                                          backgroundColor: const Color(0xFF40916C).withOpacity(0.13),
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7),
                                          ),
                                        )),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF2D6A4F).withOpacity(0.10),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            j["jobType"],
                                            style: const TextStyle(
                                              color: Color(0xFF40916C),
                                              fontSize: 11.6,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_rounded,
                                  size: 18, color: Color(0xFF2D6A4F)),
                              onTap: () {
                                // TODO: navigate to job details
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
