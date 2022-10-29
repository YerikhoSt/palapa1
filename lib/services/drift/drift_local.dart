import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
part 'drift_local.g.dart';

class Users extends Table {
  IntColumn get id => integer()();
  TextColumn get username => text()();
  TextColumn get email => text()();
  TextColumn get name => text()();
  TextColumn get tanggal_lahir => text()();
  TextColumn get alamat => text()();
  TextColumn get kota => text()();
  TextColumn get provinsi => text()();

  @override
  Set<Column<Object>> get primaryKey => <IntColumn>{id};
}

class Jadwals extends Table {
  IntColumn get id => integer()();
  IntColumn get user_id => integer()();
  DateTimeColumn get tanggal => dateTime()();
  IntColumn get perineometri => integer()();
  IntColumn get pad_test => integer()();
  IntColumn get udi => integer()();
  IntColumn get iiq => integer()();

  @override
  Set<Column<Object>> get primaryKey => <IntColumn>{id};
}

class Aktivitas extends Table {
  IntColumn get id => integer()();
  IntColumn get user_id => integer()();
  DateTimeColumn get tanggal_aktivitas => dateTime()();
  BoolColumn get absen_pagi => boolean()();
  BoolColumn get absen_siang => boolean()();
  BoolColumn get absen_malem => boolean()();

  @override
  Set<Column<Object>> get primaryKey => <IntColumn>{id};
}

@DriftDatabase(
  tables: <Type>[Users],
  daos: <Type>[UserDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          SqfliteQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite',
            logStatements: true,
          ),
        );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (Migrator migrator, int from, int to) async {},
        onCreate: (Migrator m) {
          return m.createAll();
        },
      );
}

@DriftAccessor(tables: <Type>[Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  final AppDatabase database;
  UserDao(this.database) : super(database);

  Future<User?> getUserById(int id) =>
      (select(users)..where(($UsersTable t) => t.id.equals(id)))
          .getSingleOrNull();
}
