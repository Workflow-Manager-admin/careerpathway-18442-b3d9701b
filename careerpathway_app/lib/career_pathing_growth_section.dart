import 'package:flutter/material.dart';

// PUBLIC_INTERFACE
/// Career Pathing & Growth Insights Section
/// Provides suggestions for possible career pathways and personal development options based on placeholder user data.
/// Integrates with the app's primary color theme.
class CareerPathingGrowthSection extends StatelessWidget {
  CareerPathingGrowthSection({Key? key}) : super(key: key);

  // Placeholder: Example possible pathways & growth for a user in Flutter dev track
  final List<Map<String, dynamic>> suggestedPaths = const [
    {
      "title": "Mobile App Lead",
      "progression": ["Junior Flutter Dev", "Flutter Dev", "Senior Mobile Dev", "Tech Lead"],
      "nextSteps": [
        "Gain experience leading small projects",
        "Mentor junior developers",
        "Contribute to open source Flutter libraries"
      ],
      "marketDemand": "High"
    },
    {
      "title": "Product Manager (Tech)",
      "progression": ["Flutter Dev", "Sr. Developer", "Technical Product Owner", "Product Manager"],
      "nextSteps": [
        "Develop product sense",
        "Participate in business/requirements meetings",
        "Take certification in Agile/Product Management"
      ],
      "marketDemand": "Moderate"
    },
    {
      "title": "Full Stack Engineer",
      "progression": ["Flutter Dev", "Mobile/Web Dev", "Fullstack Engineer"],
      "nextSteps": [
        "Learn a backend technology (Node.js, Firebase, etc.)",
        "Build a full-stack side project",
        "Familiarize with cloud deployment (e.g., AWS, GCP)"
      ],
      "marketDemand": "Very High"
    }
  ];

  final List<String> personalGrowthTips = const [
    "Take an advanced Flutter course to deepen your skills.",
    "Shadow a senior colleague to gain team leadership experience.",
    "Set personal learning goals and track them monthly.",
    "Attend industry conferences and network with peers.",
    "Update your portfolio with measurable achievements.",
    "Seek regular feedback to accelerate your growth trajectory."
  ];

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
          constraints: const BoxConstraints(maxWidth: 920),
          child: Card(
            color: Colors.white,
            elevation: 2.7,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header
                  Row(
                    children: const [
                      Icon(Icons.trending_up, color: Color(0xFF2D6A4F), size: 32),
                      SizedBox(width: 12),
                      Text(
                        "Career Pathing & Growth Insights",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2D6A4F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Text(
                    "Explore potential future roles and development options based on your current skills and aspirations.",
                    style: TextStyle(
                      fontSize: 16,
                      color: secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Divider(height: 32, color: Color(0xFF40916C), thickness: 1),
                  // Pathways List
                  Text(
                    "Suggested Career Pathways:",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: primary),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: suggestedPaths.map((path) {
                      return Card(
                        elevation: 1.8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.rocket_launch_rounded, color: accent, size: 28),
                                  const SizedBox(width: 8),
                                  Text(
                                    path["title"],
                                    style: TextStyle(
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.w700,
                                      color: primary,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: accent.withOpacity(0.21),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.trending_up_rounded, color: accent, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          path["marketDemand"],
                                          style: TextStyle(
                                            color: accent,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 2.5),
                                    child: Icon(Icons.route, color: Color(0xFF40916C), size: 17),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(path["progression"].length, (i) {
                                          final stage = path["progression"][i];
                                          return Row(
                                            children: [
                                              Chip(
                                                label: Text(
                                                  stage,
                                                  style: const TextStyle(fontSize: 13.2, fontWeight: FontWeight.w600, color: Color(0xFF2D6A4F)),
                                                ),
                                                backgroundColor: secondary.withOpacity(0.13),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                              ),
                                              if (i != path["progression"].length - 1)
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                  child: Icon(Icons.arrow_forward_ios_rounded, size: 13, color: Colors.black38),
                                                ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Next Steps:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: secondary,
                                    fontSize: 14.1),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: (path["nextSteps"] as List).map<Widget>((step) {
                                  return Row(
                                    children: [
                                      const Icon(Icons.circle, size: 6.5, color: Color(0xFF2D6A4F)),
                                      const SizedBox(width: 7),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:2, bottom: 2),
                                          child: Text(
                                            step,
                                            style: const TextStyle(
                                              fontSize: 13.2,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),
                  // Personal growth tips
                  Text(
                    "Personal Growth Options:",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: primary),
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: personalGrowthTips.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 7),
                    itemBuilder: (context, idx) {
                      final tip = personalGrowthTips[idx];
                      return Container(
                        decoration: BoxDecoration(
                          color: accent.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.insights_rounded, color: Color(0xFF40916C), size: 18),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                tip,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2D6A4F), fontSize: 13.7),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.auto_graph_sharp, color: Color(0xFF2D6A4F), size: 24),
                        SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            "Actively managing your growth opens up more rewarding career possibilities.",
                            style: TextStyle(
                              color: Color(0xFF2D6A4F),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
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
}
