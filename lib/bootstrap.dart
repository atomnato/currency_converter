import 'package:currency_converter/api_client/dio_client.dart';
import 'package:currency_converter/api_client/models/api_client_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> bootstrap(Widget child) async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();

  final isar = Isar.open([], directory: dir.path);

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: isar),
        Provider(
          create: (context) {
            return DioClient(
              ApiClientOption(
                endpoint: Uri.parse('https://api.exchangeratesapi.io')
                    .replace(path: 'v1'),
                headers: {
                  'Accept': 'application/json',
                },
              ),
            );
          },
          lazy: false,
        ),
      ],
      child: child,
    ),
  );
}
