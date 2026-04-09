import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../app/theme.dart';
import '../../core/models/ingredient.dart';
import '../../core/services/grind_session_provider.dart';

class GrindSessionScreen extends StatefulWidget {
  const GrindSessionScreen({super.key});

  @override
  State<GrindSessionScreen> createState() => _GrindSessionScreenState();
}

class _GrindSessionScreenState extends State<GrindSessionScreen> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    final provider = context.read<GrindSessionProvider>();
    final session = provider.session;
    if (session != null) {
      for (final ing in session.recipe.ingredients) {
        _controllers[ing.id] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _onStartGrinder() async {
    final provider = context.read<GrindSessionProvider>();
    await provider.startGrinder();
    if (mounted && provider.isCompleted) {
      context.pushReplacement('/grind/summary');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GrindSessionProvider>(
      builder: (context, provider, _) {
        final session = provider.session;
        if (session == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Session')),
            body: const Center(child: Text('Walang aktibong session.')),
          );
        }

        final recipe = session.recipe;
        final ingredients = recipe.ingredients;
        final passed = provider.passedCount;
        final total = provider.totalCount;
        final canStart = provider.canStartGrinder;
        final isGrinding = provider.isGrinding;

        return PopScope(
          canPop: !isGrinding,
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: CustomScrollView(
              slivers: [
                // ── App Bar ────────────────────────────────────
                SliverAppBar(
                  pinned: true,
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  title: Text(
                    'Paghahanda ng Halo',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white70),
                      onPressed: isGrinding
                          ? null
                          : () {
                              provider.cancelSession();
                              context.pop();
                            },
                    ),
                  ],
                ),
                // ── Progress Header ─────────────────────────────
                SliverToBoxAdapter(
                  child: _ProgressHeader(
                    recipe: recipe.name,
                    batchKg: session.batchSizeKg,
                    passed: passed,
                    total: total,
                    isGrinding: isGrinding,
                    grindProgress: provider.grindProgress,
                  ),
                ),
                // ── Ingredient List ─────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final ing = ingredients[i];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _IngredientWeightTile(
                            ingredient: ing,
                            batchKg: session.batchSizeKg,
                            controller: _controllers[ing.id]!,
                            isPassed: provider.isIngredientPassed(ing),
                            isMeasured: session.isIngredientMeasured(ing.id),
                            isLocked: isGrinding,
                            onChanged: (value) {
                              final parsed = double.tryParse(value);
                              provider.updateWeight(ing.id, parsed);
                            },
                            index: i,
                          ),
                        );
                      },
                      childCount: ingredients.length,
                    ),
                  ),
                ),
              ],
            ),
            // ── Start Button ────────────────────────────────────
            bottomNavigationBar: _StartButton(
              canStart: canStart,
              isGrinding: isGrinding,
              onPressed: canStart && !isGrinding ? _onStartGrinder : null,
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Progress Header
// ─────────────────────────────────────────────────────────────────────────────

class _ProgressHeader extends StatelessWidget {
  final String recipe;
  final double batchKg;
  final int passed;
  final int total;
  final bool isGrinding;
  final int grindProgress;

  const _ProgressHeader({
    required this.recipe,
    required this.batchKg,
    required this.passed,
    required this.total,
    required this.isGrinding,
    required this.grindProgress,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = total == 0 ? 0.0 : passed / total;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.headerGradientStart, AppColors.headerGradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipe,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Batch: ${batchKg.toStringAsFixed(0)} kg',
            style: GoogleFonts.poppins(color: Colors.white60, fontSize: 12),
          ),
          const SizedBox(height: 14),
          if (isGrinding) ...[
            Text(
              'Naggiginggiling...',
              style: GoogleFonts.poppins(
                color: AppColors.accentLight,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: grindProgress / 100,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
              minHeight: 10,
              borderRadius: BorderRadius.circular(20),
            ),
            const SizedBox(height: 4),
            Text(
              '$grindProgress%',
              style: GoogleFonts.poppins(color: Colors.white60, fontSize: 11),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: ratio,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ratio == 1.0 ? AppColors.success : AppColors.accent,
                    ),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '$passed / $total',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ratio == 1.0
                  ? '✅ Lahat ay Tama! Maaari nang simulan ang gilingan.'
                  : 'Sangkap na nasukat nang tama',
              style: GoogleFonts.poppins(
                color: ratio == 1.0 ? AppColors.accentLight : Colors.white60,
                fontSize: 12,
                fontWeight: ratio == 1.0 ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Ingredient Weight Tile
// ─────────────────────────────────────────────────────────────────────────────

class _IngredientWeightTile extends StatelessWidget {
  final Ingredient ingredient;
  final double batchKg;
  final TextEditingController controller;
  final bool isPassed;
  final bool isMeasured;
  final bool isLocked;
  final ValueChanged<String> onChanged;
  final int index;

  const _IngredientWeightTile({
    required this.ingredient,
    required this.batchKg,
    required this.controller,
    required this.isPassed,
    required this.isMeasured,
    required this.isLocked,
    required this.onChanged,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final target = ingredient.targetWeightForBatch(batchKg);
    final tol = ingredient.toleranceKgForBatch(batchKg);

    Color borderColor = AppColors.divider;
    Color statusBg = Colors.transparent;
    Widget statusIcon = const SizedBox.shrink();

    if (isMeasured) {
      if (isPassed) {
        borderColor = AppColors.success;
        statusBg = AppColors.success.withOpacity(0.06);
        statusIcon = const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 26);
      } else {
        borderColor = AppColors.error;
        statusBg = AppColors.error.withOpacity(0.06);
        statusIcon = const Icon(Icons.cancel_rounded, color: AppColors.error, size: 26);
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isMeasured ? statusBg : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: isMeasured ? 1.5 : 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ingredient.name,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        ingredient.nameEn,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.textLight,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                statusIcon,
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _WeightBadge(
                  label: 'Target',
                  value: '${target.toStringAsFixed(2)} kg',
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                _WeightBadge(
                  label: 'Pagpapaluwag',
                  value: '±${tol.toStringAsFixed(2)} kg',
                  color: AppColors.textSecondary,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    enabled: !isLocked,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    onChanged: onChanged,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      suffixText: 'kg',
                      suffixStyle: GoogleFonts.poppins(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (isMeasured && !isPassed)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'Ang nasukat ay hindi nasa loob ng pagpapaluwag. I-adjust ang timbang.',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 70).ms).slideY(begin: 0.15);
  }
}

class _WeightBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _WeightBadge({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 9, color: color)),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Start Button
// ─────────────────────────────────────────────────────────────────────────────

class _StartButton extends StatelessWidget {
  final bool canStart;
  final bool isGrinding;
  final VoidCallback? onPressed;

  const _StartButton({
    required this.canStart,
    required this.isGrinding,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + bottomInset),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!canStart && !isGrinding)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_rounded, size: 14, color: AppColors.textLight),
                  const SizedBox(width: 6),
                  Text(
                    'Susukat pa ang lahat ng sangkap bago magsimula',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: canStart && !isGrinding
                    ? const LinearGradient(
                        colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                      )
                    : null,
                color: canStart && !isGrinding ? null : AppColors.divider,
                borderRadius: BorderRadius.circular(14),
                boxShadow: canStart && !isGrinding
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(14),
                  child: Center(
                    child: isGrinding
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Naggiginggiling...',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                canStart ? Icons.blender_rounded : Icons.lock_rounded,
                                color: canStart ? Colors.white : AppColors.textLight,
                                size: 22,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'SIMULAN ANG GILINGAN',
                                style: GoogleFonts.poppins(
                                  color: canStart ? Colors.white : AppColors.textLight,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
