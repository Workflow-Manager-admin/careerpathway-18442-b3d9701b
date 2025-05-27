import 'package:flutter/material.dart';

// PUBLIC_INTERFACE
/// AI-Powered Resume & Cover Letter Optimizer
/// Displays editable areas for uploading/pasting resumes/cover letters, and provides instant (mocked) feedback & suggestions.
/// Highlights actionable tips using app's green/yellow color scheme.
class ResumeCoverLetterOptimizerSection extends StatefulWidget {
  const ResumeCoverLetterOptimizerSection({Key? key}) : super(key: key);

  @override
  State<ResumeCoverLetterOptimizerSection> createState() => _ResumeCoverLetterOptimizerSectionState();
}

class _ResumeCoverLetterOptimizerSectionState extends State<ResumeCoverLetterOptimizerSection> {
  final _resumeController = TextEditingController();
  final _coverController = TextEditingController();

  // Mock "AI" feedback (placeholder)
  List<Map<String, dynamic>> getResumeTips(String text) {
    // Simulate: keyword match, brevity, action verb use, quantification (use highlight-color keys)
    return [
      {
        "tip": "Use more action verbs (e.g., Led, Built, Optimized)",
        "type": "action",
      },
      {
        "tip": "Highlight quantifiable results (e.g., 'increased sales by 20%')",
        "type": "evidence",
      },
      {
        "tip": "Include more relevant keywords for your target job",
        "type": "keyword",
      },
      {
        "tip": "Keep bullet points concise (1-2 lines each)",
        "type": "format",
      },
    ];
  }

  List<Map<String, dynamic>> getCoverLetterTips(String text) {
    return [
      {
        "tip": "Demonstrate knowledge of the company and role",
        "type": "insight",
      },
      {
        "tip": "Include a call to action (ask for an interview)",
        "type": "format",
      },
      {
        "tip": "Keep it under 300 words for readability",
        "type": "evidence",
      },
    ];
  }

  @override
  void dispose() {
    _resumeController.dispose();
    _coverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      const Icon(Icons.auto_fix_high_outlined, color: Color(0xFF2D6A4F), size: 33),
                      const SizedBox(width: 11),
                      Text(
                        "Resume & Cover Letter Optimizer",
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                            color: primary
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Get instant, AI-powered tips to strengthen your documents. Paste or edit your resume and cover letter below.",
                    style: TextStyle(
                      fontSize: 15.7,
                      color: secondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Divider(height: 28, color: Color(0xFF40916C), thickness: 1),
                  // Resume area
                  _buildDocumentSection(
                    context,
                    title: "Resume",
                    hint: "Paste your resume text or upload.",
                    controller: _resumeController,
                    tips: getResumeTips(_resumeController.text),
                    icon: Icons.description_outlined,
                    color: primary,
                  ),
                  const SizedBox(height: 24),
                  // Cover letter area
                  _buildDocumentSection(
                    context,
                    title: "Cover Letter",
                    hint: "Paste your cover letter or upload.",
                    controller: _coverController,
                    tips: getCoverLetterTips(_coverController.text),
                    icon: Icons.markunread_outlined,
                    color: accent,
                  ),
                  const SizedBox(height: 16),
                  // CTA
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.tips_and_updates_rounded, color: Color(0xFF40916C), size: 21),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            "Tailor your documents for each application to maximize your job matches and responses.",
                            style: TextStyle(
                              color: Color(0xFF40916C),
                              fontWeight: FontWeight.w600,
                              fontSize: 14.2,
                              letterSpacing: 0.01,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // PUBLIC_INTERFACE
  /// Builds the document input area and shows suggested tips
  Widget _buildDocumentSection(
    BuildContext context, {
      required String title,
      required String hint,
      required TextEditingController controller,
      required List<Map<String, dynamic>> tips,
      required IconData icon,
      required Color color,
  }) {
    final Color accent = const Color(0xFFFFD166);

    List<Map<String, dynamic>> tipList = tips; // Could refactor to show only for non-empty doc.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 6),
            Text(
              "$title Editor",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.9,
                color: color,
              ),
            ),
            const Spacer(),
            OutlinedButton.icon(
              icon: Icon(Icons.upload_file, color: color),
              label: const Text("Upload"),
              style: OutlinedButton.styleFrom(
                foregroundColor: color,
                side: BorderSide(color: color.withOpacity(0.7)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                textStyle: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                // TODO: Implement resume/cover letter file upload
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: const [
                        Icon(Icons.info_outline, color: Color(0xFF40916C)),
                        SizedBox(width: 8),
                        Text("Uploading documents is coming soon."),
                      ],
                    ),
                    duration: const Duration(seconds: 2),
                    backgroundColor: accent.withOpacity(0.96),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          maxLines: 9,
          minLines: 5,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: color.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: color, width: 1.6),
            ),
          ),
          style: const TextStyle(fontSize: 14.7),
          onChanged: (_) {
            setState(() {}); // To show updated (mocked) suggestions live
          },
        ),
        const SizedBox(height: 9),
        // Suggestions
        if (tipList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 1, top: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AI-Powered Suggestions:",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: color,
                  ),
                ),
                const SizedBox(height: 3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: tipList.map((tip) => _TipCard(tip: tip)).toList(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// Tip box, color based on tip type
class _TipCard extends StatelessWidget {
  final Map<String, dynamic> tip;
  const _TipCard({required this.tip});

  @override
  Widget build(BuildContext context) {
    Color color;
    Color bg;
    IconData icon;
    switch (tip["type"]) {
      case "action":
        color = const Color(0xFF2D6A4F);
        bg = const Color(0xFF40916C).withOpacity(0.16);
        icon = Icons.flash_on_outlined;
        break;
      case "evidence":
        color = const Color(0xFFFFD166);
        bg = const Color(0xFFFFD166).withOpacity(0.13);
        icon = Icons.stacked_bar_chart_outlined;
        break;
      case "keyword":
        color = Colors.deepPurple;
        bg = Colors.deepPurpleAccent.withOpacity(0.14);
        icon = Icons.find_in_page_outlined;
        break;
      case "insight":
        color = const Color(0xFF40916C);
        bg = const Color(0xFF40916C).withOpacity(0.10);
        icon = Icons.lightbulb_outline_rounded;
        break;
      case "format":
        color = Colors.blueGrey.shade800;
        bg = Colors.blueGrey.shade100.withOpacity(0.18);
        icon = Icons.format_list_bulleted;
        break;
      default:
        color = Colors.black54;
        bg = Colors.black12;
        icon = Icons.info_outline_rounded;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 21),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              tip["tip"],
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
