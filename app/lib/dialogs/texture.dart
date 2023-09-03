import 'package:butterfly/widgets/color_field.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';

class TextureView extends StatefulWidget {
  final SurfaceTexture value;
  final ValueChanged<SurfaceTexture> onChanged;

  const TextureView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<TextureView> createState() => _TextureViewState();
}

class _TextureViewState extends State<TextureView> {
  int? currentExpansionOpened = 0;

  @override
  void didUpdateWidget(covariant TextureView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorField(
          title: Text(AppLocalizations.of(context).color),
          value: Color(widget.value.boxColor),
          onChanged: (value) =>
              widget.onChanged(widget.value.copyWith(boxColor: value.value)),
        ),
        const SizedBox(height: 16),
        ExpansionPanelList(
            expansionCallback: (int item, bool status) {
              setState(() {
                currentExpansionOpened = status ? item : null;
              });
            },
            children: [
              ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: currentExpansionOpened == 0,
                  headerBuilder: (context, isExpanded) => ListTile(
                        title: Text(AppLocalizations.of(context).horizontal,
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      ColorField(
                        value: Color(widget.value.boxXColor),
                        title: Text(AppLocalizations.of(context).color),
                        onChanged: (value) => widget.onChanged(
                            widget.value.copyWith(boxXColor: value.value)),
                      ),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith(boxWidth: value)),
                          header: Text(AppLocalizations.of(context).width,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.boxWidth,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith(boxXCount: value.round())),
                          header: Text(AppLocalizations.of(context).count,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.boxXCount.toDouble(),
                          fractionDigits: 0,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith(boxXSpace: value)),
                          header: Text(AppLocalizations.of(context).space,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.boxXSpace,
                          min: 0,
                          max: 100),
                    ]),
                  )),
              ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: currentExpansionOpened == 1,
                  headerBuilder: (context, isExpanded) => ListTile(
                        title: Text(AppLocalizations.of(context).vertical,
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      ColorField(
                        title: Text(AppLocalizations.of(context).color),
                        value: Color(widget.value.boxYColor),
                        onChanged: (value) => widget.onChanged(
                            widget.value.copyWith(boxYColor: value.value)),
                      ),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith(boxHeight: value)),
                          header: Text(AppLocalizations.of(context).width,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.boxHeight,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith(boxYCount: value.round())),
                          header: Text(AppLocalizations.of(context).count,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.boxYCount.toDouble(),
                          fractionDigits: 0,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith(boxYSpace: value)),
                          header: Text(AppLocalizations.of(context).space,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.boxYSpace,
                          min: 0,
                          max: 100),
                    ]),
                  )),
            ]),
      ],
    );
  }
}
