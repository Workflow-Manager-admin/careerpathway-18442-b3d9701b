import 'package:flutter/material.dart';

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
    'Career Pathing'
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
          // Notifications Icon
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            tooltip: "Job Alerts & Notifications",
            onPressed: () {
              // TODO: handle notifications
            },
          ),
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
      default:
        return const Icon(Icons.dashboard_customize_outlined);
    }
  }
}

// Placeholder section widgets for dashboard scaffolding

class _SkillRecommendationsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PUBLIC_INTERFACE
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.star, size: 48, color: Color(0xFF2D6A4F)),
          SizedBox(height: 10),
          Text(
            'Skill Recommendations',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text('Personalized skills to learn will appear here.'),
        ],
      ),
    );
  }
}

class _ProfileUpdateSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PUBLIC_INTERFACE
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.person, size: 44, color: Color(0xFF40916C)),
          SizedBox(height: 10),
          Text(
            'Profile & Skill Updates',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text('Update your profile and skill details here.'),
        ],
      ),
    );
  }
}

class _InterviewPrepSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PUBLIC_INTERFACE
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.record_voice_over, size: 44, color: Color(0xFFFFD166)),
          SizedBox(height: 10),
          Text(
            'Interview Preparation',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text('AI-powered mock interview tools coming soon.'),
        ],
      ),
    );
  }
}

class _CareerPathingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PUBLIC_INTERFACE
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.trending_up, size: 44, color: Color(0xFF2D6A4F)),
          SizedBox(height: 10),
          Text(
            'Career Pathing & Insights',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text('Explore future growth and career suggestions.'),
        ],
      ),
    );
  }
}

class _PersonalizedJobListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PUBLIC_INTERFACE
    // Placeholder profile and job matching
    final List<Map<String, dynamic>> matchedJobs = [
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
