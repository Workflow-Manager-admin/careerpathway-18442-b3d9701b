import 'package:flutter/material.dart';

// PUBLIC_INTERFACE
/// Application Tracking & Management Section
/// Lets users view, update, and organize their job applications, set reminders, and see status.
/// Designed for the CareerPathway dashboard and uses the project's color theme.
class ApplicationTrackingSection extends StatefulWidget {
  const ApplicationTrackingSection({Key? key}) : super(key: key);

  @override
  State<ApplicationTrackingSection> createState() => _ApplicationTrackingSectionState();
}

class _ApplicationTrackingSectionState extends State<ApplicationTrackingSection> {
  // Mocked list of job applications (would normally be persisted/fetched)
  List<Map<String, dynamic>> applications = [
    {
      "id": 1,
      "position": "Flutter Developer",
      "company": "TechNova",
      "status": "Interview Scheduled",
      "appliedDate": DateTime.now().subtract(const Duration(days: 8)),
      "reminder": DateTime.now().add(const Duration(days: 3)),
      "archived": false,
    },
    {
      "id": 2,
      "position": "Frontend Engineer",
      "company": "InnoSoft Inc.",
      "status": "Awaiting Response",
      "appliedDate": DateTime.now().subtract(const Duration(days: 16)),
      "reminder": null,
      "archived": false,
    },
    {
      "id": 3,
      "position": "Junior Data Analyst",
      "company": "Analytiq Systems",
      "status": "Offer Received",
      "appliedDate": DateTime.now().subtract(const Duration(days: 23)),
      "reminder": DateTime.now().add(const Duration(days: 1)),
      "archived": false,
    },
    {
      "id": 4,
      "position": "Mobile App QA Tester",
      "company": "QualityFirst",
      "status": "Rejected",
      "appliedDate": DateTime.now().subtract(const Duration(days: 30)),
      "reminder": null,
      "archived": true,
    },
  ];

  // To show either active or archived apps
  bool showArchived = false;

  // Set a reminder for a specific application
  Future<void> _setReminder(BuildContext context, int appIndex) async {
    final DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 2)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      helpText: "Pick reminder date",
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: const Color(0xFF2D6A4F),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: const Color(0xFF2D6A4F),
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        applications[appIndex]["reminder"] = picked;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Reminder set!"),
          duration: const Duration(seconds: 2),
          backgroundColor: const Color(0xFFFFD166),
        ),
      );
    }
  }

  // Change application status via dropdown
  final List<String> statuses = [
    "Applied",
    "Awaiting Response",
    "Interview Scheduled",
    "Interview Completed",
    "Offer Received",
    "Rejected",
    "Withdrawn"
  ];

  void _updateStatus(int appIndex, String? newStatus) {
    if (newStatus == null) return;
    setState(() {
      applications[appIndex]["status"] = newStatus;
    });
  }

  void _deleteApplication(int appIndex) {
    setState(() {
      applications.removeAt(appIndex);
    });
  }

  void _toggleArchive(int appIndex) {
    setState(() {
      applications[appIndex]["archived"] = !(applications[appIndex]["archived"] as bool);
    });
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return "—";
    return "${dt.year}-${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}";
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Offer Received":
        return const Color(0xFF40916C); // secondary
      case "Interview Scheduled":
      case "Interview Completed":
        return const Color(0xFF2D6A4F); // primary
      case "Awaiting Response":
        return Colors.orange.shade700;
      case "Rejected":
        return Colors.redAccent;
      case "Withdrawn":
        return Colors.grey;
      case "Applied":
      default:
        return Colors.blueGrey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF2D6A4F);
    final Color accent = const Color(0xFFFFD166);
    final Color secondary = const Color(0xFF40916C);

    final filtered = applications.where((a) => (a["archived"] == showArchived)).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 930),
          child: Card(
            color: Colors.white,
            elevation: 2.7,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header
                  Row(
                    children: [
                      Icon(Icons.track_changes_rounded, color: accent, size: 32),
                      const SizedBox(width: 11),
                      Text(
                        "Application Tracking & Management",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                          color: primary,
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        icon: Icon(showArchived ? Icons.work_outline : Icons.archive, color: secondary),
                        label: Text(
                          showArchived ? "Show Active" : "Show Archived",
                          style: TextStyle(color: secondary, fontWeight: FontWeight.w600),
                        ),
                        onPressed: () => setState(() => showArchived = !showArchived),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Keep track of all your job applications, manage follow-ups, and stay organized across your job search journey.",
                    style: TextStyle(fontSize: 15.5, color: secondary, fontWeight: FontWeight.w500),
                  ),
                  const Divider(height: 28, color: Color(0xFF40916C), thickness: 1),

                  if (filtered.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 36),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.work_history_outlined, size: 54, color: primary.withOpacity(0.13)),
                            const SizedBox(height: 13),
                            Text(
                              showArchived
                                  ? "No archived applications yet."
                                  : "No active applications yet.",
                              style: TextStyle(fontSize: 16, color: primary, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    )
                  else ...[
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2.6),
                        1: FlexColumnWidth(2.3),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(1.5),
                        4: FlexColumnWidth(1.7),
                        5: FlexColumnWidth(1.1),
                        6: FlexColumnWidth(1.5),
                      },
                      children: [
                        // Table header
                        TableRow(
                          decoration: BoxDecoration(color: secondary.withOpacity(0.10)),
                          children: const [
                            Padding(padding: EdgeInsets.symmetric(vertical: 7), child: Text("Position", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
                            Padding(padding: EdgeInsets.symmetric(vertical: 7), child: Text("Company", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
                            Padding(padding: EdgeInsets.symmetric(vertical: 7), child: Text("Status", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
                            Padding(padding: EdgeInsets.symmetric(vertical: 7), child: Text("Applied", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
                            Padding(padding: EdgeInsets.symmetric(vertical: 7), child: Text("Reminder", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
                            SizedBox(), // Action placeholders
                            SizedBox(),
                          ]
                        ),
                        // Applications
                        for (int i = 0; i < filtered.length; i++)
                          _applicationRow(filtered[i], applications.indexOf(filtered[i]), primary, accent, secondary)
                      ],
                    )
                  ],
                  const SizedBox(height: 18),
                  // Footer/Call to action or tips
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.info_outline_rounded, color: Color(0xFF40916C), size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Tip: Set reminders to follow up, archive completed/rejected applications to stay focused, and quickly update application status as you progress.",
                            style: TextStyle(
                              color: Color(0xFF2D6A4F),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.5,
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
        ),
      ),
    );
  }

  TableRow _applicationRow(Map<String, dynamic> app, int appIndex, Color primary, Color accent, Color secondary) {
    return TableRow(
      decoration: BoxDecoration(
        color: app["archived"] == true ? Colors.grey.shade100 : null,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            app["position"],
            style: TextStyle(
              fontSize: 15.3,
              fontWeight: FontWeight.w600,
              color: app["archived"] ? Colors.grey : primary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            app["company"],
            style: TextStyle(
              fontSize: 15,
              color: app["archived"] ? Colors.grey : secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: DropdownButtonFormField<String>(
            value: app["status"],
            decoration: const InputDecoration(border: InputBorder.none, isDense: true),
            isDense: true,
            style: TextStyle(
              color: _statusColor(app["status"]),
              fontWeight: FontWeight.bold,
            ),
            items: statuses.map(
              (s) => DropdownMenuItem(
                  value: s,
                  child: Row(children: [
                    Icon(
                      s == "Offer Received"
                          ? Icons.emoji_events_rounded
                          : s == "Interview Scheduled"
                              ? Icons.calendar_month
                              : s == "Rejected"
                                  ? Icons.cancel
                                  : Icons.work_outline,
                      color: _statusColor(s),
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(s),
                  ])),
            ).toList(),
            onChanged: app["archived"]
                ? null
                : (s) => _updateStatus(appIndex, s),
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text(
            _formatDate(app["appliedDate"]),
            style: const TextStyle(fontSize: 13.5, color: Colors.black87),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  app["reminder"] != null ? _formatDate(app["reminder"]) : "—",
                  style: TextStyle(
                    fontSize: 13.2,
                    color: app["reminder"] != null
                        ? accent
                        : Colors.black38,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              if (!app["archived"])
                IconButton(
                  tooltip: "Set/Update Reminder",
                  icon: const Icon(Icons.add_alert_outlined, size: 19, color: Color(0xFFFFD166)),
                  onPressed: () => _setReminder(context, appIndex),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              if (app["reminder"] != null && !app["archived"])
                IconButton(
                  tooltip: "Clear Reminder",
                  icon: const Icon(Icons.clear, size: 17, color: Colors.redAccent),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    setState(() {
                      app["reminder"] = null;
                    });
                  },
                )
            ],
          ),
        ),
        // Archive/Unarchive
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: IconButton(
            icon: Icon(
              app["archived"] ? Icons.unarchive : Icons.archive_outlined,
              color: secondary,
              size: 21,
            ),
            tooltip: app["archived"] ? "Unarchive" : "Archive",
            onPressed: () => _toggleArchive(appIndex),
          ),
        ),
        // Delete
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.redAccent, size: 22),
            tooltip: "Delete Application",
            onPressed: () {
              showDialog(
                context: context,
                builder: (c) => AlertDialog(
                  title: const Text("Delete Application"),
                  content: const Text("Are you sure you want to permanently delete this application?"),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text("Delete", style: TextStyle(color: Colors.redAccent)),
                      onPressed: () {
                        Navigator.pop(context);
                        _deleteApplication(appIndex);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Application deleted!"),
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.redAccent.withOpacity(0.93),
                          ),
                        );
                      },
                    ),
                  ],
                ));
            },
          ),
        )
      ],
    );
  }
}
