import 'package:flutter/material.dart';

/// One row in an [ExpandableFab]'s expanded menu.
class FabAction {
  const FabAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

/// A FAB that expands upward into a labeled menu of quick actions, and
/// collapses back into a plain "+" (rotated into an "×" while open).
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({super.key, required this.actions});

  final List<FabAction> actions;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 240),
  );
  bool _isOpen = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isOpen = !_isOpen);
    _isOpen ? _controller.forward() : _controller.reverse();
  }

  void _runAction(VoidCallback onTap) {
    _toggle();
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final action in widget.actions)
          _AnimatedActionItem(
            animation: _controller,
            action: action,
            onTap: () => _runAction(action.onTap),
          ),
        FloatingActionButton(
          heroTag: 'dashboard-fab',
          onPressed: _toggle,
          child: AnimatedRotation(
            turns: _isOpen ? 0.125 : 0,
            duration: const Duration(milliseconds: 240),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class _AnimatedActionItem extends StatelessWidget {
  const _AnimatedActionItem({
    required this.animation,
    required this.action,
    required this.onTap,
  });

  final Animation<double> animation;
  final FabAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        if (animation.value == 0) return const SizedBox.shrink();
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - animation.value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Material(
              color: Theme.of(context).colorScheme.surface,
              elevation: 3,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                child: Text(
                  action.label,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(width: 10),
            FloatingActionButton.small(
              heroTag: action.label,
              onPressed: onTap,
              child: Icon(action.icon),
            ),
          ],
        ),
      ),
    );
  }
}
