import 'package:flutter/material.dart';

class RoundedIconButton extends StatefulWidget {
  final IconData icon;
  final void Function() onTap;
  final double borderWidth;
  final Color color;
  final double padding;
  final Color bgColor;

  final double? size;

  final Duration animationDuration;

  const RoundedIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.color,
    this.animationDuration = const Duration(milliseconds: 70),
    this.borderWidth = 1,
    this.padding = 6,
    this.bgColor = Colors.transparent,
    this.size,
  }) : super(key: key);

  @override
  State<RoundedIconButton> createState() => _RoundedIconButtonState();
}

class _RoundedIconButtonState extends State<RoundedIconButton> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.animationDuration * 0.8, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final anims = _animations();

    return GestureDetector(
      onTap: () {
        widget.onTap();
        _controller?.forward().then((value) => _controller?.reverse());
      },
      onTapDown: (_) => _controller?.forward(),
      onTapCancel: () => _controller?.reverse(),
      child: AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) => Container(
          decoration: BoxDecoration(
              color: anims[0].value,
              shape: BoxShape.circle,
              border: Border.all(width: widget.borderWidth, color: widget.color)),
          child: Padding(
            padding: EdgeInsets.all(anims[2].value),
            child: Icon(
              widget.icon,
              size: widget.size,
              color: anims[1].value,
            ),
          ),
        ),
      ),
    );
  }

  List<Animation> _animations() {
    final double animPadding = widget.padding - 2 > 0 ? widget.padding - 2 : 0;

    final bgColorTween = ColorTween(begin: widget.bgColor, end: widget.color).animate(_controller!);
    final iconColorTween = ColorTween(begin: widget.color, end: Colors.white).animate(_controller!);
    final paddingTween = Tween<double>(begin: widget.padding, end: animPadding).animate(_controller!);

    return [bgColorTween, iconColorTween, paddingTween];
  }
}
