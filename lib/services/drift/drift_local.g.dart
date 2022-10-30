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

class Aktivita extends DataClass implements Insertable<Aktivita> {
  final int id;
  final int user_id;
  final String tanggal_aktivitas;
  final String hari_aktivitas;
  final String absen_pagi;
  final String absen_siang;
  final String absen_malem;
  const Aktivita(
      {required this.id,
      required this.user_id,
      required this.tanggal_aktivitas,
      required this.hari_aktivitas,
      required this.absen_pagi,
      required this.absen_siang,
      required this.absen_malem});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(user_id);
    map['tanggal_aktivitas'] = Variable<String>(tanggal_aktivitas);
    map['hari_aktivitas'] = Variable<String>(hari_aktivitas);
    map['absen_pagi'] = Variable<String>(absen_pagi);
    map['absen_siang'] = Variable<String>(absen_siang);
    map['absen_malem'] = Variable<String>(absen_malem);
    return map;
  }

  AktivitasCompanion toCompanion(bool nullToAbsent) {
    return AktivitasCompanion(
      id: Value(id),
      user_id: Value(user_id),
      tanggal_aktivitas: Value(tanggal_aktivitas),
      hari_aktivitas: Value(hari_aktivitas),
      absen_pagi: Value(absen_pagi),
      absen_siang: Value(absen_siang),
      absen_malem: Value(absen_malem),
    );
  }

  factory Aktivita.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Aktivita(
      id: serializer.fromJson<int>(json['id']),
      user_id: serializer.fromJson<int>(json['user_id']),
      tanggal_aktivitas: serializer.fromJson<String>(json['tanggal_aktivitas']),
      hari_aktivitas: serializer.fromJson<String>(json['hari_aktivitas']),
      absen_pagi: serializer.fromJson<String>(json['absen_pagi']),
      absen_siang: serializer.fromJson<String>(json['absen_siang']),
      absen_malem: serializer.fromJson<String>(json['absen_malem']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'user_id': serializer.toJson<int>(user_id),
      'tanggal_aktivitas': serializer.toJson<String>(tanggal_aktivitas),
      'hari_aktivitas': serializer.toJson<String>(hari_aktivitas),
      'absen_pagi': serializer.toJson<String>(absen_pagi),
      'absen_siang': serializer.toJson<String>(absen_siang),
      'absen_malem': serializer.toJson<String>(absen_malem),
    };
  }

  Aktivita copyWith(
          {int? id,
          int? user_id,
          String? tanggal_aktivitas,
          String? hari_aktivitas,
          String? absen_pagi,
          String? absen_siang,
          String? absen_malem}) =>
      Aktivita(
        id: id ?? this.id,
        user_id: user_id ?? this.user_id,
        tanggal_aktivitas: tanggal_aktivitas ?? this.tanggal_aktivitas,
        hari_aktivitas: hari_aktivitas ?? this.hari_aktivitas,
        absen_pagi: absen_pagi ?? this.absen_pagi,
        absen_siang: absen_siang ?? this.absen_siang,
        absen_malem: absen_malem ?? this.absen_malem,
      );
  @override
  String toString() {
    return (StringBuffer('Aktivita(')
          ..write('id: $id, ')
          ..write('user_id: $user_id, ')
          ..write('tanggal_aktivitas: $tanggal_aktivitas, ')
          ..write('hari_aktivitas: $hari_aktivitas, ')
          ..write('absen_pagi: $absen_pagi, ')
          ..write('absen_siang: $absen_siang, ')
          ..write('absen_malem: $absen_malem')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, user_id, tanggal_aktivitas,
      hari_aktivitas, absen_pagi, absen_siang, absen_malem);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Aktivita &&
          other.id == this.id &&
          other.user_id == this.user_id &&
          other.tanggal_aktivitas == this.tanggal_aktivitas &&
          other.hari_aktivitas == this.hari_aktivitas &&
          other.absen_pagi == this.absen_pagi &&
          other.absen_siang == this.absen_siang &&
          other.absen_malem == this.absen_malem);
}

class AktivitasCompanion extends UpdateCompanion<Aktivita> {
  final Value<int> id;
  final Value<int> user_id;
  final Value<String> tanggal_aktivitas;
  final Value<String> hari_aktivitas;
  final Value<String> absen_pagi;
  final Value<String> absen_siang;
  final Value<String> absen_malem;
  const AktivitasCompanion({
    this.id = const Value.absent(),
    this.user_id = const Value.absent(),
    this.tanggal_aktivitas = const Value.absent(),
    this.hari_aktivitas = const Value.absent(),
    this.absen_pagi = const Value.absent(),
    this.absen_siang = const Value.absent(),
    this.absen_malem = const Value.absent(),
  });
  AktivitasCompanion.insert({
    this.id = const Value.absent(),
    required int user_id,
    required String tanggal_aktivitas,
    required String hari_aktivitas,
    required String absen_pagi,
    required String absen_siang,
    required String absen_malem,
  })  : user_id = Value(user_id),
        tanggal_aktivitas = Value(tanggal_aktivitas),
        hari_aktivitas = Value(hari_aktivitas),
        absen_pagi = Value(absen_pagi),
        absen_siang = Value(absen_siang),
        absen_malem = Value(absen_malem);
  static Insertable<Aktivita> custom({
    Expression<int>? id,
    Expression<int>? user_id,
    Expression<String>? tanggal_aktivitas,
    Expression<String>? hari_aktivitas,
    Expression<String>? absen_pagi,
    Expression<String>? absen_siang,
    Expression<String>? absen_malem,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (user_id != null) 'user_id': user_id,
      if (tanggal_aktivitas != null) 'tanggal_aktivitas': tanggal_aktivitas,
      if (hari_aktivitas != null) 'hari_aktivitas': hari_aktivitas,
      if (absen_pagi != null) 'absen_pagi': absen_pagi,
      if (absen_siang != null) 'absen_siang': absen_siang,
      if (absen_malem != null) 'absen_malem': absen_malem,
    });
  }

  AktivitasCompanion copyWith(
      {Value<int>? id,
      Value<int>? user_id,
      Value<String>? tanggal_aktivitas,
      Value<String>? hari_aktivitas,
      Value<String>? absen_pagi,
      Value<String>? absen_siang,
      Value<String>? absen_malem}) {
    return AktivitasCompanion(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      tanggal_aktivitas: tanggal_aktivitas ?? this.tanggal_aktivitas,
      hari_aktivitas: hari_aktivitas ?? this.hari_aktivitas,
      absen_pagi: absen_pagi ?? this.absen_pagi,
      absen_siang: absen_siang ?? this.absen_siang,
      absen_malem: absen_malem ?? this.absen_malem,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (user_id.present) {
      map['user_id'] = Variable<int>(user_id.value);
    }
    if (tanggal_aktivitas.present) {
      map['tanggal_aktivitas'] = Variable<String>(tanggal_aktivitas.value);
    }
    if (hari_aktivitas.present) {
      map['hari_aktivitas'] = Variable<String>(hari_aktivitas.value);
    }
    if (absen_pagi.present) {
      map['absen_pagi'] = Variable<String>(absen_pagi.value);
    }
    if (absen_siang.present) {
      map['absen_siang'] = Variable<String>(absen_siang.value);
    }
    if (absen_malem.present) {
      map['absen_malem'] = Variable<String>(absen_malem.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AktivitasCompanion(')
          ..write('id: $id, ')
          ..write('user_id: $user_id, ')
          ..write('tanggal_aktivitas: $tanggal_aktivitas, ')
          ..write('hari_aktivitas: $hari_aktivitas, ')
          ..write('absen_pagi: $absen_pagi, ')
          ..write('absen_siang: $absen_siang, ')
          ..write('absen_malem: $absen_malem')
          ..write(')'))
        .toString();
  }
}

class $AktivitasTable extends Aktivitas
    with TableInfo<$AktivitasTable, Aktivita> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AktivitasTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _user_idMeta = const VerificationMeta('user_id');
  @override
  late final GeneratedColumn<int> user_id = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _tanggal_aktivitasMeta =
      const VerificationMeta('tanggal_aktivitas');
  @override
  late final GeneratedColumn<String> tanggal_aktivitas =
      GeneratedColumn<String>('tanggal_aktivitas', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _hari_aktivitasMeta =
      const VerificationMeta('hari_aktivitas');
  @override
  late final GeneratedColumn<String> hari_aktivitas = GeneratedColumn<String>(
      'hari_aktivitas', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _absen_pagiMeta = const VerificationMeta('absen_pagi');
  @override
  late final GeneratedColumn<String> absen_pagi = GeneratedColumn<String>(
      'absen_pagi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _absen_siangMeta =
      const VerificationMeta('absen_siang');
  @override
  late final GeneratedColumn<String> absen_siang = GeneratedColumn<String>(
      'absen_siang', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _absen_malemMeta =
      const VerificationMeta('absen_malem');
  @override
  late final GeneratedColumn<String> absen_malem = GeneratedColumn<String>(
      'absen_malem', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        user_id,
        tanggal_aktivitas,
        hari_aktivitas,
        absen_pagi,
        absen_siang,
        absen_malem
      ];
  @override
  String get aliasedName => _alias ?? 'aktivitas';
  @override
  String get actualTableName => 'aktivitas';
  @override
  VerificationContext validateIntegrity(Insertable<Aktivita> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_user_idMeta,
          user_id.isAcceptableOrUnknown(data['user_id']!, _user_idMeta));
    } else if (isInserting) {
      context.missing(_user_idMeta);
    }
    if (data.containsKey('tanggal_aktivitas')) {
      context.handle(
          _tanggal_aktivitasMeta,
          tanggal_aktivitas.isAcceptableOrUnknown(
              data['tanggal_aktivitas']!, _tanggal_aktivitasMeta));
    } else if (isInserting) {
      context.missing(_tanggal_aktivitasMeta);
    }
    if (data.containsKey('hari_aktivitas')) {
      context.handle(
          _hari_aktivitasMeta,
          hari_aktivitas.isAcceptableOrUnknown(
              data['hari_aktivitas']!, _hari_aktivitasMeta));
    } else if (isInserting) {
      context.missing(_hari_aktivitasMeta);
    }
    if (data.containsKey('absen_pagi')) {
      context.handle(
          _absen_pagiMeta,
          absen_pagi.isAcceptableOrUnknown(
              data['absen_pagi']!, _absen_pagiMeta));
    } else if (isInserting) {
      context.missing(_absen_pagiMeta);
    }
    if (data.containsKey('absen_siang')) {
      context.handle(
          _absen_siangMeta,
          absen_siang.isAcceptableOrUnknown(
              data['absen_siang']!, _absen_siangMeta));
    } else if (isInserting) {
      context.missing(_absen_siangMeta);
    }
    if (data.containsKey('absen_malem')) {
      context.handle(
          _absen_malemMeta,
          absen_malem.isAcceptableOrUnknown(
              data['absen_malem']!, _absen_malemMeta));
    } else if (isInserting) {
      context.missing(_absen_malemMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Aktivita map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Aktivita(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      user_id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      tanggal_aktivitas: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}tanggal_aktivitas'])!,
      hari_aktivitas: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}hari_aktivitas'])!,
      absen_pagi: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}absen_pagi'])!,
      absen_siang: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}absen_siang'])!,
      absen_malem: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}absen_malem'])!,
    );
  }

  @override
  $AktivitasTable createAlias(String alias) {
    return $AktivitasTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  late final $AktivitasTable aktivitas = $AktivitasTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final AktivitaDao aktivitaDao = AktivitaDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users, aktivitas];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
}
mixin _$AktivitaDaoMixin on DatabaseAccessor<AppDatabase> {
  $AktivitasTable get aktivitas => attachedDatabase.aktivitas;
}
