import 'package:flutter/material.dart';

class IconDropdown extends StatefulWidget {
  final String hint;
  final List<IconData> icons;
  final IconData? value;
  final Function(dynamic value) onSelected;
  const IconDropdown(
      {super.key,
      required this.onSelected,
      required this.icons,
      required this.hint,
      this.value});

  @override
  State<IconDropdown> createState() => _IconDropdownState();
}

class _IconDropdownState extends State<IconDropdown> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    IconData? selectedIcon = widget.value;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
                selectedIcon == null
                    ? Text(
                        widget.hint,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    : Icon(selectedIcon),
                const SizedBox(height: 1, width: 1)
              ],
            ),
          ),
        ),
        isExpanded
            ? _buildDropdown(widget.icons)
            : const SizedBox(height: 0, width: 0),
      ],
    );
  }

  _buildDropdown(List icons) {
    return SizedBox(
      width: 120,
      child: ListView.builder(
          itemExtent: 50,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
          itemCount: icons.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  widget.onSelected(icons[index]);
                  isExpanded = false;
                });
              },
              child: Container(
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.grey[400]!,
                        width: 1,
                      ),
                    )),
                alignment: Alignment.centerLeft,
                child: Icon(icons[index]),
              ),
            );
          }),
    );
  }
}
