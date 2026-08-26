import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/screen_header.dart';
import '../../../../core/ui/surface.dart';

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
    familyName: 'Rekha Menon',
    stars: 5,
    comment: 'Very attentive and gentle with my mother. Always on time.',
    relativeDate: '2 weeks ago',
  ),
  _Review(
    familyName: 'Suresh Kumar',
    stars: 4,
    comment: 'Good with post-op care, kept us informed throughout.',
    relativeDate: '3 weeks ago',
  ),
  _Review(
    familyName: 'Fathima Beevi',
    stars: 5,
    comment: 'Extremely professional and caring. Highly recommend.',
    relativeDate: '1 month ago',
  ),
  _Review(
    familyName: 'Arvind Rao',
    stars: 4,
    comment: 'Reliable and communicates well with the family.',
    relativeDate: '1 month ago',
  ),
];

/// Nurse's ratings & feedback screen — a demo-only summary plus review
/// list pushed from the "More tools" grid. "Respond" toggles a local
/// reply field per review; nothing is persisted.
class RatingsScreen extends StatefulWidget {
  final VoidCallback onBack;

  const RatingsScreen({super.key, required this.onBack});

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  final Set<int> _replying = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(title: 'Ratings & feedback', onBack: widget.onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                children: [
                  Surface(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          '4.8',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (i) {
                            return const Icon(
                              Icons.star_rounded,
                              size: 22,
                              color: AppColors.warning,
                            );
                          }),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          '32 reviews',
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
                        replying: _replying.contains(i),
                        onToggleReply: () {
                          setState(() {
                            if (_replying.contains(i)) {
                              _replying.remove(i);
                            } else {
                              _replying.add(i);
                            }
                          });
                        },
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
  final VoidCallback onToggleReply;

  const _ReviewCard({
    required this.review,
    required this.replying,
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
          const SizedBox(height: 6),
          Row(
            children: List.generate(5, (i) {
              return Icon(
                Icons.star_rounded,
                size: 16,
                color: i < review.stars ? AppColors.warning : AppColors.secondary,
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            review.comment,
            style: const TextStyle(fontSize: 13, color: AppColors.foreground),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: onToggleReply,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                replying ? 'Cancel' : 'Respond',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          if (replying) ...[
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Write a reply…',
                isDense: true,
                filled: true,
                fillColor: AppColors.secondary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              maxLines: 2,
            ),
          ],
        ],
      ),
    );
  }
}
