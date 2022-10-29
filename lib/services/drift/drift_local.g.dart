// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_local.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String email;
  final String name;
  final String tanggal_lahir;
  final String alamat;
  final String kota;
  final String provinsi;
  const User(
      {required this.id,
      required this.username,
      required this.email,
      required this.name,
      required this.tanggal_lahir,
      required this.alamat,
      required this.kota,
      required this.provinsi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['email'] = Variable<String>(email);
    map['name'] = Variable<String>(name);
    map['tanggal_lahir'] = Variable<String>(tanggal_lahir);
    map['alamat'] = Variable<String>(alamat);
    map['kota'] = Variable<String>(kota);
    map['provinsi'] = Variable<String>(provinsi);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      email: Value(email),
      name: Value(name),
      tanggal_lahir: Value(tanggal_lahir),
      alamat: Value(alamat),
      kota: Value(kota),
      provinsi: Value(provinsi),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String>(json['email']),
      name: serializer.fromJson<String>(json['name']),
      tanggal_lahir: serializer.fromJson<String>(json['tanggal_lahir']),
      alamat: serializer.fromJson<String>(json['alamat']),
      kota: serializer.fromJson<String>(json['kota']),
      provinsi: serializer.fromJson<String>(json['provinsi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String>(email),
      'name': serializer.toJson<String>(name),
      'tanggal_lahir': serializer.toJson<String>(tanggal_lahir),
      'alamat': serializer.toJson<String>(alamat),
      'kota': serializer.toJson<String>(kota),
      'provinsi': serializer.toJson<String>(provinsi),
    };
  }

  User copyWith(
          {int? id,
          String? username,
          String? email,
          String? name,
          String? tanggal_lahir,
          String? alamat,
          String? kota,
          String? provinsi}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        name: name ?? this.name,
        tanggal_lahir: tanggal_lahir ?? this.tanggal_lahir,
        alamat: alamat ?? this.alamat,
        kota: kota ?? this.kota,
        provinsi: provinsi ?? this.provinsi,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('tanggal_lahir: $tanggal_lahir, ')
          ..write('alamat: $alamat, ')
          ..write('kota: $kota, ')
          ..write('provinsi: $provinsi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, username, email, name, tanggal_lahir, alamat, kota, provinsi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.email == this.email &&
          other.name == this.name &&
          other.tanggal_lahir == this.tanggal_lahir &&
          other.alamat == this.alamat &&
          other.kota == this.kota &&
          other.provinsi == this.provinsi);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> email;
  final Value<String> name;
  final Value<String> tanggal_lahir;
  final Value<String> alamat;
  final Value<String> kota;
  final Value<String> provinsi;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.tanggal_lahir = const Value.absent(),
    this.alamat = const Value.absent(),
    this.kota = const Value.absent(),
    this.provinsi = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String email,
    required String name,
    required String tanggal_lahir,
    required String alamat,
    required String kota,
    required String provinsi,
  })  : username = Value(username),
        email = Value(email),
        name = Value(name),
        tanggal_lahir = Value(tanggal_lahir),
        alamat = Value(alamat),
        kota = Value(kota),
        provinsi = Value(provinsi);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? name,
    Expression<String>? tanggal_lahir,
    Expression<String>? alamat,
    Expression<String>? kota,
    Expression<String>? provinsi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (tanggal_lahir != null) 'tanggal_lahir': tanggal_lahir,
      if (alamat != null) 'alamat': alamat,
      if (kota != null) 'kota': kota,
      if (provinsi != null) 'provinsi': provinsi,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? email,
      Value<String>? name,
      Value<String>? tanggal_lahir,
      Value<String>? alamat,
      Value<String>? kota,
      Value<String>? provinsi}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      name: name ?? this.name,
      tanggal_lahir: tanggal_lahir ?? this.tanggal_lahir,
      alamat: alamat ?? this.alamat,
      kota: kota ?? this.kota,
      provinsi: provinsi ?? this.provinsi,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (tanggal_lahir.present) {
      map['tanggal_lahir'] = Variable<String>(tanggal_lahir.value);
    }
    if (alamat.present) {
      map['alamat'] = Variable<String>(alamat.value);
    }
    if (kota.present) {
      map['kota'] = Variable<String>(kota.value);
    }
    if (provinsi.present) {
      map['provinsi'] = Variable<String>(provinsi.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('tanggal_lahir: $tanggal_lahir, ')
          ..write('alamat: $alamat, ')
          ..write('kota: $kota, ')
          ..write('provinsi: $provinsi')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _tanggal_lahirMeta =
      const VerificationMeta('tanggal_lahir');
  @override
  late final GeneratedColumn<String> tanggal_lahir = GeneratedColumn<String>(
      'tanggal_lahir', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _alamatMeta = const VerificationMeta('alamat');
  @override
  late final GeneratedColumn<String> alamat = GeneratedColumn<String>(
      'alamat', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _kotaMeta = const VerificationMeta('kota');
  @override
  late final GeneratedColumn<String> kota = GeneratedColumn<String>(
      'kota', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _provinsiMeta = const VerificationMeta('provinsi');
  @override
  late final GeneratedColumn<String> provinsi = GeneratedColumn<String>(
      'provinsi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, username, email, name, tanggal_lahir, alamat, kota, provinsi];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('tanggal_lahir')) {
      context.handle(
          _tanggal_lahirMeta,
          tanggal_lahir.isAcceptableOrUnknown(
              data['tanggal_lahir']!, _tanggal_lahirMeta));
    } else if (isInserting) {
      context.missing(_tanggal_lahirMeta);
    }
    if (data.containsKey('alamat')) {
      context.handle(_alamatMeta,
          alamat.isAcceptableOrUnknown(data['alamat']!, _alamatMeta));
    } else if (isInserting) {
      context.missing(_alamatMeta);
    }
    if (data.containsKey('kota')) {
      context.handle(
          _kotaMeta, kota.isAcceptableOrUnknown(data['kota']!, _kotaMeta));
    } else if (isInserting) {
      context.missing(_kotaMeta);
    }
    if (data.containsKey('provinsi')) {
      context.handle(_provinsiMeta,
          provinsi.isAcceptableOrUnknown(data['provinsi']!, _provinsiMeta));
    } else if (isInserting) {
      context.missing(_provinsiMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      email: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      tanggal_lahir: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}tanggal_lahir'])!,
      alamat: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}alamat'])!,
      kota: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}kota'])!,
      provinsi: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}provinsi'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
}
