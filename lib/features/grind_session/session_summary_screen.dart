import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../app/theme.dart';
import '../../core/models/animal_category.dart';
import '../../core/services/grind_session_provider.dart';
import '../../core/services/session_history_service.dart';

class SessionSummaryScreen extends StatelessWidget {
  const SessionSummaryScreen({super.key});

  String _formatDuration(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GrindSessionProvider>();
    final historyService = context.read<SessionHistoryService>();
    final session = provider.session;

    if (session == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Walang Session',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Bumalik sa Simula'),
              ),
            ],
          ),
        ),
      );
    }

    final recipe = session.recipe;
    final elapsed = session.elapsed;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Success Header ────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.headerGradientStart, AppColors.success],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
                  child: Column(
                    children: [
                      const Text('✅', style: TextStyle(fontSize: 64))
                          .animate()
                          .scale(duration: 400.ms, curve: Curves.elasticOut),
                      const SizedBox(height: 16),
                      Text(
                        'Tapos na ang Paggiling!',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),
                      const SizedBox(height: 6),
                      Text(
                        'Matagumpay na naihanda ang pagkain!',
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 400.ms),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // ── Stats ────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Recipe info
                _SummaryCard(
                  child: Column(
                    children: [
                      _SummaryRow(
                        icon: Icons.menu_book_rounded,
                        label: 'Resipe',
                        value: recipe.name,
                      ),
                      const Divider(height: 20),
                      _SummaryRow(
                        icon: recipe.animalCategory.emoji,
                        label: 'Hayop',
                        value: recipe.animalCategory.displayName,
                        isEmoji: true,
                      ),
                      const Divider(height: 20),
                      _SummaryRow(
                        icon: Icons.scale_rounded,
                        label: 'Batch',
                        value: '${session.batchSizeKg.toStringAsFixed(0)} kg',
                      ),
                      const Divider(height: 20),
                      _SummaryRow(
                        icon: Icons.timer_rounded,
                        label: 'Oras ng Paggiling',
                        value: _formatDuration(elapsed),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                const SizedBox(height: 20),
                Text(
                  'Mga Sangkap na Nasukat',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ).animate().fadeIn(delay: 300.ms),
                const SizedBox(height: 12),
                // Ingredient results
                ...recipe.ingredients.asMap().entries.map((entry) {
                  final i = entry.key;
                  final ing = entry.value;
                  final measured = session.measuredWeights[ing.id];
                  final target = ing.targetWeightForBatch(session.batchSizeKg);
                  final passed = session.isIngredientPassed(ing);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: passed
                              ? AppColors.success.withOpacity(0.3)
                              : AppColors.error.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            passed
                                ? Icons.check_circle_rounded
                                : Icons.cancel_rounded,
                            color: passed ? AppColors.success : AppColors.error,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ing.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  'Target: ${target.toStringAsFixed(2)} kg',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                measured != null
                                    ? '${measured.toStringAsFixed(2)} kg'
                                    : '-',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: passed
                                      ? AppColors.success
                                      : AppColors.error,
                                ),
                              ),
                              Text(
                                passed ? 'Tama ✅' : 'Mali ❌',
                                style: GoogleFonts.poppins(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: (350 + i * 60).ms).slideX(begin: 0.1),
                  );
                }),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final history = provider.createSessionHistory();
                      if (history != null) {
                        historyService.saveSession(history);
                      }
                      provider.clearSession();
                      context.go('/');
                    },
                    icon: const Icon(Icons.home_rounded),
                    label: const Text('Bumalik sa Simula'),
                  ),
                ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      final history = provider.createSessionHistory();
                      if (history != null) {
                        historyService.saveSession(history);
                      }
                      provider.clearSession();
                      context.go('/recipes');
                    },
                    icon: const Icon(
                      Icons.menu_book_rounded,
                      color: AppColors.primary,
                    ),
                    label: Text(
                      'Pumili ng Bagong Resipe',
                      style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 650.ms).slideY(begin: 0.3),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final Widget child;
  const _SummaryCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final dynamic icon;
  final String label;
  final String value;
  final bool isEmoji;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isEmoji = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isEmoji
            ? Text(icon as String, style: const TextStyle(fontSize: 20))
            : Icon(icon as IconData, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
