import 'package:flutter/material.dart';
import 'package:stt_app/core/theme/app_colors.dart';

class MicButton extends StatefulWidget {
  final bool isListening;
  final VoidCallback onPressed;

  const MicButton({
    super.key,
    required this.isListening,
    required this.onPressed,
  });

  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant MicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isListening) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: widget.isListening
          ? _scaleAnimation
          : const AlwaysStoppedAnimation(1.0),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          backgroundColor:
              widget.isListening ? AppColors.notification : AppColors.primary,
        ),
        child: Icon(
          widget.isListening ? Icons.mic : Icons.mic_off,
          color: Colors.white,
        ),
      ),
    );
  }
}
