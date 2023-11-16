part of 'dialog.dart';

class StartCollaborationDialog extends StatefulWidget {
  final NetworkingService service;

  const StartCollaborationDialog({super.key, required this.service});

  @override
  State<StartCollaborationDialog> createState() =>
      _StartCollaborationDialogState();
}

class _StartCollaborationDialogState extends State<StartCollaborationDialog>
    with TickerProviderStateMixin {
  final TextEditingController _portController = TextEditingController();

  void _start() {
    if (kIsWeb) return;
    widget.service.createSocketServer(int.tryParse(_portController.text));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AlertDialog(
        title: Text(AppLocalizations.of(context).collaboration),
        content: kIsWeb
            ? Text(AppLocalizations.of(context).webNotSupported)
            : TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).port,
                  hintText: kDefaultPort.toString(),
                  filled: true,
                ),
                controller: _portController,
                keyboardType: TextInputType.number,
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).close),
          ),
          ElevatedButton(
            onPressed: kIsWeb
                ? null
                : () {
                    Navigator.of(context).pop();
                    _start();
                  },
            child: Text(AppLocalizations.of(context).start),
          ),
        ],
      ),
    );
  }
}
