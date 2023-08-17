import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opticash/core/widgets/app_text.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height,
    this.title,
    this.bottom,
    this.leadingItem,
    this.hasLeading = false,
    this.action,
    this.beforePop,
    this.bgColor = Colors.white,
  });

  final double? height;
  final String? title;
  final Widget? leadingItem;
  final bool hasLeading;
  final List<Widget>? action;
  final PreferredSizeWidget? bottom;
  final VoidCallback? beforePop;
  final Color bgColor;

  @override
  State<CustomAppBar> createState() => CustomAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, height ?? 54);
}

class CustomAppBarState extends State<CustomAppBar> {
  Widget? leading;

  @override
  void initState() {
    if (widget.hasLeading && widget.leadingItem == null) {
      leading = GestureDetector(
        onTap: () {
          if (widget.beforePop != null) widget.beforePop!();
          Navigator.of(context).pop();
        },
        child: Row(
          children: [
            SizedBox(
              child: Center(
                child: Container(
                  width: 30,
                  height: 34,
                  margin: EdgeInsets.only(left: 21.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.5, color: Color(0xFF100B0B).withOpacity(0.6)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.chevron_left_sharp,
                      size: 30,
                      color: Color(0xFF333333),
                      semanticLabel: "Back button",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      leading = widget.leadingItem;
    }
    super.initState();
  }

  Widget? get _title {
    return widget.title != null ? AppText(widget.title!, size: 15, weight: FontWeight.w600) : null;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      leadingWidth: 52,
      centerTitle: true,
      title: _title,
      automaticallyImplyLeading: false,
      bottom: widget.bottom,
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: widget.bgColor,
      actions: widget.action,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}
