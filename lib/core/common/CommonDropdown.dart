import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CommonDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final String? hint;
  final String? label;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CommonDropdown({
    super.key,
    required this.items,
    this.value,
    this.hint,
    this.label,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      selectedItem: value,

      items: (filter, infiniteScrollProps) => items,
      mode: Mode.form,
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
      ),

      popupProps: PopupProps.modalBottomSheet(
        showSearchBox: true,

        suggestedItemProps: SuggestedItemProps(
          itemClickProps: ClickProps(),
          scrollProps: ScrollProps(),
          showSuggestedItems: true,
        ),
        scrollbarProps: ScrollbarProps(thickness: 1.0),
        showSelectedItems: true,
        fit: FlexFit.loose,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            hint ?? '',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),

        containerBuilder: (ctx, popupWidget) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6, // Start height 60%
            minChildSize: 0.3, // Minimum height
            maxChildSize: 0.95, // Maximum height
            expand: false,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: popupWidget,
                ),
              );
            },
          );
        },

        modalBottomSheetProps: ModalBottomSheetProps(
          isScrollControlled: true,
          showDragHandle: true,
          backgroundColor: Colors.white,
          enableDrag: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
        ),
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "$label Search here...",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          ),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
