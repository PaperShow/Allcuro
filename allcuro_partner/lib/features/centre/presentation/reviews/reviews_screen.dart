import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/screen_header.dart';
import '../../../../core/ui/surface.dart';
import '../../../../core/ui/tappable.dart';

/// A single mock family review.
class _Review {
  final String familyName;
  final int stars;
  final String comment;
  final String relativeDate;

  const _Review({
    required this.familyName,
    required this.stars,
    required this.comment,
    required this.relativeDate,
  });
}

const _reviews = <_Review>[
  _Review(
    familyName: 'Anita Rao',
    stars: 5,
    comment: 'The nursing staff were attentive and my father recovered well under their care. Highly recommend.',
    relativeDate: '2 days ago',
  ),
  _Review(
    familyName: 'Vikram Shah',
    stars: 4,
    comment: 'Clean rooms and good food. Communication about the daily care plan could be a bit quicker.',
    relativeDate: '1 week ago',
  ),
  _Review(
    familyName: 'Meena Iyer',
    stars: 5,
    comment: 'Staff-to-patient ratio really shows — someone was always around when we visited.',
    relativeDate: '2 weeks ago',
  ),
  _Review(
    familyName: 'Suresh Nair',
    stars: 4,
    comment: 'Good overall experience during my mother\'s stay. Would have liked more frequent updates.',
    relativeDate: '3 weeks ago',
  ),
];

/// Reviews & ratings overview for a homecare centre — a self-contained demo
/// screen with mock reviews and a local, non-persisted "respond publicly"
/// reply box per review. Pushed from the centre home screen's "More tools"
/// grid.
class ReviewsScreen extends StatefulWidget {
  final VoidCallback onBack;

  const ReviewsScreen({super.key, required this.onBack});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  late final _replying = List<bool>.filled(_reviews.length, false);
  late final _replyControllers =
      List.generate(_reviews.length, (_) => TextEditingController());

  @override
  void dispose() {
    for (final c in _replyControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(title: 'Reviews & ratings', onBack: widget.onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                children: [
                  Surface(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          '4.6',
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.ink),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (i) {
                            return Icon(
                              i < 4 ? Icons.star_rounded : Icons.star_outline_rounded,
                              size: 22,
                              color: AppColors.warning,
                            );
                          }),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          '48 reviews',
                          style: TextStyle(fontSize: 13, color: AppColors.mutedForeground),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (var i = 0; i < _reviews.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ReviewCard(
                        review: _reviews[i],
                        replying: _replying[i],
                        replyController: _replyControllers[i],
                        onToggleReply: () => setState(() => _replying[i] = !_replying[i]),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final _Review review;
  final bool replying;
  final TextEditingController replyController;
  final VoidCallback onToggleReply;

  const _ReviewCard({
    required this.review,
    required this.replying,
    required this.replyController,
    required this.onToggleReply,
  });

  @override
  Widget build(BuildContext context) {
    return Surface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  review.familyName,
                  style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink),
                ),
              ),
              Text(
                review.relativeDate,
                style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(5, (i) {
              return Icon(
                i < review.stars ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 16,
                color: AppColors.warning,
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            review.comment,
            style: const TextStyle(fontSize: 13.5, height: 1.4, color: AppColors.ink),
          ),
          const SizedBox(height: 8),
          Tappable(
            onTap: onToggleReply,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                replying ? 'Cancel' : 'Respond publicly',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          if (replying) ...[
            const SizedBox(height: 8),
            TextField(
              controller: replyController,
              maxLines: 3,
              style: const TextStyle(fontSize: 13.5, color: AppColors.ink),
              decoration: InputDecoration(
                hintText: 'Write a public reply…',
                hintStyle: const TextStyle(color: AppColors.mutedForeground, fontWeight: FontWeight.w400),
                filled: true,
                fillColor: AppColors.card,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
