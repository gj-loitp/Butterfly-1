import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/color_pick.dart';
import 'package:butterfly/painter/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LabelPainterDialog extends StatefulWidget {
  final DocumentBloc bloc;
  final int painterIndex;
  const LabelPainterDialog({Key? key, required this.bloc, required this.painterIndex})
      : super(key: key);

  @override
  _LabelPainterDialogState createState() => _LabelPainterDialogState();
}

class _LabelPainterDialogState extends State<LabelPainterDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Dialog(child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
        if (state is! DocumentLoadSuccess) return Container();
        var painter = state.document.painters[widget.painterIndex] as LabelPainter;
        return Container(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: StatefulBuilder(builder: (context, setState) {
              if (_nameController.text != painter.name) _nameController.text = painter.name;
              if (_sizeController.text != painter.size.toStringAsFixed(2)) {
                _sizeController.text = painter.size.toStringAsFixed(2);
              }
              return Scaffold(
                  appBar: AppBar(
                    title: const Text("Text"),
                    leading: const Icon(PhosphorIcons.textTLight),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(children: [
                            TextField(
                                decoration: const InputDecoration(labelText: "Name"),
                                controller: _nameController,
                                onChanged: (value) =>
                                    setState(() => painter = painter.copyWith(name: value))),
                            Row(children: [
                              ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 100),
                                  child: TextField(
                                    decoration: const InputDecoration(labelText: "Size"),
                                    controller: _sizeController,
                                    onChanged: (value) => setState(() =>
                                        painter = painter.copyWith(size: double.tryParse(value))),
                                  )),
                              Expanded(
                                child: Slider(
                                    value: painter.size.clamp(6, 96),
                                    min: 6,
                                    max: 96,
                                    onChanged: (value) =>
                                        setState(() => painter = painter.copyWith(size: value))),
                              )
                            ]),
                            const SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () async {
                                      var color = await showDialog(
                                          context: context,
                                          builder: (context) => const ColorPickerDialog());
                                      if (color != null) {
                                        setState(() => painter = painter.copyWith(color: color));
                                      }
                                    },
                                    child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 100, maxHeight: 100),
                                        color: painter.color)),
                              ],
                            )
                          ]),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  primary: Theme.of(context).colorScheme.error),
                              child: const Text("DELETE"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            actions: [
                                              TextButton(
                                                child: const Text("NO"),
                                                onPressed: () => Navigator.of(context).pop(),
                                              ),
                                              TextButton(
                                                child: const Text("YES"),
                                                onPressed: () {
                                                  widget.bloc
                                                      .add(PainterRemoved(widget.painterIndex));
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                            title: const Text("Are you sure?"),
                                            content: const Text(
                                                "Do you really want to delete this pen?")));
                              },
                            ),
                            Expanded(child: Container()),
                            TextButton(
                              child: const Text("CANCEL"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              child: const Text("OK"),
                              onPressed: () {
                                widget.bloc.add(PainterChanged(painter, widget.painterIndex));
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
            }));
      })),
    );
  }
}