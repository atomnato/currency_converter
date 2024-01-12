import 'package:currency_converter/api_client/dio_client.dart';
import 'package:currency_converter/api_client/models/api_client_option.dart';
import 'package:currency_converter/features/converter/data/converter_repository.dart';
import 'package:currency_converter/features/converter/domain/converter_interactor.dart';
import 'package:currency_converter/features/converter/presentation/manager/converter_bloc.dart';
import 'package:currency_converter/storage/isar_service.dart';
import 'package:currency_converter/storage/schemas/currency_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> bootstrap(Widget child) async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();

//  final isar = Isar.open([], directory: dir.path);

  runApp(
    MultiProvider(
      providers: [
        Provider<IsarService>(
          create: (context) {
            return IsarService(dir, [CurrencySchema]);
          },
          lazy: false,
        ),
        Provider<DioClient>(
          create: (context) {
            return DioClient(
              ApiClientOption(
                endpoint: Uri.parse('http://api.exchangeratesapi.io')
                    .replace(path: 'v1'),
                headers: {
                  'Accept': 'application/json',
                },
              ),
            );
          },
          lazy: false,
        ),
        ChangeNotifierProvider<ConverterInteractor>(
          create: (context) {
            return ConverterInteractor(
              ConverterRepository(
                Provider.of<DioClient>(context, listen: false),
              ),
              Provider.of<IsarService>(context, listen: false),
            );
          },
          lazy: false,
        ),
        BlocProvider(
          create: (context) {
            final interactor = Provider.of<ConverterInteractor>(
              context,
              listen: false,
            );

            return ConverterBloc(interactor);
          },
        ),
      ],
      child: child,
    ),
  );
}
