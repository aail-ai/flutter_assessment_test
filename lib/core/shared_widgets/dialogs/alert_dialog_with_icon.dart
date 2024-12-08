import 'package:flutter/material.dart';

class AlertDialogWithIcon extends StatelessWidget {
  final String? title, description;
  final String? buttonText;
  final Widget? image;
  final Color? color;
  final VoidCallback? onConfirmed;
  final VoidCallback? onCanceled;
  final VoidCallback? onButtonTextPressed;
  final bool centeredTitle;
  final String? onConfirmText;
  final Widget Function(BuildContext context)? builder;
  final String? onCanceledText;
  final double? dialogMargin;
  final EdgeInsets? insetPadding;

  const AlertDialogWithIcon({
    super.key,
    this.title,
    this.description,
    this.buttonText,
    this.centeredTitle = false,
    this.image,
    this.color,
    this.onConfirmed,
    this.onCanceled,
    this.onButtonTextPressed,
    this.onCanceledText,
    this.builder,
    this.onConfirmText,
    this.dialogMargin,
    this.insetPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: insetPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: 40.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          margin: const EdgeInsets.only(top: 24.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: builder != null
              ? builder!(context)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (title != null)
                      Text(
                        title!,
                        textAlign: centeredTitle ? TextAlign.center : TextAlign.start,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    const SizedBox(height: 16.0),
                    if (description != null)
                      Text(
                        description!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          height: 1.5,
                          fontSize: 14.0,
                        ),
                      ),
                    const SizedBox(height: 24.0),
                    (onConfirmed == null || onCanceled == null)
                        ? Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                onButtonTextPressed?.call();
                              },
                              child: Text(
                                "${buttonText?.toUpperCase()}",
                                style: const TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                  onCanceled?.call();
                                },
                                child: Text(
                                  onCanceledText.toString(),
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0xffDD4E10), fontWeight: FontWeight.w600),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  onConfirmed?.call();
                                },
                                child: Text(
                                  onConfirmText.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF2E3C82),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          child: CircleAvatar(
            backgroundColor: color ?? const Color(0xFF2E3C82),
            radius: 24.0,
            child: image ??
                const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
          ),
        ),
      ],
    );
  }
}
