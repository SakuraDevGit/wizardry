import 'package:domain/entities/house_entities/house_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/result.dart';

abstract class HouseRepository {
  Future<Result<List<HouseEntity>, WizardingFailure>> getHouses();
}
