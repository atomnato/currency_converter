import 'package:isar/isar.dart';

part 'currency_scheme.g.dart';

@collection
class Currency {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  late String currency;

  late double rate;
}