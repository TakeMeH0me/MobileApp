import 'package:flutter/material.dart';

class EditCard extends StatefulWidget {
  final Widget mainContent;
  final Icon? leadingIcon;

  const EditCard({
    super.key,
    required this.mainContent,
    this.leadingIcon,
  });

  @override
  State<EditCard> createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: ListTile(
        leading: widget.leadingIcon,
        title: widget.mainContent,
      ),
    );
  }
}
