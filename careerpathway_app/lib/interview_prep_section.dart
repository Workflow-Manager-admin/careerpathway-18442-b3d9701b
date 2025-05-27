import 'package:flutter/material.dart';

// PUBLIC_INTERFACE
/// Interview Preparation & Mock Interviews Section
/// Provides: 
///  - Practice interview questions (behavioral, technical)
///  - Mock interview scheduling (placeholder)
///  - Preparation tips
class InterviewPrepSection extends StatefulWidget {
  const InterviewPrepSection({Key? key}) : super(key: key);

  @override
  State<InterviewPrepSection> createState() => _InterviewPrepSectionState();
}

class _InterviewPrepSectionState extends State<InterviewPrepSection> with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  late TabController _tabController;

  final List<Map<String, dynamic>> practiceQuestions = const [
    {
      "category": "Behavioral",
      "questions": [
        "Tell me about yourself.",
        "Describe a time you faced a challenge at work. How did you handle it?",
        "What are your greatest strengths and weaknesses?",
        "Give an example of how you handled tight deadlines.",
        "Describe a situation where you had to learn something quickly."
      ]
    },
    {
      "category": "Technical",
      "questions": [
        "Explain the concept of RESTful APIs.",
        "What is state management in Flutter?",
        "How do you optimize app performance?",
        "Describe your process for debugging difficult issues.",
        "Explain version control and important git commands."
      ]
    }
  ];

  final List<String> prepTips = const [
    "Research the company and role thoroughly.",
    "Practice common interview questions out loud.",
    "Prepare concrete stories that demonstrate your skills using STAR method.",
    "Brush up on technical foundations relevant to the job.",
    "Have questions ready to ask the interviewer.",
    "Plan your interview attire and arrive on time—virtually or in-person.",
    "After your mock or real interview, take notes and reflect on improvements."
  ];

  String? _selectedCategory;
  int? _selectedQuestionIndex;

  // Simulated list of scheduled interviews (in reality should come from backend/storage)
  List<Map<String, String>> scheduledMocks = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _selectedCategory = practiceQuestions[0]["category"];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF2D6A4F);
    final Color accent = const Color(0xFFFFD166);
    final Color secondary = const Color(0xFF40916C);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Card(
            color: Colors.white,
            elevation: 2.7,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header
                  Row(
                    children: const [
                      Icon(Icons.record_voice_over, color: Color(0xFFFFD166), size: 32),
                      SizedBox(width: 11),
                      Text(
                        "Interview Preparation & Mock Interviews",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2D6A4F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Sharpen your interview skills with practice questions, schedule a mock interview, and get ready with our expert tips.",
                    style: TextStyle(
                      fontSize: 15.7,
                      color: secondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Divider(height: 28, color: Color(0xFF40916C), thickness: 1),
                  // Tabs for Practice, Mock Interview, Tips
                  TabBar(
                    controller: _tabController,
                    labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    labelColor: primary,
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: accent,
                    indicatorWeight: 3.5,
                    tabs: const [
                      Tab(text: "Practice Questions", icon: Icon(Icons.quiz_outlined)),
                      Tab(text: "Mock Scheduling", icon: Icon(Icons.calendar_today)),
                      Tab(text: "Prep Tips", icon: Icon(Icons.tips_and_updates_outlined)),
                    ],
                    onTap: (idx) => setState(() => _selectedTab = idx),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 390,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Practice Questions
                        _buildPracticeQuestions(context, primary, accent, secondary),
                        // Mock Scheduling
                        _buildMockScheduler(context, primary, accent, secondary),
                        // Preparation Tips
                        _buildPreparationTips(context, accent, secondary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // PUBLIC_INTERFACE
  Widget _buildPracticeQuestions(BuildContext context, Color primary, Color accent, Color secondary) {
    // Choose category (behavioral or technical)
    final categories = practiceQuestions.map((e) => e["category"] as String).toList();
    final current = practiceQuestions[categories.indexOf(_selectedCategory ?? "Behavioral")];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category chips
        Wrap(
          spacing: 12,
          children: categories.map((c) {
            final bool isSelected = c == _selectedCategory;
            return ChoiceChip(
              label: Text(
                c,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? primary : Colors.black87,
                ),
              ),
              selected: isSelected,
              onSelected: (_) => setState(() {
                _selectedCategory = c;
                _selectedQuestionIndex = null;
              }),
              backgroundColor: Colors.grey.shade100,
              selectedColor: accent.withOpacity(0.26),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: ListView.separated(
            itemCount: (current["questions"] as List).length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, idx) {
              final q = current["questions"][idx];
              final bool isSelected = idx == _selectedQuestionIndex;
              return Card(
                elevation: isSelected ? 4 : 1,
                color: isSelected ? accent.withOpacity(0.24) : Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(
                    isSelected ? Icons.mic_none : Icons.question_answer,
                    color: isSelected ? primary : secondary,
                    size: 25,
                  ),
                  title: Text(
                    q,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: primary,
                    ),
                  ),
                  subtitle: isSelected
                      ? Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            "Practice your answer aloud or write it here. (AI answer feedback: coming soon!)",
                            style: TextStyle(
                              fontSize: 13,
                              color: secondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      : null,
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: accent, size: 22)
                      : null,
                  onTap: () => setState(() => _selectedQuestionIndex = idx),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // PUBLIC_INTERFACE
  Widget _buildMockScheduler(BuildContext context, Color primary, Color accent, Color secondary) {
    // Inputs for mock interview (date/time - simulated)
    DateTime? selectedDate;
    TimeOfDay? selectedTime;
    String? selectedType;
    final typeOptions = ["Behavioral", "Technical", "Both"];

    void _scheduleMock() async {
      DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 90)),
        helpText: "Pick a date",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: primary,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: primary,
              ),
            ),
            child: child!,
          );
        },
      );
      if (date == null) return;

      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 10, minute: 0),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: accent),
            ),
            child: child!,
          );
        },
      );
      if (time == null) return;

      // Show type picker
      await showDialog(
        context: context,
        builder: (context) {
          String? chosen = typeOptions.first;
          return AlertDialog(
            title: const Text("Choose Interview Type"),
            content: DropdownButtonFormField<String>(
              value: chosen,
              items: [
                for (final t in typeOptions) DropdownMenuItem(value: t, child: Text(t))
              ],
              onChanged: (v) => chosen = v,
              decoration: const InputDecoration(labelText: "Type"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, chosen);
                },
                child: const Text("Confirm"),
              ),
            ],
          );
        },
      ).then((type) {
        selectedType = type;
      });

      if (selectedType != null) {
        setState(() {
          scheduledMocks.add({
            "date": "${date.year}-${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")}",
            "time": "${time.format(context)}",
            "type": selectedType ?? "Behavioral"
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Mock interview scheduled! (No real AI—demo only)"),
            backgroundColor: accent.withOpacity(0.96),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: accent,
            foregroundColor: primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5),
            elevation: 2,
          ),
          icon: const Icon(Icons.calendar_today_outlined),
          label: const Text("Schedule Mock Interview"),
          onPressed: _scheduleMock,
        ),
        const SizedBox(height: 18),
        const Text(
          "Scheduled Mocks",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height:7),
        if (scheduledMocks.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "No mock interviews scheduled yet.",
              style: TextStyle(color: Colors.black54, fontSize: 13.5),
            ),
          ),
        if (scheduledMocks.isNotEmpty)
          ...scheduledMocks.map((m) => Card(
                color: accent.withOpacity(0.13),
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: Icon(
                    Icons.event_available,
                    color: primary,
                  ),
                  title: Text(
                    "${m["type"]} Interview",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Color(0xFF2D6A4F)),
                  ),
                  subtitle: Text(
                    "${m["date"]} • ${m["time"]}",
                    style: const TextStyle(color: Color(0xFF40916C), fontSize: 13.8),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_forever, color: Colors.red, size: 24),
                    tooltip: "Remove",
                    onPressed: () => setState(() {
                      scheduledMocks.remove(m);
                    }),
                  ),
                ),
              ))
      ],
    );
  }

  // PUBLIC_INTERFACE
  Widget _buildPreparationTips(BuildContext context, Color accent, Color secondary) {
    return ListView.separated(
      itemCount: prepTips.length,
      separatorBuilder: (_, __) => const SizedBox(height: 9),
      itemBuilder: (context, idx) {
        final tip = prepTips[idx];
        return Card(
          color: accent.withOpacity(0.16),
          elevation: 1.6,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: ListTile(
            leading: const Icon(Icons.lightbulb_outline, color: Color(0xFF40916C)),
            title: Text(
              tip,
              style: const TextStyle(
                  color: Color(0xFF2D6A4F), fontWeight: FontWeight.w600, fontSize: 14.5),
            ),
          ),
        );
      },
    );
  }
}
