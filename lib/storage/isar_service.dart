import 'dart:io';
import 'package:currency_converter/storage/schemas/currency_scheme.dart';
import 'package:isar/isar.dart';

class IsarService {
  IsarService(Directory dir, List<CollectionSchema<dynamic>> schemes) {
    _db = openDB(dir, schemes);
  }

  late Future<Isar> _db;

  Future<Isar> openDB(
    Directory dir,
    List<CollectionSchema<dynamic>> schemes,
  ) async {
    if (Isar.instanceNames.isEmpty) {
      final isar = await Isar.open(
        schemes,
        directory: dir.path,
      );

      return isar;
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> addCurrencyRate(double rate, String currency) async {
    final isar = await _db;

    await isar.writeTxn(() async {
      await isar.currencys.put(
        Currency()
          ..rate = rate
          ..currency = currency,
      ); // insert & update
    });
  }

  Future<double?> getCurrencyRate(String currency) async {
    final isar = await _db;

    final currencyCollection = isar.currencys;
    final scheme =
        await currencyCollection.filter().currencyEqualTo(currency).findFirst();
    return scheme?.rate;
  }
}
