import 'package:flutter/material.dart';
import '../../../../core/global/resources/app_color.dart';
import '../../../../core/global/resources/strings_manger.dart';
import '../../../../core/global/resources/styles_manager.dart';
import 'cancel_text_button.dart';

class SearchBarItems extends StatefulWidget {
  final TextEditingController? controller;
  final void Function()? clearSearch;
  final FocusNode focusNode;
  final void Function(String query) onSubmitted;

  const SearchBarItems({
    required this.controller,
    required this.clearSearch,
    required this.focusNode,
    required this.onSubmitted,
    super.key,
  });

  @override
  _SearchBarItemsState createState() => _SearchBarItemsState();
}

class _SearchBarItemsState extends State<SearchBarItems> {
  late TextAlign _textAlign;
  late TextDirection _textDirection;

  @override
  void initState() {
    super.initState();
    _updateTextDirectionAndAlignment(widget.controller!.text);
    widget.controller!.addListener(() {
      _updateTextDirectionAndAlignment(widget.controller!.text);
    });
  }

  void _updateTextDirectionAndAlignment(String text) {
    if (_isArabic(text)) {
      setState(() {
        _textAlign = TextAlign.right;
        _textDirection = TextDirection.rtl;
      });
    } else {
      setState(() {
        _textAlign = TextAlign.left;
        _textDirection = TextDirection.ltr;
      });
    }
  }

  bool _isArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: widget.focusNode,
              controller: widget.controller,
              cursorColor: AppColors.gold,
              style: getMediumStyle(fontSize: 16).copyWith(
                color: AppColors.black,
              ),
              textAlign: _textAlign,
              textDirection: _textDirection,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 6,
                ),
                hintText: '${AppString.search} ${AppString.appName}',
                hintStyle: getMediumStyle(fontSize: 14).copyWith(
                  color: AppColors.grey,
                ),
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: AppColors.grey,
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black12,
                border: _outlineInputBorder(),
                enabledBorder: _outlineInputBorder(),
                focusedBorder: _outlineInputBorder(),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  widget.onSubmitted(query);
                }
              },
            ),
          ),
          CancelTextButton(onPressed: widget.clearSearch),
        ],
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    );
  }
}
