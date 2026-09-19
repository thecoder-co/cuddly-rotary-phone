// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMedicationLocalCollection on Isar {
  IsarCollection<MedicationLocal> get medicationLocals => this.collection();
}

const MedicationLocalSchema = CollectionSchema(
  name: r'MedicationLocal',
  id: -3083972601947134369,
  properties: {
    r'backendId': PropertySchema(
      id: 0,
      name: r'backendId',
      type: IsarType.string,
    ),
    r'brandName': PropertySchema(
      id: 1,
      name: r'brandName',
      type: IsarType.string,
    ),
    r'clientId': PropertySchema(
      id: 2,
      name: r'clientId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'displayName': PropertySchema(
      id: 4,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'form': PropertySchema(id: 5, name: r'form', type: IsarType.string),
    r'genericName': PropertySchema(
      id: 6,
      name: r'genericName',
      type: IsarType.string,
    ),
    r'image': PropertySchema(id: 7, name: r'image', type: IsarType.string),
    r'instructions': PropertySchema(
      id: 8,
      name: r'instructions',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(id: 9, name: r'notes', type: IsarType.string),
    r'pharmacy': PropertySchema(
      id: 10,
      name: r'pharmacy',
      type: IsarType.string,
    ),
    r'prescriber': PropertySchema(
      id: 11,
      name: r'prescriber',
      type: IsarType.string,
    ),
    r'privateLabel': PropertySchema(
      id: 12,
      name: r'privateLabel',
      type: IsarType.string,
    ),
    r'purpose': PropertySchema(id: 13, name: r'purpose', type: IsarType.string),
    r'route': PropertySchema(id: 14, name: r'route', type: IsarType.string),
    r'status': PropertySchema(
      id: 15,
      name: r'status',
      type: IsarType.byte,
      enumMap: _MedicationLocalstatusEnumValueMap,
    ),
    r'strengthUnit': PropertySchema(
      id: 16,
      name: r'strengthUnit',
      type: IsarType.string,
    ),
    r'strengthValue': PropertySchema(
      id: 17,
      name: r'strengthValue',
      type: IsarType.double,
    ),
    r'syncError': PropertySchema(
      id: 18,
      name: r'syncError',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 19,
      name: r'syncStatus',
      type: IsarType.byte,
      enumMap: _MedicationLocalsyncStatusEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 20,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'version': PropertySchema(id: 21, name: r'version', type: IsarType.long),
  },

  estimateSize: _medicationLocalEstimateSize,
  serialize: _medicationLocalSerialize,
  deserialize: _medicationLocalDeserialize,
  deserializeProp: _medicationLocalDeserializeProp,
  idName: r'id',
  indexes: {
    r'clientId': IndexSchema(
      id: 2639372232964765565,
      name: r'clientId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'clientId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'backendId': IndexSchema(
      id: 8781752057772026410,
      name: r'backendId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'backendId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'displayName': IndexSchema(
      id: -825365117524145674,
      name: r'displayName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'displayName',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _medicationLocalGetId,
  getLinks: _medicationLocalGetLinks,
  attach: _medicationLocalAttach,
  version: '3.3.2',
);

int _medicationLocalEstimateSize(
  MedicationLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.backendId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.brandName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.clientId.length * 3;
  bytesCount += 3 + object.displayName.length * 3;
  {
    final value = object.form;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.genericName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.instructions;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pharmacy;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.prescriber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.privateLabel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.purpose;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.route;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.strengthUnit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.syncError;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _medicationLocalSerialize(
  MedicationLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.backendId);
  writer.writeString(offsets[1], object.brandName);
  writer.writeString(offsets[2], object.clientId);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.displayName);
  writer.writeString(offsets[5], object.form);
  writer.writeString(offsets[6], object.genericName);
  writer.writeString(offsets[7], object.image);
  writer.writeString(offsets[8], object.instructions);
  writer.writeString(offsets[9], object.notes);
  writer.writeString(offsets[10], object.pharmacy);
  writer.writeString(offsets[11], object.prescriber);
  writer.writeString(offsets[12], object.privateLabel);
  writer.writeString(offsets[13], object.purpose);
  writer.writeString(offsets[14], object.route);
  writer.writeByte(offsets[15], object.status.index);
  writer.writeString(offsets[16], object.strengthUnit);
  writer.writeDouble(offsets[17], object.strengthValue);
  writer.writeString(offsets[18], object.syncError);
  writer.writeByte(offsets[19], object.syncStatus.index);
  writer.writeDateTime(offsets[20], object.updatedAt);
  writer.writeLong(offsets[21], object.version);
}

MedicationLocal _medicationLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicationLocal();
  object.backendId = reader.readStringOrNull(offsets[0]);
  object.brandName = reader.readStringOrNull(offsets[1]);
  object.clientId = reader.readString(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.displayName = reader.readString(offsets[4]);
  object.form = reader.readStringOrNull(offsets[5]);
  object.genericName = reader.readStringOrNull(offsets[6]);
  object.id = id;
  object.image = reader.readStringOrNull(offsets[7]);
  object.instructions = reader.readStringOrNull(offsets[8]);
  object.notes = reader.readStringOrNull(offsets[9]);
  object.pharmacy = reader.readStringOrNull(offsets[10]);
  object.prescriber = reader.readStringOrNull(offsets[11]);
  object.privateLabel = reader.readStringOrNull(offsets[12]);
  object.purpose = reader.readStringOrNull(offsets[13]);
  object.route = reader.readStringOrNull(offsets[14]);
  object.status =
      _MedicationLocalstatusValueEnumMap[reader.readByteOrNull(offsets[15])] ??
      MedicationStatus.active;
  object.strengthUnit = reader.readStringOrNull(offsets[16]);
  object.strengthValue = reader.readDoubleOrNull(offsets[17]);
  object.syncError = reader.readStringOrNull(offsets[18]);
  object.syncStatus =
      _MedicationLocalsyncStatusValueEnumMap[reader.readByteOrNull(
        offsets[19],
      )] ??
      MedicationSyncStatus.synced;
  object.updatedAt = reader.readDateTime(offsets[20]);
  object.version = reader.readLong(offsets[21]);
  return object;
}

P _medicationLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (_MedicationLocalstatusValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              MedicationStatus.active)
          as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (_MedicationLocalsyncStatusValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              MedicationSyncStatus.synced)
          as P;
    case 20:
      return (reader.readDateTime(offset)) as P;
    case 21:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MedicationLocalstatusEnumValueMap = {
  'active': 0,
  'paused': 1,
  'archived': 2,
};
const _MedicationLocalstatusValueEnumMap = {
  0: MedicationStatus.active,
  1: MedicationStatus.paused,
  2: MedicationStatus.archived,
};
const _MedicationLocalsyncStatusEnumValueMap = {
  'synced': 0,
  'pendingCreate': 1,
  'pendingUpdate': 2,
  'pendingDelete': 3,
  'failed': 4,
};
const _MedicationLocalsyncStatusValueEnumMap = {
  0: MedicationSyncStatus.synced,
  1: MedicationSyncStatus.pendingCreate,
  2: MedicationSyncStatus.pendingUpdate,
  3: MedicationSyncStatus.pendingDelete,
  4: MedicationSyncStatus.failed,
};

Id _medicationLocalGetId(MedicationLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _medicationLocalGetLinks(MedicationLocal object) {
  return [];
}

void _medicationLocalAttach(
  IsarCollection<dynamic> col,
  Id id,
  MedicationLocal object,
) {
  object.id = id;
}

extension MedicationLocalByIndex on IsarCollection<MedicationLocal> {
  Future<MedicationLocal?> getByClientId(String clientId) {
    return getByIndex(r'clientId', [clientId]);
  }

  MedicationLocal? getByClientIdSync(String clientId) {
    return getByIndexSync(r'clientId', [clientId]);
  }

  Future<bool> deleteByClientId(String clientId) {
    return deleteByIndex(r'clientId', [clientId]);
  }

  bool deleteByClientIdSync(String clientId) {
    return deleteByIndexSync(r'clientId', [clientId]);
  }

  Future<List<MedicationLocal?>> getAllByClientId(List<String> clientIdValues) {
    final values = clientIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'clientId', values);
  }

  List<MedicationLocal?> getAllByClientIdSync(List<String> clientIdValues) {
    final values = clientIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'clientId', values);
  }

  Future<int> deleteAllByClientId(List<String> clientIdValues) {
    final values = clientIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'clientId', values);
  }

  int deleteAllByClientIdSync(List<String> clientIdValues) {
    final values = clientIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'clientId', values);
  }

  Future<Id> putByClientId(MedicationLocal object) {
    return putByIndex(r'clientId', object);
  }

  Id putByClientIdSync(MedicationLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'clientId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByClientId(List<MedicationLocal> objects) {
    return putAllByIndex(r'clientId', objects);
  }

  List<Id> putAllByClientIdSync(
    List<MedicationLocal> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'clientId', objects, saveLinks: saveLinks);
  }

  Future<MedicationLocal?> getByBackendId(String? backendId) {
    return getByIndex(r'backendId', [backendId]);
  }

  MedicationLocal? getByBackendIdSync(String? backendId) {
    return getByIndexSync(r'backendId', [backendId]);
  }

  Future<bool> deleteByBackendId(String? backendId) {
    return deleteByIndex(r'backendId', [backendId]);
  }

  bool deleteByBackendIdSync(String? backendId) {
    return deleteByIndexSync(r'backendId', [backendId]);
  }

  Future<List<MedicationLocal?>> getAllByBackendId(
    List<String?> backendIdValues,
  ) {
    final values = backendIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'backendId', values);
  }

  List<MedicationLocal?> getAllByBackendIdSync(List<String?> backendIdValues) {
    final values = backendIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'backendId', values);
  }

  Future<int> deleteAllByBackendId(List<String?> backendIdValues) {
    final values = backendIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'backendId', values);
  }

  int deleteAllByBackendIdSync(List<String?> backendIdValues) {
    final values = backendIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'backendId', values);
  }

  Future<Id> putByBackendId(MedicationLocal object) {
    return putByIndex(r'backendId', object);
  }

  Id putByBackendIdSync(MedicationLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'backendId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByBackendId(List<MedicationLocal> objects) {
    return putAllByIndex(r'backendId', objects);
  }

  List<Id> putAllByBackendIdSync(
    List<MedicationLocal> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'backendId', objects, saveLinks: saveLinks);
  }
}

extension MedicationLocalQueryWhereSort
    on QueryBuilder<MedicationLocal, MedicationLocal, QWhere> {
  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MedicationLocalQueryWhere
    on QueryBuilder<MedicationLocal, MedicationLocal, QWhereClause> {
  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause>
  clientIdEqualTo(String clientId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'clientId', value: [clientId]),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause>
  clientIdNotEqualTo(String clientId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientId',
                lower: [],
                upper: [clientId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientId',
                lower: [clientId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientId',
                lower: [clientId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientId',
                lower: [],
                upper: [clientId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause>
  backendIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'backendId', value: [null]),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause>
  backendIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'backendId',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause>
  backendIdEqualTo(String? backendId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'backendId', value: [backendId]),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause>
  backendIdNotEqualTo(String? backendId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'backendId',
                lower: [],
                upper: [backendId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'backendId',
                lower: [backendId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'backendId',
                lower: [backendId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'backendId',
                lower: [],
                upper: [backendId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause>
  displayNameEqualTo(String displayName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'displayName',
          value: [displayName],
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterWhereClause>
  displayNameNotEqualTo(String displayName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'displayName',
                lower: [],
                upper: [displayName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'displayName',
                lower: [displayName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'displayName',
                lower: [displayName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'displayName',
                lower: [],
                upper: [displayName],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension MedicationLocalQueryFilter
    on QueryBuilder<MedicationLocal, MedicationLocal, QFilterCondition> {
  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'backendId'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'backendId'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'backendId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'backendId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'backendId', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  backendIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'backendId', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'brandName'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'brandName'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'brandName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'brandName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'brandName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'brandName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'brandName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'brandName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'brandName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'brandName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'brandName', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  brandNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'brandName', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  clientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  clientIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  clientIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  clientIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clientId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  clientIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  clientIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  clientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  clientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'clientId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  clientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'clientId', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  clientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'clientId', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  displayNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  displayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  displayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  displayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'displayName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  displayNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  displayNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'displayName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'displayName', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'displayName', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'form'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'form'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'form',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'form',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'form',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'form',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'form',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'form',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'form',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'form',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'form', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  formIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'form', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'genericName'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'genericName'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'genericName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'genericName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'genericName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'genericName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'genericName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'genericName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'genericName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'genericName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'genericName', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  genericNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'genericName', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'image'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'image'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'image',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'image',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'image', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'image', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'instructions'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'instructions'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'instructions',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'instructions',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'instructions', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  instructionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'instructions', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'pharmacy'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'pharmacy'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pharmacy',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pharmacy',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pharmacy',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pharmacy',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'pharmacy',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'pharmacy',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'pharmacy',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'pharmacy',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pharmacy', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  pharmacyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'pharmacy', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'prescriber'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'prescriber'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'prescriber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'prescriber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'prescriber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'prescriber',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'prescriber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'prescriber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'prescriber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'prescriber',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'prescriber', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  prescriberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'prescriber', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'privateLabel'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'privateLabel'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'privateLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'privateLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'privateLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'privateLabel',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'privateLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'privateLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'privateLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'privateLabel',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'privateLabel', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  privateLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'privateLabel', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'purpose'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'purpose'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'purpose',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'purpose',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'purpose',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'purpose',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'purpose',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'purpose',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'purpose',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'purpose',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'purpose', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  purposeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'purpose', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'route'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'route'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'route',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'route',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'route',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'route',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'route',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'route',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'route',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'route',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'route', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  routeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'route', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  statusEqualTo(MedicationStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: value),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  statusGreaterThan(MedicationStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  statusLessThan(MedicationStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  statusBetween(
    MedicationStatus lower,
    MedicationStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'strengthUnit'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'strengthUnit'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'strengthUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'strengthUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'strengthUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'strengthUnit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'strengthUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'strengthUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'strengthUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'strengthUnit',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'strengthUnit', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'strengthUnit', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'strengthValue'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'strengthValue'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthValueEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'strengthValue',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthValueGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'strengthValue',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthValueLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'strengthValue',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  strengthValueBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'strengthValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'syncError'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'syncError'),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'syncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'syncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'syncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'syncError',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'syncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'syncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'syncError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'syncError',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncError', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncErrorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'syncError', value: ''),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncStatusEqualTo(MedicationSyncStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncStatus', value: value),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncStatusGreaterThan(MedicationSyncStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'syncStatus',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncStatusLessThan(MedicationSyncStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'syncStatus',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  syncStatusBetween(
    MedicationSyncStatus lower,
    MedicationSyncStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'syncStatus',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'version', value: value),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  versionGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'version',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  versionLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'version',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterFilterCondition>
  versionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'version',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension MedicationLocalQueryObject
    on QueryBuilder<MedicationLocal, MedicationLocal, QFilterCondition> {}

extension MedicationLocalQueryLinks
    on QueryBuilder<MedicationLocal, MedicationLocal, QFilterCondition> {}

extension MedicationLocalQuerySortBy
    on QueryBuilder<MedicationLocal, MedicationLocal, QSortBy> {
  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByBackendId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backendId', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByBackendIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backendId', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByBrandName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brandName', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByBrandNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brandName', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> sortByForm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'form', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByFormDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'form', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByGenericName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genericName', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByGenericNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genericName', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> sortByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByInstructions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByInstructionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByPharmacy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pharmacy', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByPharmacyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pharmacy', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByPrescriber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriber', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByPrescriberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriber', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByPrivateLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privateLabel', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByPrivateLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privateLabel', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> sortByPurpose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purpose', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByPurposeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purpose', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> sortByRoute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'route', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByRouteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'route', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByStrengthUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthUnit', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByStrengthUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthUnit', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByStrengthValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthValue', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByStrengthValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthValue', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortBySyncError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortBySyncErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension MedicationLocalQuerySortThenBy
    on QueryBuilder<MedicationLocal, MedicationLocal, QSortThenBy> {
  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByBackendId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backendId', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByBackendIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backendId', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByBrandName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brandName', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByBrandNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brandName', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> thenByForm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'form', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByFormDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'form', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByGenericName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genericName', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByGenericNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genericName', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> thenByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByInstructions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByInstructionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByPharmacy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pharmacy', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByPharmacyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pharmacy', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByPrescriber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriber', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByPrescriberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriber', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByPrivateLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privateLabel', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByPrivateLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privateLabel', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> thenByPurpose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purpose', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByPurposeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purpose', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> thenByRoute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'route', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByRouteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'route', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByStrengthUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthUnit', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByStrengthUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthUnit', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByStrengthValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthValue', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByStrengthValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthValue', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenBySyncError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenBySyncErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QAfterSortBy>
  thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension MedicationLocalQueryWhereDistinct
    on QueryBuilder<MedicationLocal, MedicationLocal, QDistinct> {
  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByBackendId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backendId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByBrandName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brandName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct> distinctByClientId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct> distinctByForm({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'form', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByGenericName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genericName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct> distinctByImage({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByInstructions({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'instructions', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct> distinctByNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct> distinctByPharmacy({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pharmacy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByPrescriber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prescriber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByPrivateLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'privateLabel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct> distinctByPurpose({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'purpose', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct> distinctByRoute({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'route', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByStrengthUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strengthUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByStrengthValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strengthValue');
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctBySyncError({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncError', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus');
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<MedicationLocal, MedicationLocal, QDistinct>
  distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension MedicationLocalQueryProperty
    on QueryBuilder<MedicationLocal, MedicationLocal, QQueryProperty> {
  QueryBuilder<MedicationLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations> backendIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backendId');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations> brandNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brandName');
    });
  }

  QueryBuilder<MedicationLocal, String, QQueryOperations> clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientId');
    });
  }

  QueryBuilder<MedicationLocal, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<MedicationLocal, String, QQueryOperations>
  displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations> formProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'form');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations>
  genericNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genericName');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations>
  instructionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instructions');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations> pharmacyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pharmacy');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations>
  prescriberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prescriber');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations>
  privateLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'privateLabel');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations> purposeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'purpose');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations> routeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'route');
    });
  }

  QueryBuilder<MedicationLocal, MedicationStatus, QQueryOperations>
  statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations>
  strengthUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strengthUnit');
    });
  }

  QueryBuilder<MedicationLocal, double?, QQueryOperations>
  strengthValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strengthValue');
    });
  }

  QueryBuilder<MedicationLocal, String?, QQueryOperations> syncErrorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncError');
    });
  }

  QueryBuilder<MedicationLocal, MedicationSyncStatus, QQueryOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<MedicationLocal, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<MedicationLocal, int, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMedicationScheduleLocalCollection on Isar {
  IsarCollection<MedicationScheduleLocal> get medicationScheduleLocals =>
      this.collection();
}

const MedicationScheduleLocalSchema = CollectionSchema(
  name: r'MedicationScheduleLocal',
  id: 1184194527479423019,
  properties: {
    r'active': PropertySchema(id: 0, name: r'active', type: IsarType.bool),
    r'anchorLocal': PropertySchema(
      id: 1,
      name: r'anchorLocal',
      type: IsarType.string,
    ),
    r'annualDatesJson': PropertySchema(
      id: 2,
      name: r'annualDatesJson',
      type: IsarType.string,
    ),
    r'backendId': PropertySchema(
      id: 3,
      name: r'backendId',
      type: IsarType.string,
    ),
    r'clientId': PropertySchema(
      id: 4,
      name: r'clientId',
      type: IsarType.string,
    ),
    r'cycleOffDays': PropertySchema(
      id: 5,
      name: r'cycleOffDays',
      type: IsarType.long,
    ),
    r'cycleOnDays': PropertySchema(
      id: 6,
      name: r'cycleOnDays',
      type: IsarType.long,
    ),
    r'effectiveFrom': PropertySchema(
      id: 7,
      name: r'effectiveFrom',
      type: IsarType.dateTime,
    ),
    r'effectiveTo': PropertySchema(
      id: 8,
      name: r'effectiveTo',
      type: IsarType.dateTime,
    ),
    r'endDate': PropertySchema(id: 9, name: r'endDate', type: IsarType.string),
    r'frequency': PropertySchema(
      id: 10,
      name: r'frequency',
      type: IsarType.byte,
      enumMap: _MedicationScheduleLocalfrequencyEnumValueMap,
    ),
    r'interval': PropertySchema(id: 11, name: r'interval', type: IsarType.long),
    r'intervalUnit': PropertySchema(
      id: 12,
      name: r'intervalUnit',
      type: IsarType.string,
    ),
    r'invalidDatePolicy': PropertySchema(
      id: 13,
      name: r'invalidDatePolicy',
      type: IsarType.byte,
      enumMap: _MedicationScheduleLocalinvalidDatePolicyEnumValueMap,
    ),
    r'medicationClientId': PropertySchema(
      id: 14,
      name: r'medicationClientId',
      type: IsarType.string,
    ),
    r'monthDays': PropertySchema(
      id: 15,
      name: r'monthDays',
      type: IsarType.longList,
    ),
    r'revision': PropertySchema(id: 16, name: r'revision', type: IsarType.long),
    r'seriesId': PropertySchema(
      id: 17,
      name: r'seriesId',
      type: IsarType.string,
    ),
    r'slots': PropertySchema(
      id: 18,
      name: r'slots',
      type: IsarType.objectList,

      target: r'MedicationDoseSlotLocal',
    ),
    r'startDate': PropertySchema(
      id: 19,
      name: r'startDate',
      type: IsarType.string,
    ),
    r'timezone': PropertySchema(
      id: 20,
      name: r'timezone',
      type: IsarType.string,
    ),
    r'timezoneBehavior': PropertySchema(
      id: 21,
      name: r'timezoneBehavior',
      type: IsarType.byte,
      enumMap: _MedicationScheduleLocaltimezoneBehaviorEnumValueMap,
    ),
    r'weekdays': PropertySchema(
      id: 22,
      name: r'weekdays',
      type: IsarType.longList,
    ),
  },

  estimateSize: _medicationScheduleLocalEstimateSize,
  serialize: _medicationScheduleLocalSerialize,
  deserialize: _medicationScheduleLocalDeserialize,
  deserializeProp: _medicationScheduleLocalDeserializeProp,
  idName: r'id',
  indexes: {
    r'clientId': IndexSchema(
      id: 2639372232964765565,
      name: r'clientId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'clientId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'medicationClientId': IndexSchema(
      id: -3218765116682705184,
      name: r'medicationClientId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'medicationClientId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {r'MedicationDoseSlotLocal': MedicationDoseSlotLocalSchema},

  getId: _medicationScheduleLocalGetId,
  getLinks: _medicationScheduleLocalGetLinks,
  attach: _medicationScheduleLocalAttach,
  version: '3.3.2',
);

int _medicationScheduleLocalEstimateSize(
  MedicationScheduleLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.anchorLocal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.annualDatesJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.backendId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.clientId.length * 3;
  {
    final value = object.endDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.intervalUnit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.medicationClientId.length * 3;
  bytesCount += 3 + object.monthDays.length * 8;
  {
    final value = object.seriesId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.slots.length * 3;
  {
    final offsets = allOffsets[MedicationDoseSlotLocal]!;
    for (var i = 0; i < object.slots.length; i++) {
      final value = object.slots[i];
      bytesCount += MedicationDoseSlotLocalSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  bytesCount += 3 + object.startDate.length * 3;
  bytesCount += 3 + object.timezone.length * 3;
  bytesCount += 3 + object.weekdays.length * 8;
  return bytesCount;
}

void _medicationScheduleLocalSerialize(
  MedicationScheduleLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.active);
  writer.writeString(offsets[1], object.anchorLocal);
  writer.writeString(offsets[2], object.annualDatesJson);
  writer.writeString(offsets[3], object.backendId);
  writer.writeString(offsets[4], object.clientId);
  writer.writeLong(offsets[5], object.cycleOffDays);
  writer.writeLong(offsets[6], object.cycleOnDays);
  writer.writeDateTime(offsets[7], object.effectiveFrom);
  writer.writeDateTime(offsets[8], object.effectiveTo);
  writer.writeString(offsets[9], object.endDate);
  writer.writeByte(offsets[10], object.frequency.index);
  writer.writeLong(offsets[11], object.interval);
  writer.writeString(offsets[12], object.intervalUnit);
  writer.writeByte(offsets[13], object.invalidDatePolicy.index);
  writer.writeString(offsets[14], object.medicationClientId);
  writer.writeLongList(offsets[15], object.monthDays);
  writer.writeLong(offsets[16], object.revision);
  writer.writeString(offsets[17], object.seriesId);
  writer.writeObjectList<MedicationDoseSlotLocal>(
    offsets[18],
    allOffsets,
    MedicationDoseSlotLocalSchema.serialize,
    object.slots,
  );
  writer.writeString(offsets[19], object.startDate);
  writer.writeString(offsets[20], object.timezone);
  writer.writeByte(offsets[21], object.timezoneBehavior.index);
  writer.writeLongList(offsets[22], object.weekdays);
}

MedicationScheduleLocal _medicationScheduleLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicationScheduleLocal();
  object.active = reader.readBool(offsets[0]);
  object.anchorLocal = reader.readStringOrNull(offsets[1]);
  object.annualDatesJson = reader.readStringOrNull(offsets[2]);
  object.backendId = reader.readStringOrNull(offsets[3]);
  object.clientId = reader.readString(offsets[4]);
  object.cycleOffDays = reader.readLongOrNull(offsets[5]);
  object.cycleOnDays = reader.readLongOrNull(offsets[6]);
  object.effectiveFrom = reader.readDateTimeOrNull(offsets[7]);
  object.effectiveTo = reader.readDateTimeOrNull(offsets[8]);
  object.endDate = reader.readStringOrNull(offsets[9]);
  object.frequency =
      _MedicationScheduleLocalfrequencyValueEnumMap[reader.readByteOrNull(
        offsets[10],
      )] ??
      MedicationFrequency.daily;
  object.id = id;
  object.interval = reader.readLong(offsets[11]);
  object.intervalUnit = reader.readStringOrNull(offsets[12]);
  object.invalidDatePolicy =
      _MedicationScheduleLocalinvalidDatePolicyValueEnumMap[reader
          .readByteOrNull(offsets[13])] ??
      MedicationInvalidDatePolicy.lastValidDay;
  object.medicationClientId = reader.readString(offsets[14]);
  object.monthDays = reader.readLongList(offsets[15]) ?? [];
  object.revision = reader.readLong(offsets[16]);
  object.seriesId = reader.readStringOrNull(offsets[17]);
  object.slots =
      reader.readObjectList<MedicationDoseSlotLocal>(
        offsets[18],
        MedicationDoseSlotLocalSchema.deserialize,
        allOffsets,
        MedicationDoseSlotLocal(),
      ) ??
      [];
  object.startDate = reader.readString(offsets[19]);
  object.timezone = reader.readString(offsets[20]);
  object.timezoneBehavior =
      _MedicationScheduleLocaltimezoneBehaviorValueEnumMap[reader
          .readByteOrNull(offsets[21])] ??
      MedicationTimezoneBehavior.followDevice;
  object.weekdays = reader.readLongList(offsets[22]) ?? [];
  return object;
}

P _medicationScheduleLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (_MedicationScheduleLocalfrequencyValueEnumMap[reader
                  .readByteOrNull(offset)] ??
              MedicationFrequency.daily)
          as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (_MedicationScheduleLocalinvalidDatePolicyValueEnumMap[reader
                  .readByteOrNull(offset)] ??
              MedicationInvalidDatePolicy.lastValidDay)
          as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readLongList(offset) ?? []) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readObjectList<MedicationDoseSlotLocal>(
                offset,
                MedicationDoseSlotLocalSchema.deserialize,
                allOffsets,
                MedicationDoseSlotLocal(),
              ) ??
              [])
          as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (_MedicationScheduleLocaltimezoneBehaviorValueEnumMap[reader
                  .readByteOrNull(offset)] ??
              MedicationTimezoneBehavior.followDevice)
          as P;
    case 22:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MedicationScheduleLocalfrequencyEnumValueMap = {
  'daily': 0,
  'weekly': 1,
  'monthly': 2,
  'annual': 3,
  'interval': 4,
  'cyclical': 5,
  'prn': 6,
};
const _MedicationScheduleLocalfrequencyValueEnumMap = {
  0: MedicationFrequency.daily,
  1: MedicationFrequency.weekly,
  2: MedicationFrequency.monthly,
  3: MedicationFrequency.annual,
  4: MedicationFrequency.interval,
  5: MedicationFrequency.cyclical,
  6: MedicationFrequency.prn,
};
const _MedicationScheduleLocalinvalidDatePolicyEnumValueMap = {
  'lastValidDay': 0,
  'skip': 1,
  'february28': 2,
};
const _MedicationScheduleLocalinvalidDatePolicyValueEnumMap = {
  0: MedicationInvalidDatePolicy.lastValidDay,
  1: MedicationInvalidDatePolicy.skip,
  2: MedicationInvalidDatePolicy.february28,
};
const _MedicationScheduleLocaltimezoneBehaviorEnumValueMap = {
  'followDevice': 0,
  'fixedHome': 1,
};
const _MedicationScheduleLocaltimezoneBehaviorValueEnumMap = {
  0: MedicationTimezoneBehavior.followDevice,
  1: MedicationTimezoneBehavior.fixedHome,
};

Id _medicationScheduleLocalGetId(MedicationScheduleLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _medicationScheduleLocalGetLinks(
  MedicationScheduleLocal object,
) {
  return [];
}

void _medicationScheduleLocalAttach(
  IsarCollection<dynamic> col,
  Id id,
  MedicationScheduleLocal object,
) {
  object.id = id;
}

extension MedicationScheduleLocalByIndex
    on IsarCollection<MedicationScheduleLocal> {
  Future<MedicationScheduleLocal?> getByClientId(String clientId) {
    return getByIndex(r'clientId', [clientId]);
  }

  MedicationScheduleLocal? getByClientIdSync(String clientId) {
    return getByIndexSync(r'clientId', [clientId]);
  }

  Future<bool> deleteByClientId(String clientId) {
    return deleteByIndex(r'clientId', [clientId]);
  }

  bool deleteByClientIdSync(String clientId) {
    return deleteByIndexSync(r'clientId', [clientId]);
  }

  Future<List<MedicationScheduleLocal?>> getAllByClientId(
    List<String> clientIdValues,
  ) {
    final values = clientIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'clientId', values);
  }

  List<MedicationScheduleLocal?> getAllByClientIdSync(
    List<String> clientIdValues,
  ) {
    final values = clientIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'clientId', values);
  }

  Future<int> deleteAllByClientId(List<String> clientIdValues) {
    final values = clientIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'clientId', values);
  }

  int deleteAllByClientIdSync(List<String> clientIdValues) {
    final values = clientIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'clientId', values);
  }

  Future<Id> putByClientId(MedicationScheduleLocal object) {
    return putByIndex(r'clientId', object);
  }

  Id putByClientIdSync(
    MedicationScheduleLocal object, {
    bool saveLinks = true,
  }) {
    return putByIndexSync(r'clientId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByClientId(List<MedicationScheduleLocal> objects) {
    return putAllByIndex(r'clientId', objects);
  }

  List<Id> putAllByClientIdSync(
    List<MedicationScheduleLocal> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'clientId', objects, saveLinks: saveLinks);
  }
}

extension MedicationScheduleLocalQueryWhereSort
    on QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QWhere> {
  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MedicationScheduleLocalQueryWhere
    on
        QueryBuilder<
          MedicationScheduleLocal,
          MedicationScheduleLocal,
          QWhereClause
        > {
  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterWhereClause
  >
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterWhereClause
  >
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterWhereClause
  >
  clientIdEqualTo(String clientId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'clientId', value: [clientId]),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterWhereClause
  >
  clientIdNotEqualTo(String clientId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientId',
                lower: [],
                upper: [clientId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientId',
                lower: [clientId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientId',
                lower: [clientId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientId',
                lower: [],
                upper: [clientId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterWhereClause
  >
  medicationClientIdEqualTo(String medicationClientId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'medicationClientId',
          value: [medicationClientId],
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterWhereClause
  >
  medicationClientIdNotEqualTo(String medicationClientId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [],
                upper: [medicationClientId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [medicationClientId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [medicationClientId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [],
                upper: [medicationClientId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension MedicationScheduleLocalQueryFilter
    on
        QueryBuilder<
          MedicationScheduleLocal,
          MedicationScheduleLocal,
          QFilterCondition
        > {
  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  activeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'active', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'anchorLocal'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'anchorLocal'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'anchorLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'anchorLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'anchorLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'anchorLocal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'anchorLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'anchorLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'anchorLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'anchorLocal',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'anchorLocal', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  anchorLocalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'anchorLocal', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'annualDatesJson'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'annualDatesJson'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'annualDatesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'annualDatesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'annualDatesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'annualDatesJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'annualDatesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'annualDatesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'annualDatesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'annualDatesJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'annualDatesJson', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  annualDatesJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'annualDatesJson', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'backendId'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'backendId'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'backendId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'backendId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'backendId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'backendId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  backendIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'backendId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  clientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  clientIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  clientIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  clientIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clientId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  clientIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  clientIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  clientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  clientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'clientId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  clientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'clientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  clientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'clientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOffDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cycleOffDays'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOffDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cycleOffDays'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOffDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cycleOffDays', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOffDaysGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cycleOffDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOffDaysLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cycleOffDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOffDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cycleOffDays',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOnDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cycleOnDays'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOnDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cycleOnDays'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOnDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cycleOnDays', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOnDaysGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cycleOnDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOnDaysLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cycleOnDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  cycleOnDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cycleOnDays',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveFromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'effectiveFrom'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveFromIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'effectiveFrom'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveFromEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'effectiveFrom', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveFromGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'effectiveFrom',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveFromLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'effectiveFrom',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveFromBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'effectiveFrom',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveToIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'effectiveTo'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveToIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'effectiveTo'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveToEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'effectiveTo', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveToGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'effectiveTo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveToLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'effectiveTo',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  effectiveToBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'effectiveTo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'endDate'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'endDate'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'endDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'endDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'endDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'endDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'endDate',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endDate', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  endDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'endDate', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  frequencyEqualTo(MedicationFrequency value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'frequency', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  frequencyGreaterThan(MedicationFrequency value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'frequency',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  frequencyLessThan(MedicationFrequency value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'frequency',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  frequencyBetween(
    MedicationFrequency lower,
    MedicationFrequency upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'frequency',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'interval', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'interval',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'interval',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'interval',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'intervalUnit'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'intervalUnit'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'intervalUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'intervalUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'intervalUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'intervalUnit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'intervalUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'intervalUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'intervalUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'intervalUnit',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'intervalUnit', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  intervalUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'intervalUnit', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  invalidDatePolicyEqualTo(MedicationInvalidDatePolicy value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'invalidDatePolicy', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  invalidDatePolicyGreaterThan(
    MedicationInvalidDatePolicy value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'invalidDatePolicy',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  invalidDatePolicyLessThan(
    MedicationInvalidDatePolicy value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'invalidDatePolicy',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  invalidDatePolicyBetween(
    MedicationInvalidDatePolicy lower,
    MedicationInvalidDatePolicy upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'invalidDatePolicy',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  medicationClientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  medicationClientIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  medicationClientIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  medicationClientIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'medicationClientId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  medicationClientIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  medicationClientIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  medicationClientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  medicationClientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'medicationClientId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  medicationClientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'medicationClientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  medicationClientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'medicationClientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  monthDaysElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'monthDays', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  monthDaysElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'monthDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  monthDaysElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'monthDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  monthDaysElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'monthDays',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  monthDaysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'monthDays', length, true, length, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  monthDaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'monthDays', 0, true, 0, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  monthDaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'monthDays', 0, false, 999999, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  monthDaysLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'monthDays', 0, true, length, include);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  monthDaysLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'monthDays', length, include, 999999, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  monthDaysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'monthDays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  revisionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'revision', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  revisionGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'revision',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  revisionLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'revision',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  revisionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'revision',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'seriesId'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'seriesId'),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'seriesId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'seriesId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'seriesId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'seriesId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'seriesId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'seriesId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'seriesId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'seriesId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'seriesId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  seriesIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'seriesId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  slotsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'slots', length, true, length, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  slotsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'slots', 0, true, 0, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  slotsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'slots', 0, false, 999999, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  slotsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'slots', 0, true, length, include);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  slotsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'slots', length, include, 999999, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  slotsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'slots',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  startDateEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'startDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  startDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  startDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  startDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  startDateStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'startDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  startDateEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'startDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  startDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'startDate',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  startDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'startDate',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  startDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startDate', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  startDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'startDate', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timezone',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timezone',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timezone', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'timezone', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneBehaviorEqualTo(MedicationTimezoneBehavior value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timezoneBehavior', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneBehaviorGreaterThan(
    MedicationTimezoneBehavior value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timezoneBehavior',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneBehaviorLessThan(
    MedicationTimezoneBehavior value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timezoneBehavior',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  timezoneBehaviorBetween(
    MedicationTimezoneBehavior lower,
    MedicationTimezoneBehavior upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timezoneBehavior',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  weekdaysElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'weekdays', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  weekdaysElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weekdays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  weekdaysElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weekdays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  weekdaysElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weekdays',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  weekdaysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'weekdays', length, true, length, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  weekdaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'weekdays', 0, true, 0, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  weekdaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'weekdays', 0, false, 999999, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  weekdaysLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'weekdays', 0, true, length, include);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  weekdaysLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'weekdays', length, include, 999999, true);
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  weekdaysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekdays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension MedicationScheduleLocalQueryObject
    on
        QueryBuilder<
          MedicationScheduleLocal,
          MedicationScheduleLocal,
          QFilterCondition
        > {
  QueryBuilder<
    MedicationScheduleLocal,
    MedicationScheduleLocal,
    QAfterFilterCondition
  >
  slotsElement(FilterQuery<MedicationDoseSlotLocal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'slots');
    });
  }
}

extension MedicationScheduleLocalQueryLinks
    on
        QueryBuilder<
          MedicationScheduleLocal,
          MedicationScheduleLocal,
          QFilterCondition
        > {}

extension MedicationScheduleLocalQuerySortBy
    on QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QSortBy> {
  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByAnchorLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorLocal', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByAnchorLocalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorLocal', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByAnnualDatesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualDatesJson', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByAnnualDatesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualDatesJson', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByBackendId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backendId', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByBackendIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backendId', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByCycleOffDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOffDays', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByCycleOffDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOffDays', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByCycleOnDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOnDays', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByCycleOnDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOnDays', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByEffectiveFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveFrom', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByEffectiveFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveFrom', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByEffectiveTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveTo', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByEffectiveToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveTo', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByIntervalUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByIntervalUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByInvalidDatePolicy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invalidDatePolicy', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByInvalidDatePolicyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invalidDatePolicy', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByMedicationClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByMedicationClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByRevision() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revision', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByRevisionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revision', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortBySeriesId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesId', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortBySeriesIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesId', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByTimezone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezone', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByTimezoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezone', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByTimezoneBehavior() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezoneBehavior', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  sortByTimezoneBehaviorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezoneBehavior', Sort.desc);
    });
  }
}

extension MedicationScheduleLocalQuerySortThenBy
    on
        QueryBuilder<
          MedicationScheduleLocal,
          MedicationScheduleLocal,
          QSortThenBy
        > {
  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByAnchorLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorLocal', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByAnchorLocalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorLocal', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByAnnualDatesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualDatesJson', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByAnnualDatesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualDatesJson', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByBackendId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backendId', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByBackendIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backendId', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByCycleOffDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOffDays', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByCycleOffDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOffDays', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByCycleOnDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOnDays', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByCycleOnDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOnDays', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByEffectiveFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveFrom', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByEffectiveFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveFrom', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByEffectiveTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveTo', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByEffectiveToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveTo', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByIntervalUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByIntervalUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByInvalidDatePolicy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invalidDatePolicy', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByInvalidDatePolicyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invalidDatePolicy', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByMedicationClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByMedicationClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByRevision() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revision', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByRevisionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revision', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenBySeriesId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesId', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenBySeriesIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesId', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByTimezone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezone', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByTimezoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezone', Sort.desc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByTimezoneBehavior() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezoneBehavior', Sort.asc);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QAfterSortBy>
  thenByTimezoneBehaviorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezoneBehavior', Sort.desc);
    });
  }
}

extension MedicationScheduleLocalQueryWhereDistinct
    on
        QueryBuilder<
          MedicationScheduleLocal,
          MedicationScheduleLocal,
          QDistinct
        > {
  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'active');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByAnchorLocal({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'anchorLocal', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByAnnualDatesJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'annualDatesJson',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByBackendId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backendId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByCycleOffDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cycleOffDays');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByCycleOnDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cycleOnDays');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByEffectiveFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'effectiveFrom');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByEffectiveTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'effectiveTo');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByEndDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frequency');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interval');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByIntervalUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intervalUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByInvalidDatePolicy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invalidDatePolicy');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByMedicationClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'medicationClientId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByMonthDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monthDays');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByRevision() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'revision');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctBySeriesId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seriesId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByStartDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByTimezone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timezone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByTimezoneBehavior() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timezoneBehavior');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationScheduleLocal, QDistinct>
  distinctByWeekdays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekdays');
    });
  }
}

extension MedicationScheduleLocalQueryProperty
    on
        QueryBuilder<
          MedicationScheduleLocal,
          MedicationScheduleLocal,
          QQueryProperty
        > {
  QueryBuilder<MedicationScheduleLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MedicationScheduleLocal, bool, QQueryOperations>
  activeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'active');
    });
  }

  QueryBuilder<MedicationScheduleLocal, String?, QQueryOperations>
  anchorLocalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'anchorLocal');
    });
  }

  QueryBuilder<MedicationScheduleLocal, String?, QQueryOperations>
  annualDatesJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'annualDatesJson');
    });
  }

  QueryBuilder<MedicationScheduleLocal, String?, QQueryOperations>
  backendIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backendId');
    });
  }

  QueryBuilder<MedicationScheduleLocal, String, QQueryOperations>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientId');
    });
  }

  QueryBuilder<MedicationScheduleLocal, int?, QQueryOperations>
  cycleOffDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cycleOffDays');
    });
  }

  QueryBuilder<MedicationScheduleLocal, int?, QQueryOperations>
  cycleOnDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cycleOnDays');
    });
  }

  QueryBuilder<MedicationScheduleLocal, DateTime?, QQueryOperations>
  effectiveFromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'effectiveFrom');
    });
  }

  QueryBuilder<MedicationScheduleLocal, DateTime?, QQueryOperations>
  effectiveToProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'effectiveTo');
    });
  }

  QueryBuilder<MedicationScheduleLocal, String?, QQueryOperations>
  endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<MedicationScheduleLocal, MedicationFrequency, QQueryOperations>
  frequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequency');
    });
  }

  QueryBuilder<MedicationScheduleLocal, int, QQueryOperations>
  intervalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interval');
    });
  }

  QueryBuilder<MedicationScheduleLocal, String?, QQueryOperations>
  intervalUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intervalUnit');
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationInvalidDatePolicy,
    QQueryOperations
  >
  invalidDatePolicyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invalidDatePolicy');
    });
  }

  QueryBuilder<MedicationScheduleLocal, String, QQueryOperations>
  medicationClientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicationClientId');
    });
  }

  QueryBuilder<MedicationScheduleLocal, List<int>, QQueryOperations>
  monthDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monthDays');
    });
  }

  QueryBuilder<MedicationScheduleLocal, int, QQueryOperations>
  revisionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'revision');
    });
  }

  QueryBuilder<MedicationScheduleLocal, String?, QQueryOperations>
  seriesIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seriesId');
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    List<MedicationDoseSlotLocal>,
    QQueryOperations
  >
  slotsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slots');
    });
  }

  QueryBuilder<MedicationScheduleLocal, String, QQueryOperations>
  startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<MedicationScheduleLocal, String, QQueryOperations>
  timezoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timezone');
    });
  }

  QueryBuilder<
    MedicationScheduleLocal,
    MedicationTimezoneBehavior,
    QQueryOperations
  >
  timezoneBehaviorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timezoneBehavior');
    });
  }

  QueryBuilder<MedicationScheduleLocal, List<int>, QQueryOperations>
  weekdaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekdays');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMedicationDoseRecordLocalCollection on Isar {
  IsarCollection<MedicationDoseRecordLocal> get medicationDoseRecordLocals =>
      this.collection();
}

const MedicationDoseRecordLocalSchema = CollectionSchema(
  name: r'MedicationDoseRecordLocal',
  id: -9120340207081421527,
  properties: {
    r'corrected': PropertySchema(
      id: 0,
      name: r'corrected',
      type: IsarType.bool,
    ),
    r'doseQuantity': PropertySchema(
      id: 1,
      name: r'doseQuantity',
      type: IsarType.double,
    ),
    r'doseUnit': PropertySchema(
      id: 2,
      name: r'doseUnit',
      type: IsarType.string,
    ),
    r'instructions': PropertySchema(
      id: 3,
      name: r'instructions',
      type: IsarType.string,
    ),
    r'medicationClientId': PropertySchema(
      id: 4,
      name: r'medicationClientId',
      type: IsarType.string,
    ),
    r'note': PropertySchema(id: 5, name: r'note', type: IsarType.string),
    r'occurrenceKey': PropertySchema(
      id: 6,
      name: r'occurrenceKey',
      type: IsarType.string,
    ),
    r'outcome': PropertySchema(
      id: 7,
      name: r'outcome',
      type: IsarType.byte,
      enumMap: _MedicationDoseRecordLocaloutcomeEnumValueMap,
    ),
    r'pendingSync': PropertySchema(
      id: 8,
      name: r'pendingSync',
      type: IsarType.bool,
    ),
    r'recordedAt': PropertySchema(
      id: 9,
      name: r'recordedAt',
      type: IsarType.dateTime,
    ),
    r'scheduleClientId': PropertySchema(
      id: 10,
      name: r'scheduleClientId',
      type: IsarType.string,
    ),
    r'scheduledAt': PropertySchema(
      id: 11,
      name: r'scheduledAt',
      type: IsarType.dateTime,
    ),
    r'scheduledLocal': PropertySchema(
      id: 12,
      name: r'scheduledLocal',
      type: IsarType.string,
    ),
    r'snoozedUntil': PropertySchema(
      id: 13,
      name: r'snoozedUntil',
      type: IsarType.dateTime,
    ),
    r'supplyDeductedQuantity': PropertySchema(
      id: 14,
      name: r'supplyDeductedQuantity',
      type: IsarType.double,
    ),
    r'takenAt': PropertySchema(
      id: 15,
      name: r'takenAt',
      type: IsarType.dateTime,
    ),
    r'timezone': PropertySchema(
      id: 16,
      name: r'timezone',
      type: IsarType.string,
    ),
    r'version': PropertySchema(id: 17, name: r'version', type: IsarType.long),
  },

  estimateSize: _medicationDoseRecordLocalEstimateSize,
  serialize: _medicationDoseRecordLocalSerialize,
  deserialize: _medicationDoseRecordLocalDeserialize,
  deserializeProp: _medicationDoseRecordLocalDeserializeProp,
  idName: r'id',
  indexes: {
    r'occurrenceKey': IndexSchema(
      id: 1905454298359628696,
      name: r'occurrenceKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'occurrenceKey',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'medicationClientId': IndexSchema(
      id: -3218765116682705184,
      name: r'medicationClientId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'medicationClientId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _medicationDoseRecordLocalGetId,
  getLinks: _medicationDoseRecordLocalGetLinks,
  attach: _medicationDoseRecordLocalAttach,
  version: '3.3.2',
);

int _medicationDoseRecordLocalEstimateSize(
  MedicationDoseRecordLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.doseUnit.length * 3;
  {
    final value = object.instructions;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.medicationClientId.length * 3;
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.occurrenceKey.length * 3;
  {
    final value = object.scheduleClientId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.scheduledLocal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.timezone.length * 3;
  return bytesCount;
}

void _medicationDoseRecordLocalSerialize(
  MedicationDoseRecordLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.corrected);
  writer.writeDouble(offsets[1], object.doseQuantity);
  writer.writeString(offsets[2], object.doseUnit);
  writer.writeString(offsets[3], object.instructions);
  writer.writeString(offsets[4], object.medicationClientId);
  writer.writeString(offsets[5], object.note);
  writer.writeString(offsets[6], object.occurrenceKey);
  writer.writeByte(offsets[7], object.outcome.index);
  writer.writeBool(offsets[8], object.pendingSync);
  writer.writeDateTime(offsets[9], object.recordedAt);
  writer.writeString(offsets[10], object.scheduleClientId);
  writer.writeDateTime(offsets[11], object.scheduledAt);
  writer.writeString(offsets[12], object.scheduledLocal);
  writer.writeDateTime(offsets[13], object.snoozedUntil);
  writer.writeDouble(offsets[14], object.supplyDeductedQuantity);
  writer.writeDateTime(offsets[15], object.takenAt);
  writer.writeString(offsets[16], object.timezone);
  writer.writeLong(offsets[17], object.version);
}

MedicationDoseRecordLocal _medicationDoseRecordLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicationDoseRecordLocal();
  object.corrected = reader.readBool(offsets[0]);
  object.doseQuantity = reader.readDouble(offsets[1]);
  object.doseUnit = reader.readString(offsets[2]);
  object.id = id;
  object.instructions = reader.readStringOrNull(offsets[3]);
  object.medicationClientId = reader.readString(offsets[4]);
  object.note = reader.readStringOrNull(offsets[5]);
  object.occurrenceKey = reader.readString(offsets[6]);
  object.outcome =
      _MedicationDoseRecordLocaloutcomeValueEnumMap[reader.readByteOrNull(
        offsets[7],
      )] ??
      MedicationDoseOutcome.upcoming;
  object.pendingSync = reader.readBool(offsets[8]);
  object.recordedAt = reader.readDateTime(offsets[9]);
  object.scheduleClientId = reader.readStringOrNull(offsets[10]);
  object.scheduledAt = reader.readDateTimeOrNull(offsets[11]);
  object.scheduledLocal = reader.readStringOrNull(offsets[12]);
  object.snoozedUntil = reader.readDateTimeOrNull(offsets[13]);
  object.supplyDeductedQuantity = reader.readDouble(offsets[14]);
  object.takenAt = reader.readDateTimeOrNull(offsets[15]);
  object.timezone = reader.readString(offsets[16]);
  object.version = reader.readLong(offsets[17]);
  return object;
}

P _medicationDoseRecordLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (_MedicationDoseRecordLocaloutcomeValueEnumMap[reader
                  .readByteOrNull(offset)] ??
              MedicationDoseOutcome.upcoming)
          as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MedicationDoseRecordLocaloutcomeEnumValueMap = {
  'upcoming': 0,
  'due': 1,
  'snoozed': 2,
  'taken': 3,
  'skipped': 4,
  'missed': 5,
};
const _MedicationDoseRecordLocaloutcomeValueEnumMap = {
  0: MedicationDoseOutcome.upcoming,
  1: MedicationDoseOutcome.due,
  2: MedicationDoseOutcome.snoozed,
  3: MedicationDoseOutcome.taken,
  4: MedicationDoseOutcome.skipped,
  5: MedicationDoseOutcome.missed,
};

Id _medicationDoseRecordLocalGetId(MedicationDoseRecordLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _medicationDoseRecordLocalGetLinks(
  MedicationDoseRecordLocal object,
) {
  return [];
}

void _medicationDoseRecordLocalAttach(
  IsarCollection<dynamic> col,
  Id id,
  MedicationDoseRecordLocal object,
) {
  object.id = id;
}

extension MedicationDoseRecordLocalByIndex
    on IsarCollection<MedicationDoseRecordLocal> {
  Future<MedicationDoseRecordLocal?> getByOccurrenceKey(String occurrenceKey) {
    return getByIndex(r'occurrenceKey', [occurrenceKey]);
  }

  MedicationDoseRecordLocal? getByOccurrenceKeySync(String occurrenceKey) {
    return getByIndexSync(r'occurrenceKey', [occurrenceKey]);
  }

  Future<bool> deleteByOccurrenceKey(String occurrenceKey) {
    return deleteByIndex(r'occurrenceKey', [occurrenceKey]);
  }

  bool deleteByOccurrenceKeySync(String occurrenceKey) {
    return deleteByIndexSync(r'occurrenceKey', [occurrenceKey]);
  }

  Future<List<MedicationDoseRecordLocal?>> getAllByOccurrenceKey(
    List<String> occurrenceKeyValues,
  ) {
    final values = occurrenceKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'occurrenceKey', values);
  }

  List<MedicationDoseRecordLocal?> getAllByOccurrenceKeySync(
    List<String> occurrenceKeyValues,
  ) {
    final values = occurrenceKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'occurrenceKey', values);
  }

  Future<int> deleteAllByOccurrenceKey(List<String> occurrenceKeyValues) {
    final values = occurrenceKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'occurrenceKey', values);
  }

  int deleteAllByOccurrenceKeySync(List<String> occurrenceKeyValues) {
    final values = occurrenceKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'occurrenceKey', values);
  }

  Future<Id> putByOccurrenceKey(MedicationDoseRecordLocal object) {
    return putByIndex(r'occurrenceKey', object);
  }

  Id putByOccurrenceKeySync(
    MedicationDoseRecordLocal object, {
    bool saveLinks = true,
  }) {
    return putByIndexSync(r'occurrenceKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByOccurrenceKey(
    List<MedicationDoseRecordLocal> objects,
  ) {
    return putAllByIndex(r'occurrenceKey', objects);
  }

  List<Id> putAllByOccurrenceKeySync(
    List<MedicationDoseRecordLocal> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'occurrenceKey', objects, saveLinks: saveLinks);
  }
}

extension MedicationDoseRecordLocalQueryWhereSort
    on
        QueryBuilder<
          MedicationDoseRecordLocal,
          MedicationDoseRecordLocal,
          QWhere
        > {
  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterWhere
  >
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MedicationDoseRecordLocalQueryWhere
    on
        QueryBuilder<
          MedicationDoseRecordLocal,
          MedicationDoseRecordLocal,
          QWhereClause
        > {
  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterWhereClause
  >
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterWhereClause
  >
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterWhereClause
  >
  occurrenceKeyEqualTo(String occurrenceKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'occurrenceKey',
          value: [occurrenceKey],
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterWhereClause
  >
  occurrenceKeyNotEqualTo(String occurrenceKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceKey',
                lower: [],
                upper: [occurrenceKey],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceKey',
                lower: [occurrenceKey],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceKey',
                lower: [occurrenceKey],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceKey',
                lower: [],
                upper: [occurrenceKey],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterWhereClause
  >
  medicationClientIdEqualTo(String medicationClientId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'medicationClientId',
          value: [medicationClientId],
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterWhereClause
  >
  medicationClientIdNotEqualTo(String medicationClientId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [],
                upper: [medicationClientId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [medicationClientId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [medicationClientId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [],
                upper: [medicationClientId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension MedicationDoseRecordLocalQueryFilter
    on
        QueryBuilder<
          MedicationDoseRecordLocal,
          MedicationDoseRecordLocal,
          QFilterCondition
        > {
  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  correctedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'corrected', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseQuantityEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'doseQuantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseQuantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'doseQuantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseQuantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'doseQuantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseQuantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'doseQuantity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseUnitEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseUnitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseUnitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseUnitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'doseUnit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseUnitStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseUnitEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'doseUnit',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'doseUnit', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  doseUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'doseUnit', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'instructions'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'instructions'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'instructions',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'instructions',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'instructions', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  instructionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'instructions', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  medicationClientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  medicationClientIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  medicationClientIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  medicationClientIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'medicationClientId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  medicationClientIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  medicationClientIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  medicationClientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  medicationClientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'medicationClientId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  medicationClientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'medicationClientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  medicationClientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'medicationClientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'note'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'note'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'note',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'note',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'note', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'note', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  occurrenceKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  occurrenceKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  occurrenceKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  occurrenceKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'occurrenceKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  occurrenceKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  occurrenceKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  occurrenceKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  occurrenceKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'occurrenceKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  occurrenceKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'occurrenceKey', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  occurrenceKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'occurrenceKey', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  outcomeEqualTo(MedicationDoseOutcome value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'outcome', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  outcomeGreaterThan(MedicationDoseOutcome value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'outcome',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  outcomeLessThan(MedicationDoseOutcome value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'outcome',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  outcomeBetween(
    MedicationDoseOutcome lower,
    MedicationDoseOutcome upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'outcome',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  pendingSyncEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pendingSync', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  recordedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recordedAt', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  recordedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recordedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  recordedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recordedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  recordedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recordedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'scheduleClientId'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'scheduleClientId'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'scheduleClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scheduleClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scheduleClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scheduleClientId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'scheduleClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'scheduleClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'scheduleClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'scheduleClientId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scheduleClientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduleClientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'scheduleClientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'scheduledAt'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'scheduledAt'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scheduledAt', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scheduledAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scheduledAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scheduledAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'scheduledLocal'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'scheduledLocal'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'scheduledLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scheduledLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scheduledLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scheduledLocal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'scheduledLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'scheduledLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'scheduledLocal',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'scheduledLocal',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scheduledLocal', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  scheduledLocalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'scheduledLocal', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  snoozedUntilIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'snoozedUntil'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  snoozedUntilIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'snoozedUntil'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  snoozedUntilEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'snoozedUntil', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  snoozedUntilGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'snoozedUntil',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  snoozedUntilLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'snoozedUntil',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  snoozedUntilBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'snoozedUntil',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  supplyDeductedQuantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'supplyDeductedQuantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  supplyDeductedQuantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'supplyDeductedQuantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  supplyDeductedQuantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'supplyDeductedQuantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  supplyDeductedQuantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'supplyDeductedQuantity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  takenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'takenAt'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  takenAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'takenAt'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  takenAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'takenAt', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  takenAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'takenAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  takenAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'takenAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  takenAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'takenAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  timezoneEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  timezoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  timezoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  timezoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timezone',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  timezoneStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  timezoneEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  timezoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timezone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  timezoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timezone',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  timezoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timezone', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  timezoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'timezone', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'version', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  versionGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'version',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  versionLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'version',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterFilterCondition
  >
  versionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'version',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension MedicationDoseRecordLocalQueryObject
    on
        QueryBuilder<
          MedicationDoseRecordLocal,
          MedicationDoseRecordLocal,
          QFilterCondition
        > {}

extension MedicationDoseRecordLocalQueryLinks
    on
        QueryBuilder<
          MedicationDoseRecordLocal,
          MedicationDoseRecordLocal,
          QFilterCondition
        > {}

extension MedicationDoseRecordLocalQuerySortBy
    on
        QueryBuilder<
          MedicationDoseRecordLocal,
          MedicationDoseRecordLocal,
          QSortBy
        > {
  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByCorrected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'corrected', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByCorrectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'corrected', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByDoseQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseQuantity', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByDoseQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseQuantity', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByDoseUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseUnit', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByDoseUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseUnit', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByInstructions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByInstructionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByMedicationClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByMedicationClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByOccurrenceKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceKey', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByOccurrenceKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceKey', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByOutcome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outcome', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByOutcomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outcome', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByPendingSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByScheduleClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleClientId', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByScheduleClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleClientId', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByScheduledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByScheduledLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledLocal', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByScheduledLocalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledLocal', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortBySnoozedUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozedUntil', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortBySnoozedUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozedUntil', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortBySupplyDeductedQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplyDeductedQuantity', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortBySupplyDeductedQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplyDeductedQuantity', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByTakenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByTimezone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezone', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByTimezoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezone', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension MedicationDoseRecordLocalQuerySortThenBy
    on
        QueryBuilder<
          MedicationDoseRecordLocal,
          MedicationDoseRecordLocal,
          QSortThenBy
        > {
  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByCorrected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'corrected', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByCorrectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'corrected', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByDoseQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseQuantity', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByDoseQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseQuantity', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByDoseUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseUnit', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByDoseUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doseUnit', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByInstructions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByInstructionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByMedicationClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByMedicationClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByOccurrenceKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceKey', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByOccurrenceKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceKey', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByOutcome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outcome', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByOutcomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outcome', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByPendingSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByScheduleClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleClientId', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByScheduleClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleClientId', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByScheduledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByScheduledLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledLocal', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByScheduledLocalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledLocal', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenBySnoozedUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozedUntil', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenBySnoozedUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snoozedUntil', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenBySupplyDeductedQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplyDeductedQuantity', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenBySupplyDeductedQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplyDeductedQuantity', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByTakenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByTimezone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezone', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByTimezoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timezone', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseRecordLocal,
    QAfterSortBy
  >
  thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension MedicationDoseRecordLocalQueryWhereDistinct
    on
        QueryBuilder<
          MedicationDoseRecordLocal,
          MedicationDoseRecordLocal,
          QDistinct
        > {
  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByCorrected() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'corrected');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByDoseQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doseQuantity');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByDoseUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doseUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByInstructions({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'instructions', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByMedicationClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'medicationClientId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByNote({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByOccurrenceKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'occurrenceKey',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByOutcome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'outcome');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingSync');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordedAt');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByScheduleClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'scheduleClientId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledAt');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByScheduledLocal({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'scheduledLocal',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctBySnoozedUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'snoozedUntil');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctBySupplyDeductedQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supplyDeductedQuantity');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'takenAt');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByTimezone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timezone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, MedicationDoseRecordLocal, QDistinct>
  distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension MedicationDoseRecordLocalQueryProperty
    on
        QueryBuilder<
          MedicationDoseRecordLocal,
          MedicationDoseRecordLocal,
          QQueryProperty
        > {
  QueryBuilder<MedicationDoseRecordLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, bool, QQueryOperations>
  correctedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'corrected');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, double, QQueryOperations>
  doseQuantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doseQuantity');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, String, QQueryOperations>
  doseUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doseUnit');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, String?, QQueryOperations>
  instructionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instructions');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, String, QQueryOperations>
  medicationClientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicationClientId');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, String?, QQueryOperations>
  noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, String, QQueryOperations>
  occurrenceKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'occurrenceKey');
    });
  }

  QueryBuilder<
    MedicationDoseRecordLocal,
    MedicationDoseOutcome,
    QQueryOperations
  >
  outcomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'outcome');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, bool, QQueryOperations>
  pendingSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingSync');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, DateTime, QQueryOperations>
  recordedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordedAt');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, String?, QQueryOperations>
  scheduleClientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleClientId');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, DateTime?, QQueryOperations>
  scheduledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledAt');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, String?, QQueryOperations>
  scheduledLocalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledLocal');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, DateTime?, QQueryOperations>
  snoozedUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'snoozedUntil');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, double, QQueryOperations>
  supplyDeductedQuantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supplyDeductedQuantity');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, DateTime?, QQueryOperations>
  takenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'takenAt');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, String, QQueryOperations>
  timezoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timezone');
    });
  }

  QueryBuilder<MedicationDoseRecordLocal, int, QQueryOperations>
  versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMedicationDoseActionLocalCollection on Isar {
  IsarCollection<MedicationDoseActionLocal> get medicationDoseActionLocals =>
      this.collection();
}

const MedicationDoseActionLocalSchema = CollectionSchema(
  name: r'MedicationDoseActionLocal',
  id: 1482554717773967707,
  properties: {
    r'actedAt': PropertySchema(
      id: 0,
      name: r'actedAt',
      type: IsarType.dateTime,
    ),
    r'action': PropertySchema(id: 1, name: r'action', type: IsarType.string),
    r'clientOperationId': PropertySchema(
      id: 2,
      name: r'clientOperationId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'note': PropertySchema(id: 4, name: r'note', type: IsarType.string),
    r'occurrenceKey': PropertySchema(
      id: 5,
      name: r'occurrenceKey',
      type: IsarType.string,
    ),
  },

  estimateSize: _medicationDoseActionLocalEstimateSize,
  serialize: _medicationDoseActionLocalSerialize,
  deserialize: _medicationDoseActionLocalDeserialize,
  deserializeProp: _medicationDoseActionLocalDeserializeProp,
  idName: r'id',
  indexes: {
    r'clientOperationId': IndexSchema(
      id: -3703325757571940354,
      name: r'clientOperationId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'clientOperationId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'occurrenceKey': IndexSchema(
      id: 1905454298359628696,
      name: r'occurrenceKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'occurrenceKey',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _medicationDoseActionLocalGetId,
  getLinks: _medicationDoseActionLocalGetLinks,
  attach: _medicationDoseActionLocalAttach,
  version: '3.3.2',
);

int _medicationDoseActionLocalEstimateSize(
  MedicationDoseActionLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.action.length * 3;
  bytesCount += 3 + object.clientOperationId.length * 3;
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.occurrenceKey.length * 3;
  return bytesCount;
}

void _medicationDoseActionLocalSerialize(
  MedicationDoseActionLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.actedAt);
  writer.writeString(offsets[1], object.action);
  writer.writeString(offsets[2], object.clientOperationId);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.note);
  writer.writeString(offsets[5], object.occurrenceKey);
}

MedicationDoseActionLocal _medicationDoseActionLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicationDoseActionLocal();
  object.actedAt = reader.readDateTime(offsets[0]);
  object.action = reader.readString(offsets[1]);
  object.clientOperationId = reader.readString(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.id = id;
  object.note = reader.readStringOrNull(offsets[4]);
  object.occurrenceKey = reader.readString(offsets[5]);
  return object;
}

P _medicationDoseActionLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _medicationDoseActionLocalGetId(MedicationDoseActionLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _medicationDoseActionLocalGetLinks(
  MedicationDoseActionLocal object,
) {
  return [];
}

void _medicationDoseActionLocalAttach(
  IsarCollection<dynamic> col,
  Id id,
  MedicationDoseActionLocal object,
) {
  object.id = id;
}

extension MedicationDoseActionLocalByIndex
    on IsarCollection<MedicationDoseActionLocal> {
  Future<MedicationDoseActionLocal?> getByClientOperationId(
    String clientOperationId,
  ) {
    return getByIndex(r'clientOperationId', [clientOperationId]);
  }

  MedicationDoseActionLocal? getByClientOperationIdSync(
    String clientOperationId,
  ) {
    return getByIndexSync(r'clientOperationId', [clientOperationId]);
  }

  Future<bool> deleteByClientOperationId(String clientOperationId) {
    return deleteByIndex(r'clientOperationId', [clientOperationId]);
  }

  bool deleteByClientOperationIdSync(String clientOperationId) {
    return deleteByIndexSync(r'clientOperationId', [clientOperationId]);
  }

  Future<List<MedicationDoseActionLocal?>> getAllByClientOperationId(
    List<String> clientOperationIdValues,
  ) {
    final values = clientOperationIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'clientOperationId', values);
  }

  List<MedicationDoseActionLocal?> getAllByClientOperationIdSync(
    List<String> clientOperationIdValues,
  ) {
    final values = clientOperationIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'clientOperationId', values);
  }

  Future<int> deleteAllByClientOperationId(
    List<String> clientOperationIdValues,
  ) {
    final values = clientOperationIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'clientOperationId', values);
  }

  int deleteAllByClientOperationIdSync(List<String> clientOperationIdValues) {
    final values = clientOperationIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'clientOperationId', values);
  }

  Future<Id> putByClientOperationId(MedicationDoseActionLocal object) {
    return putByIndex(r'clientOperationId', object);
  }

  Id putByClientOperationIdSync(
    MedicationDoseActionLocal object, {
    bool saveLinks = true,
  }) {
    return putByIndexSync(r'clientOperationId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByClientOperationId(
    List<MedicationDoseActionLocal> objects,
  ) {
    return putAllByIndex(r'clientOperationId', objects);
  }

  List<Id> putAllByClientOperationIdSync(
    List<MedicationDoseActionLocal> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(
      r'clientOperationId',
      objects,
      saveLinks: saveLinks,
    );
  }
}

extension MedicationDoseActionLocalQueryWhereSort
    on
        QueryBuilder<
          MedicationDoseActionLocal,
          MedicationDoseActionLocal,
          QWhere
        > {
  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterWhere
  >
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MedicationDoseActionLocalQueryWhere
    on
        QueryBuilder<
          MedicationDoseActionLocal,
          MedicationDoseActionLocal,
          QWhereClause
        > {
  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterWhereClause
  >
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterWhereClause
  >
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterWhereClause
  >
  clientOperationIdEqualTo(String clientOperationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'clientOperationId',
          value: [clientOperationId],
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterWhereClause
  >
  clientOperationIdNotEqualTo(String clientOperationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientOperationId',
                lower: [],
                upper: [clientOperationId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientOperationId',
                lower: [clientOperationId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientOperationId',
                lower: [clientOperationId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientOperationId',
                lower: [],
                upper: [clientOperationId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterWhereClause
  >
  occurrenceKeyEqualTo(String occurrenceKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'occurrenceKey',
          value: [occurrenceKey],
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterWhereClause
  >
  occurrenceKeyNotEqualTo(String occurrenceKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceKey',
                lower: [],
                upper: [occurrenceKey],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceKey',
                lower: [occurrenceKey],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceKey',
                lower: [occurrenceKey],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceKey',
                lower: [],
                upper: [occurrenceKey],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension MedicationDoseActionLocalQueryFilter
    on
        QueryBuilder<
          MedicationDoseActionLocal,
          MedicationDoseActionLocal,
          QFilterCondition
        > {
  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'actedAt', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'actedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'actedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'actedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'action',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'action',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'action',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'action',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'action',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'action',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'action',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'action',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'action', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  actionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'action', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  clientOperationIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  clientOperationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  clientOperationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  clientOperationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clientOperationId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  clientOperationIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  clientOperationIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  clientOperationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  clientOperationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'clientOperationId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  clientOperationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'clientOperationId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  clientOperationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'clientOperationId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'note'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'note'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'note',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'note',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'note',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'note', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'note', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  occurrenceKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  occurrenceKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  occurrenceKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  occurrenceKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'occurrenceKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  occurrenceKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  occurrenceKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  occurrenceKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'occurrenceKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  occurrenceKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'occurrenceKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  occurrenceKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'occurrenceKey', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterFilterCondition
  >
  occurrenceKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'occurrenceKey', value: ''),
      );
    });
  }
}

extension MedicationDoseActionLocalQueryObject
    on
        QueryBuilder<
          MedicationDoseActionLocal,
          MedicationDoseActionLocal,
          QFilterCondition
        > {}

extension MedicationDoseActionLocalQueryLinks
    on
        QueryBuilder<
          MedicationDoseActionLocal,
          MedicationDoseActionLocal,
          QFilterCondition
        > {}

extension MedicationDoseActionLocalQuerySortBy
    on
        QueryBuilder<
          MedicationDoseActionLocal,
          MedicationDoseActionLocal,
          QSortBy
        > {
  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByActedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actedAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByActedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actedAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByAction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'action', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByActionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'action', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByClientOperationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientOperationId', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByClientOperationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientOperationId', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByOccurrenceKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceKey', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  sortByOccurrenceKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceKey', Sort.desc);
    });
  }
}

extension MedicationDoseActionLocalQuerySortThenBy
    on
        QueryBuilder<
          MedicationDoseActionLocal,
          MedicationDoseActionLocal,
          QSortThenBy
        > {
  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByActedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actedAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByActedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actedAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByAction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'action', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByActionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'action', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByClientOperationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientOperationId', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByClientOperationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientOperationId', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByOccurrenceKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceKey', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationDoseActionLocal,
    MedicationDoseActionLocal,
    QAfterSortBy
  >
  thenByOccurrenceKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceKey', Sort.desc);
    });
  }
}

extension MedicationDoseActionLocalQueryWhereDistinct
    on
        QueryBuilder<
          MedicationDoseActionLocal,
          MedicationDoseActionLocal,
          QDistinct
        > {
  QueryBuilder<MedicationDoseActionLocal, MedicationDoseActionLocal, QDistinct>
  distinctByActedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actedAt');
    });
  }

  QueryBuilder<MedicationDoseActionLocal, MedicationDoseActionLocal, QDistinct>
  distinctByAction({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'action', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationDoseActionLocal, MedicationDoseActionLocal, QDistinct>
  distinctByClientOperationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'clientOperationId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MedicationDoseActionLocal, MedicationDoseActionLocal, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<MedicationDoseActionLocal, MedicationDoseActionLocal, QDistinct>
  distinctByNote({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationDoseActionLocal, MedicationDoseActionLocal, QDistinct>
  distinctByOccurrenceKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'occurrenceKey',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension MedicationDoseActionLocalQueryProperty
    on
        QueryBuilder<
          MedicationDoseActionLocal,
          MedicationDoseActionLocal,
          QQueryProperty
        > {
  QueryBuilder<MedicationDoseActionLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MedicationDoseActionLocal, DateTime, QQueryOperations>
  actedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actedAt');
    });
  }

  QueryBuilder<MedicationDoseActionLocal, String, QQueryOperations>
  actionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'action');
    });
  }

  QueryBuilder<MedicationDoseActionLocal, String, QQueryOperations>
  clientOperationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientOperationId');
    });
  }

  QueryBuilder<MedicationDoseActionLocal, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<MedicationDoseActionLocal, String?, QQueryOperations>
  noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<MedicationDoseActionLocal, String, QQueryOperations>
  occurrenceKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'occurrenceKey');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMedicationSupplyLocalCollection on Isar {
  IsarCollection<MedicationSupplyLocal> get medicationSupplyLocals =>
      this.collection();
}

const MedicationSupplyLocalSchema = CollectionSchema(
  name: r'MedicationSupplyLocal',
  id: -7320395139218838455,
  properties: {
    r'medicationClientId': PropertySchema(
      id: 0,
      name: r'medicationClientId',
      type: IsarType.string,
    ),
    r'prescriptionExpiry': PropertySchema(
      id: 1,
      name: r'prescriptionExpiry',
      type: IsarType.dateTime,
    ),
    r'quantity': PropertySchema(
      id: 2,
      name: r'quantity',
      type: IsarType.double,
    ),
    r'refillDate': PropertySchema(
      id: 3,
      name: r'refillDate',
      type: IsarType.dateTime,
    ),
    r'refillThreshold': PropertySchema(
      id: 4,
      name: r'refillThreshold',
      type: IsarType.double,
    ),
    r'unit': PropertySchema(id: 5, name: r'unit', type: IsarType.string),
    r'version': PropertySchema(id: 6, name: r'version', type: IsarType.long),
  },

  estimateSize: _medicationSupplyLocalEstimateSize,
  serialize: _medicationSupplyLocalSerialize,
  deserialize: _medicationSupplyLocalDeserialize,
  deserializeProp: _medicationSupplyLocalDeserializeProp,
  idName: r'id',
  indexes: {
    r'medicationClientId': IndexSchema(
      id: -3218765116682705184,
      name: r'medicationClientId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'medicationClientId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _medicationSupplyLocalGetId,
  getLinks: _medicationSupplyLocalGetLinks,
  attach: _medicationSupplyLocalAttach,
  version: '3.3.2',
);

int _medicationSupplyLocalEstimateSize(
  MedicationSupplyLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.medicationClientId.length * 3;
  bytesCount += 3 + object.unit.length * 3;
  return bytesCount;
}

void _medicationSupplyLocalSerialize(
  MedicationSupplyLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.medicationClientId);
  writer.writeDateTime(offsets[1], object.prescriptionExpiry);
  writer.writeDouble(offsets[2], object.quantity);
  writer.writeDateTime(offsets[3], object.refillDate);
  writer.writeDouble(offsets[4], object.refillThreshold);
  writer.writeString(offsets[5], object.unit);
  writer.writeLong(offsets[6], object.version);
}

MedicationSupplyLocal _medicationSupplyLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicationSupplyLocal();
  object.id = id;
  object.medicationClientId = reader.readString(offsets[0]);
  object.prescriptionExpiry = reader.readDateTimeOrNull(offsets[1]);
  object.quantity = reader.readDouble(offsets[2]);
  object.refillDate = reader.readDateTimeOrNull(offsets[3]);
  object.refillThreshold = reader.readDoubleOrNull(offsets[4]);
  object.unit = reader.readString(offsets[5]);
  object.version = reader.readLong(offsets[6]);
  return object;
}

P _medicationSupplyLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _medicationSupplyLocalGetId(MedicationSupplyLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _medicationSupplyLocalGetLinks(
  MedicationSupplyLocal object,
) {
  return [];
}

void _medicationSupplyLocalAttach(
  IsarCollection<dynamic> col,
  Id id,
  MedicationSupplyLocal object,
) {
  object.id = id;
}

extension MedicationSupplyLocalByIndex
    on IsarCollection<MedicationSupplyLocal> {
  Future<MedicationSupplyLocal?> getByMedicationClientId(
    String medicationClientId,
  ) {
    return getByIndex(r'medicationClientId', [medicationClientId]);
  }

  MedicationSupplyLocal? getByMedicationClientIdSync(
    String medicationClientId,
  ) {
    return getByIndexSync(r'medicationClientId', [medicationClientId]);
  }

  Future<bool> deleteByMedicationClientId(String medicationClientId) {
    return deleteByIndex(r'medicationClientId', [medicationClientId]);
  }

  bool deleteByMedicationClientIdSync(String medicationClientId) {
    return deleteByIndexSync(r'medicationClientId', [medicationClientId]);
  }

  Future<List<MedicationSupplyLocal?>> getAllByMedicationClientId(
    List<String> medicationClientIdValues,
  ) {
    final values = medicationClientIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'medicationClientId', values);
  }

  List<MedicationSupplyLocal?> getAllByMedicationClientIdSync(
    List<String> medicationClientIdValues,
  ) {
    final values = medicationClientIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'medicationClientId', values);
  }

  Future<int> deleteAllByMedicationClientId(
    List<String> medicationClientIdValues,
  ) {
    final values = medicationClientIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'medicationClientId', values);
  }

  int deleteAllByMedicationClientIdSync(List<String> medicationClientIdValues) {
    final values = medicationClientIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'medicationClientId', values);
  }

  Future<Id> putByMedicationClientId(MedicationSupplyLocal object) {
    return putByIndex(r'medicationClientId', object);
  }

  Id putByMedicationClientIdSync(
    MedicationSupplyLocal object, {
    bool saveLinks = true,
  }) {
    return putByIndexSync(r'medicationClientId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMedicationClientId(
    List<MedicationSupplyLocal> objects,
  ) {
    return putAllByIndex(r'medicationClientId', objects);
  }

  List<Id> putAllByMedicationClientIdSync(
    List<MedicationSupplyLocal> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(
      r'medicationClientId',
      objects,
      saveLinks: saveLinks,
    );
  }
}

extension MedicationSupplyLocalQueryWhereSort
    on QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QWhere> {
  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MedicationSupplyLocalQueryWhere
    on
        QueryBuilder<
          MedicationSupplyLocal,
          MedicationSupplyLocal,
          QWhereClause
        > {
  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterWhereClause>
  medicationClientIdEqualTo(String medicationClientId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'medicationClientId',
          value: [medicationClientId],
        ),
      );
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterWhereClause>
  medicationClientIdNotEqualTo(String medicationClientId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [],
                upper: [medicationClientId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [medicationClientId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [medicationClientId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicationClientId',
                lower: [],
                upper: [medicationClientId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension MedicationSupplyLocalQueryFilter
    on
        QueryBuilder<
          MedicationSupplyLocal,
          MedicationSupplyLocal,
          QFilterCondition
        > {
  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  medicationClientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  medicationClientIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  medicationClientIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  medicationClientIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'medicationClientId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  medicationClientIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  medicationClientIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  medicationClientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'medicationClientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  medicationClientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'medicationClientId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  medicationClientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'medicationClientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  medicationClientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'medicationClientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  prescriptionExpiryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'prescriptionExpiry'),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  prescriptionExpiryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'prescriptionExpiry'),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  prescriptionExpiryEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'prescriptionExpiry', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  prescriptionExpiryGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'prescriptionExpiry',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  prescriptionExpiryLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'prescriptionExpiry',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  prescriptionExpiryBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'prescriptionExpiry',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  quantityEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'quantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  quantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'quantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  quantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'quantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  quantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'quantity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'refillDate'),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'refillDate'),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'refillDate', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillDateGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'refillDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillDateLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'refillDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'refillDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillThresholdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'refillThreshold'),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillThresholdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'refillThreshold'),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillThresholdEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'refillThreshold',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillThresholdGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'refillThreshold',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillThresholdLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'refillThreshold',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  refillThresholdBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'refillThreshold',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  unitEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'unit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'unit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'unit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'unit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  unitStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'unit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  unitEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'unit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  unitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'unit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  unitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'unit',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'unit', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'unit', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'version', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  versionGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'version',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  versionLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'version',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationSupplyLocal,
    MedicationSupplyLocal,
    QAfterFilterCondition
  >
  versionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'version',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension MedicationSupplyLocalQueryObject
    on
        QueryBuilder<
          MedicationSupplyLocal,
          MedicationSupplyLocal,
          QFilterCondition
        > {}

extension MedicationSupplyLocalQueryLinks
    on
        QueryBuilder<
          MedicationSupplyLocal,
          MedicationSupplyLocal,
          QFilterCondition
        > {}

extension MedicationSupplyLocalQuerySortBy
    on QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QSortBy> {
  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByMedicationClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByMedicationClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByPrescriptionExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriptionExpiry', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByPrescriptionExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriptionExpiry', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByRefillDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillDate', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByRefillDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillDate', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByRefillThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillThreshold', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByRefillThresholdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillThreshold', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension MedicationSupplyLocalQuerySortThenBy
    on QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QSortThenBy> {
  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByMedicationClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByMedicationClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicationClientId', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByPrescriptionExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriptionExpiry', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByPrescriptionExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriptionExpiry', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByRefillDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillDate', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByRefillDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillDate', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByRefillThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillThreshold', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByRefillThresholdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillThreshold', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QAfterSortBy>
  thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension MedicationSupplyLocalQueryWhereDistinct
    on QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QDistinct> {
  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QDistinct>
  distinctByMedicationClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'medicationClientId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QDistinct>
  distinctByPrescriptionExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prescriptionExpiry');
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QDistinct>
  distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QDistinct>
  distinctByRefillDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'refillDate');
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QDistinct>
  distinctByRefillThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'refillThreshold');
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QDistinct>
  distinctByUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicationSupplyLocal, MedicationSupplyLocal, QDistinct>
  distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension MedicationSupplyLocalQueryProperty
    on
        QueryBuilder<
          MedicationSupplyLocal,
          MedicationSupplyLocal,
          QQueryProperty
        > {
  QueryBuilder<MedicationSupplyLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MedicationSupplyLocal, String, QQueryOperations>
  medicationClientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicationClientId');
    });
  }

  QueryBuilder<MedicationSupplyLocal, DateTime?, QQueryOperations>
  prescriptionExpiryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prescriptionExpiry');
    });
  }

  QueryBuilder<MedicationSupplyLocal, double, QQueryOperations>
  quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<MedicationSupplyLocal, DateTime?, QQueryOperations>
  refillDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'refillDate');
    });
  }

  QueryBuilder<MedicationSupplyLocal, double?, QQueryOperations>
  refillThresholdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'refillThreshold');
    });
  }

  QueryBuilder<MedicationSupplyLocal, String, QQueryOperations> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unit');
    });
  }

  QueryBuilder<MedicationSupplyLocal, int, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMedicationPendingOperationCollection on Isar {
  IsarCollection<MedicationPendingOperation> get medicationPendingOperations =>
      this.collection();
}

const MedicationPendingOperationSchema = CollectionSchema(
  name: r'MedicationPendingOperation',
  id: 1364834907622842238,
  properties: {
    r'attemptCount': PropertySchema(
      id: 0,
      name: r'attemptCount',
      type: IsarType.long,
    ),
    r'bodyJson': PropertySchema(
      id: 1,
      name: r'bodyJson',
      type: IsarType.string,
    ),
    r'clientOperationId': PropertySchema(
      id: 2,
      name: r'clientOperationId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'lastError': PropertySchema(
      id: 4,
      name: r'lastError',
      type: IsarType.string,
    ),
    r'nextRetryAt': PropertySchema(
      id: 5,
      name: r'nextRetryAt',
      type: IsarType.dateTime,
    ),
    r'operationType': PropertySchema(
      id: 6,
      name: r'operationType',
      type: IsarType.string,
    ),
  },

  estimateSize: _medicationPendingOperationEstimateSize,
  serialize: _medicationPendingOperationSerialize,
  deserialize: _medicationPendingOperationDeserialize,
  deserializeProp: _medicationPendingOperationDeserializeProp,
  idName: r'id',
  indexes: {
    r'clientOperationId': IndexSchema(
      id: -3703325757571940354,
      name: r'clientOperationId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'clientOperationId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _medicationPendingOperationGetId,
  getLinks: _medicationPendingOperationGetLinks,
  attach: _medicationPendingOperationAttach,
  version: '3.3.2',
);

int _medicationPendingOperationEstimateSize(
  MedicationPendingOperation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bodyJson.length * 3;
  bytesCount += 3 + object.clientOperationId.length * 3;
  {
    final value = object.lastError;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.operationType.length * 3;
  return bytesCount;
}

void _medicationPendingOperationSerialize(
  MedicationPendingOperation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.attemptCount);
  writer.writeString(offsets[1], object.bodyJson);
  writer.writeString(offsets[2], object.clientOperationId);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.lastError);
  writer.writeDateTime(offsets[5], object.nextRetryAt);
  writer.writeString(offsets[6], object.operationType);
}

MedicationPendingOperation _medicationPendingOperationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicationPendingOperation();
  object.attemptCount = reader.readLong(offsets[0]);
  object.bodyJson = reader.readString(offsets[1]);
  object.clientOperationId = reader.readString(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.id = id;
  object.lastError = reader.readStringOrNull(offsets[4]);
  object.nextRetryAt = reader.readDateTimeOrNull(offsets[5]);
  object.operationType = reader.readString(offsets[6]);
  return object;
}

P _medicationPendingOperationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _medicationPendingOperationGetId(MedicationPendingOperation object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _medicationPendingOperationGetLinks(
  MedicationPendingOperation object,
) {
  return [];
}

void _medicationPendingOperationAttach(
  IsarCollection<dynamic> col,
  Id id,
  MedicationPendingOperation object,
) {
  object.id = id;
}

extension MedicationPendingOperationByIndex
    on IsarCollection<MedicationPendingOperation> {
  Future<MedicationPendingOperation?> getByClientOperationId(
    String clientOperationId,
  ) {
    return getByIndex(r'clientOperationId', [clientOperationId]);
  }

  MedicationPendingOperation? getByClientOperationIdSync(
    String clientOperationId,
  ) {
    return getByIndexSync(r'clientOperationId', [clientOperationId]);
  }

  Future<bool> deleteByClientOperationId(String clientOperationId) {
    return deleteByIndex(r'clientOperationId', [clientOperationId]);
  }

  bool deleteByClientOperationIdSync(String clientOperationId) {
    return deleteByIndexSync(r'clientOperationId', [clientOperationId]);
  }

  Future<List<MedicationPendingOperation?>> getAllByClientOperationId(
    List<String> clientOperationIdValues,
  ) {
    final values = clientOperationIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'clientOperationId', values);
  }

  List<MedicationPendingOperation?> getAllByClientOperationIdSync(
    List<String> clientOperationIdValues,
  ) {
    final values = clientOperationIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'clientOperationId', values);
  }

  Future<int> deleteAllByClientOperationId(
    List<String> clientOperationIdValues,
  ) {
    final values = clientOperationIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'clientOperationId', values);
  }

  int deleteAllByClientOperationIdSync(List<String> clientOperationIdValues) {
    final values = clientOperationIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'clientOperationId', values);
  }

  Future<Id> putByClientOperationId(MedicationPendingOperation object) {
    return putByIndex(r'clientOperationId', object);
  }

  Id putByClientOperationIdSync(
    MedicationPendingOperation object, {
    bool saveLinks = true,
  }) {
    return putByIndexSync(r'clientOperationId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByClientOperationId(
    List<MedicationPendingOperation> objects,
  ) {
    return putAllByIndex(r'clientOperationId', objects);
  }

  List<Id> putAllByClientOperationIdSync(
    List<MedicationPendingOperation> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(
      r'clientOperationId',
      objects,
      saveLinks: saveLinks,
    );
  }
}

extension MedicationPendingOperationQueryWhereSort
    on
        QueryBuilder<
          MedicationPendingOperation,
          MedicationPendingOperation,
          QWhere
        > {
  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterWhere
  >
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MedicationPendingOperationQueryWhere
    on
        QueryBuilder<
          MedicationPendingOperation,
          MedicationPendingOperation,
          QWhereClause
        > {
  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterWhereClause
  >
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterWhereClause
  >
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterWhereClause
  >
  clientOperationIdEqualTo(String clientOperationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'clientOperationId',
          value: [clientOperationId],
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterWhereClause
  >
  clientOperationIdNotEqualTo(String clientOperationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientOperationId',
                lower: [],
                upper: [clientOperationId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientOperationId',
                lower: [clientOperationId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientOperationId',
                lower: [clientOperationId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'clientOperationId',
                lower: [],
                upper: [clientOperationId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension MedicationPendingOperationQueryFilter
    on
        QueryBuilder<
          MedicationPendingOperation,
          MedicationPendingOperation,
          QFilterCondition
        > {
  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  attemptCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'attemptCount', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  attemptCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'attemptCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  attemptCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'attemptCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  attemptCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'attemptCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  bodyJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bodyJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  bodyJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bodyJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  bodyJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bodyJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  bodyJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bodyJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  bodyJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'bodyJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  bodyJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'bodyJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  bodyJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'bodyJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  bodyJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'bodyJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  bodyJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bodyJson', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  bodyJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'bodyJson', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  clientOperationIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  clientOperationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  clientOperationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  clientOperationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clientOperationId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  clientOperationIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  clientOperationIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  clientOperationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'clientOperationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  clientOperationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'clientOperationId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  clientOperationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'clientOperationId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  clientOperationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'clientOperationId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastError'),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastError'),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lastError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastError',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'lastError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'lastError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'lastError',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'lastError',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastError', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  lastErrorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'lastError', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  nextRetryAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'nextRetryAt'),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  nextRetryAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'nextRetryAt'),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  nextRetryAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nextRetryAt', value: value),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  nextRetryAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nextRetryAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  nextRetryAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nextRetryAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  nextRetryAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nextRetryAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  operationTypeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'operationType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  operationTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'operationType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  operationTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'operationType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  operationTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'operationType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  operationTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'operationType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  operationTypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'operationType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  operationTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'operationType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  operationTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'operationType',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  operationTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'operationType', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterFilterCondition
  >
  operationTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'operationType', value: ''),
      );
    });
  }
}

extension MedicationPendingOperationQueryObject
    on
        QueryBuilder<
          MedicationPendingOperation,
          MedicationPendingOperation,
          QFilterCondition
        > {}

extension MedicationPendingOperationQueryLinks
    on
        QueryBuilder<
          MedicationPendingOperation,
          MedicationPendingOperation,
          QFilterCondition
        > {}

extension MedicationPendingOperationQuerySortBy
    on
        QueryBuilder<
          MedicationPendingOperation,
          MedicationPendingOperation,
          QSortBy
        > {
  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByAttemptCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByBodyJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyJson', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByBodyJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyJson', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByClientOperationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientOperationId', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByClientOperationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientOperationId', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByLastError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByLastErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByNextRetryAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRetryAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByNextRetryAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRetryAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByOperationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operationType', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  sortByOperationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operationType', Sort.desc);
    });
  }
}

extension MedicationPendingOperationQuerySortThenBy
    on
        QueryBuilder<
          MedicationPendingOperation,
          MedicationPendingOperation,
          QSortThenBy
        > {
  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByAttemptCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByBodyJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyJson', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByBodyJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyJson', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByClientOperationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientOperationId', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByClientOperationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientOperationId', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByLastError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByLastErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByNextRetryAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRetryAt', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByNextRetryAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRetryAt', Sort.desc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByOperationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operationType', Sort.asc);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QAfterSortBy
  >
  thenByOperationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operationType', Sort.desc);
    });
  }
}

extension MedicationPendingOperationQueryWhereDistinct
    on
        QueryBuilder<
          MedicationPendingOperation,
          MedicationPendingOperation,
          QDistinct
        > {
  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QDistinct
  >
  distinctByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'attemptCount');
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QDistinct
  >
  distinctByBodyJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bodyJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QDistinct
  >
  distinctByClientOperationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'clientOperationId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QDistinct
  >
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QDistinct
  >
  distinctByLastError({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastError', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QDistinct
  >
  distinctByNextRetryAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextRetryAt');
    });
  }

  QueryBuilder<
    MedicationPendingOperation,
    MedicationPendingOperation,
    QDistinct
  >
  distinctByOperationType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'operationType',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension MedicationPendingOperationQueryProperty
    on
        QueryBuilder<
          MedicationPendingOperation,
          MedicationPendingOperation,
          QQueryProperty
        > {
  QueryBuilder<MedicationPendingOperation, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MedicationPendingOperation, int, QQueryOperations>
  attemptCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attemptCount');
    });
  }

  QueryBuilder<MedicationPendingOperation, String, QQueryOperations>
  bodyJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bodyJson');
    });
  }

  QueryBuilder<MedicationPendingOperation, String, QQueryOperations>
  clientOperationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientOperationId');
    });
  }

  QueryBuilder<MedicationPendingOperation, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<MedicationPendingOperation, String?, QQueryOperations>
  lastErrorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastError');
    });
  }

  QueryBuilder<MedicationPendingOperation, DateTime?, QQueryOperations>
  nextRetryAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextRetryAt');
    });
  }

  QueryBuilder<MedicationPendingOperation, String, QQueryOperations>
  operationTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'operationType');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MedicationDoseSlotLocalSchema = Schema(
  name: r'MedicationDoseSlotLocal',
  id: 5271945634687725673,
  properties: {
    r'clientId': PropertySchema(
      id: 0,
      name: r'clientId',
      type: IsarType.string,
    ),
    r'doseQuantity': PropertySchema(
      id: 1,
      name: r'doseQuantity',
      type: IsarType.double,
    ),
    r'doseUnit': PropertySchema(
      id: 2,
      name: r'doseUnit',
      type: IsarType.string,
    ),
    r'instructions': PropertySchema(
      id: 3,
      name: r'instructions',
      type: IsarType.string,
    ),
    r'localTime': PropertySchema(
      id: 4,
      name: r'localTime',
      type: IsarType.string,
    ),
  },

  estimateSize: _medicationDoseSlotLocalEstimateSize,
  serialize: _medicationDoseSlotLocalSerialize,
  deserialize: _medicationDoseSlotLocalDeserialize,
  deserializeProp: _medicationDoseSlotLocalDeserializeProp,
);

int _medicationDoseSlotLocalEstimateSize(
  MedicationDoseSlotLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.clientId.length * 3;
  bytesCount += 3 + object.doseUnit.length * 3;
  {
    final value = object.instructions;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.localTime.length * 3;
  return bytesCount;
}

void _medicationDoseSlotLocalSerialize(
  MedicationDoseSlotLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.clientId);
  writer.writeDouble(offsets[1], object.doseQuantity);
  writer.writeString(offsets[2], object.doseUnit);
  writer.writeString(offsets[3], object.instructions);
  writer.writeString(offsets[4], object.localTime);
}

MedicationDoseSlotLocal _medicationDoseSlotLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicationDoseSlotLocal();
  object.clientId = reader.readString(offsets[0]);
  object.doseQuantity = reader.readDouble(offsets[1]);
  object.doseUnit = reader.readString(offsets[2]);
  object.instructions = reader.readStringOrNull(offsets[3]);
  object.localTime = reader.readString(offsets[4]);
  return object;
}

P _medicationDoseSlotLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MedicationDoseSlotLocalQueryFilter
    on
        QueryBuilder<
          MedicationDoseSlotLocal,
          MedicationDoseSlotLocal,
          QFilterCondition
        > {
  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  clientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  clientIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  clientIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  clientIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clientId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  clientIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  clientIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  clientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'clientId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  clientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'clientId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  clientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'clientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  clientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'clientId', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseQuantityEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'doseQuantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseQuantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'doseQuantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseQuantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'doseQuantity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseQuantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'doseQuantity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseUnitEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseUnitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseUnitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseUnitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'doseUnit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseUnitStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseUnitEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'doseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'doseUnit',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'doseUnit', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  doseUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'doseUnit', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'instructions'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'instructions'),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'instructions',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'instructions',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'instructions', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  instructionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'instructions', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  localTimeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'localTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  localTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'localTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  localTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'localTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  localTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'localTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  localTimeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'localTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  localTimeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'localTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  localTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'localTime',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  localTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'localTime',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  localTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localTime', value: ''),
      );
    });
  }

  QueryBuilder<
    MedicationDoseSlotLocal,
    MedicationDoseSlotLocal,
    QAfterFilterCondition
  >
  localTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'localTime', value: ''),
      );
    });
  }
}

extension MedicationDoseSlotLocalQueryObject
    on
        QueryBuilder<
          MedicationDoseSlotLocal,
          MedicationDoseSlotLocal,
          QFilterCondition
        > {}
